.. currentmodule:: evalhyd
.. default-role:: obj

Use *evalhyd* to evaluate GloFAS reforecast data
================================================

.. important::
   This tutorial contains modified Copernicus Emergency Management Service
   information 2024. Neither the European Commission nor ECMWF is responsible
   for any use that may be made of the Copernicus information or data it contains.

The prediction data used in this tutorial is the GloFAS v2.2 river discharge
reforecast data [1]_ produced by Zsoter et al. (2020) [2]_.

The observation data used in this tutorial is the GloFAS-ERA5 v2.1 river
discharge reanalysis data [3]_ produced by Harrigan et al. (2021) [4]_.

These can both be downloaded from Copernicus’ `Climate Data Store
<https://cds.climate.copernicus.eu>`_.

These datasets were downloaded as GRIB files before a subset of them was
performed to extract specific grid boxes corresponding to the GloFAS stations
G0518, G0554, and G0565 and stored as NetCDF files. The prediction and
observation data for these three stations is made available on the GitHub
page hosting this documentation (`<https://github.com/hydrogr/evalhyd>`_).

Load the prediction and observation data
----------------------------------------

The NetCDF prediction and observation data mentioned above must first be read
at once as a multi-sites dataset. This can easily be done in Python using a
library such as `xarray`.

.. code-block:: python
   :caption: Read in the prediction and observation data using `xarray`

   import xarray as xr

   def add_station_as_coord(xd):
       stn = xd.encoding['source'].split('_')[-1].split('.nc')[0]
       xd['dis24'] = xd['dis24'].assign_coords(station=stn)
       return xd

   prd = xr.open_mfdataset(
       'GloFAS-v2.2_river_discharge_reforecast_*.nc',
       preprocess=add_station_as_coord,
       combine='nested',
       concat_dim='station'
   )['dis24']

   obs = xr.open_mfdataset(
       'GloFAS-ERA5_v2.1_river_discharge_reanalysis_*.nc',
       preprocess=add_station_as_coord,
       combine='nested',
       concat_dim='station'
   )['dis24']


.. code-block:: python
   :caption: Reorder the dimensions to follow `evalhyd` convention

   prd = prd.transpose(
       'station',  # sites
       'step',  # lead times
       'number',  # members
       'time'  # time
   )
   obs = obs.transpose(
       'station',  # sites
       'time'  # time
   )

Align the prediction and the observation dates
----------------------------------------------

`evalhyd` expects to be given prediction and observation data whose time
dimensions correspond to the same dates. These are the dates for which
prediction data is valid for (i.e. issue date + lead time), rather than
the dates for which prediction data was issued.

.. code-block:: python
   :caption: Replace the observation *time* dimension coordinate with *valid_time* coordinate so that the *time* dimension can be used to get temporal subsets corresponding to the prediction data

   obs['time'] = obs.valid_time

.. code-block:: python
   :caption: Determine necessary observation data dates

   dts = np.unique(prd.valid_time.values)


.. code-block:: python
   :caption: Map prediction data onto observation dates

   import numpy as np

   prd_arr = np.zeros(
       (prd.station.size, prd.step.size, prd.number.size, dts.size)
   )
   prd_arr[:] = np.nan

   for s in range(prd.step.size):
       # get mask selecting dates where a prediction exists
       msk = np.in1d(dts, prd.valid_time.isel(step=s))
       # use mask to map prediction data into array
       prd_arr[:, s, :, :][:, :, msk] = prd.values[:, s, :, :]
       prd_arr[:, s, :, :][:, :, msk] = prd.values[:, s, :, :]

Compute scores to evaluate the prediction against the observation data
----------------------------------------------------------------------

Now that the prediction and observation dates are aligned, `evalhyd` can
be used to compute any of the :doc:`probabilistic metrics <../../metrics/probabilistic>`
it gives access to. Here, we show how to compute the CRPS computed from
the empirical cumulative density function.

.. code-block:: python
   :caption: Compute thresholds from climatology quantiles

   thr = np.quantile(obs.values, 0.1, axis=1, keepdims=True)

.. code-block:: python
   :caption: compute the CRPS probabilistic score using `evalhyd`
   
   import evalhyd

   crps_forecast, = evalhyd.evalp(
       q_obs=obs.sel(time=dts).values,
       q_prd=prd_arr,
       metrics=['CRPS_FROM_ECDF'],
       q_thr=thr,
       events='low'
   )

Prepare benchmarks in view to compute skill scores from scores
--------------------------------------------------------------

As done by Harrigan et al. (2023) [5]_, persistence and climatology benchmarks
are often used as references to produce dimensionless skill scores from
evaluation scores. Here, we will compute the CRPSS from the CRPS.

Persistence benchmark
^^^^^^^^^^^^^^^^^^^^^

The persistence benchmark can be described as follows:

.. epigraph::

   « Persistence benchmark forecast is defined as the single GloFAS-ERA5
   daily river discharge of the day preceding the reforecast start
   date. The same river discharge value is used for all lead times.
   For example, for a forecast issued on 3 January at 00:00 UTC, the
   persistence benchmark forecast is the average river discharge over
   the 24 h time step from 2 January 00:00 UTC to 3 January 00:00 UTC,
   and the same value is used as benchmark for all 30 lead times
   (i.e., 4 January to 2 February). »

   --  Harrigan et al. (2023) [5]_, sect. 3.2

.. code-block:: python
   :caption: Map persistence benchmark onto observations dates

   prs_arr = np.zeros(
       (prd.station.size, prd.step.size, dts.size)
   )
   prs_arr[:] = np.nan

   for s in range(prd.step.size):
       # get mask selecting dates where a forecast exists
       msk = np.in1d(dts, prd.valid_time.isel(step=s))
       # use mask to map observation data into array
       prs_arr[:, s, :][:, msk] = obs.sel(time=prd.time).values


.. code-block:: python
   :caption: Compute the persistence benchmark CRPS one site at a time because `evalhyd` deterministic evaluation is 2D-only

   crps_persistence = np.zeros(
       (prd.station.size, prd.step.size, 1, 1)
   )
   crps_persistence[:] = np.nan

   for s in range(prd.station.size):
       crps_persistence[s] = evalhyd.evald(
           q_obs=obs.isel(station=s).sel(time=dts).values[np.newaxis, :],
           q_prd=prs_arr[s].copy(),
           metrics=['MAE']
       )[0]


.. note::

   Since, for a deterministic forecast, the CRPS is equal to the MAE,
   the deterministic metric MAE is used for the persistence benchmark.

Climatology benchmark
^^^^^^^^^^^^^^^^^^^^^

The climatology benchmark can be described as follows:

.. epigraph::

   « Climatology benchmark forecast is based on a 40-year climatological
   sample (1979–2018) of moving 31 d windows of GloFAS-ERA5 river
   discharge reanalysis values, centred on the date being evaluated
   (±15 d). From each 1240-valued climatological sample (i.e. 40 years
   × 31 d window), 11 fixed quantiles (Qn) at 10 % intervals were
   extracted (Q0, Q10, Q20, …, Q80, Q90, Q100). The fixed quantile
   climate distribution used therefore varies by lead time, capturing
   the temporal variability in local river discharge climatology. »

   --  Harrigan et al. (2023) [5]_, sect. 3.2

.. code-block:: python
   :caption: Apply 31-day rolling windows on 40-year climatological sample

   wdw = obs.sel(time=slice('1979', '2018')).rolling(time=31, center=True)

.. code-block:: python
   :caption: Compute quantiles for each day of year over time and window (i.e. across 40y and 31d)

   qtl = wdw.construct('window').chunk({"time": -1}).groupby('time.dayofyear').quantile(
       [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
       dim=('time', 'window')
   )

.. code-block:: python
   :caption: Map climatology benchmark onto observation dates

   clm_arr = np.zeros((prd.station.size, prd.step.size, prd.number.size, dts.size))
   clm_arr[:] = np.nan

   for s in range(prd.step.size):
       # get mask selecting dates where a forecast exists
       msk = np.in1d(dts, prd.valid_time.isel(step=s))
       # use mask to map quantiles into array
       clm_arr[:, s, :, :][:, :, msk] = (
           qtl.sel(dayofyear=prd.valid_time.isel(step=s).dt.dayofyear)
           .values.transpose((0, 2, 1))
       )

.. code-block:: python
   :caption: Compute the climatology benchmark CRPS

   crps_climatology = evalhyd.evalp(
       q_obs=obs.sel(time=dts).values,
       q_prd=clm_arr,
       metrics=['CRPS_FROM_ECDF']
   )[0]

Compute skill scores
--------------------

Once the benchmarks have been computed, it is trivial to obtain the
skill scores from the score and the benchmarks.

.. code-block:: python
   :caption: Compute the CRPSS against the persistence benchmark

   crpss_persistence = 1 - (crps_forecast / crps_persistence)


.. code-block:: python
   :caption: Compute the CRPSS against the climatology benchmark

   crpss_climatology = 1 - (crps_forecast / crps_climatology)


.. rubric:: Footnotes

.. [1] Copernicus Climate Change Service (C3S) (2020): Reforecasts of river
       discharge and related data by the Global Flood Awareness System.
       Copernicus Climate Change Service (C3S) Climate Data Store (CDS).
       DOI: `10.24381/cds.2d78664e <https://doi.org/10.24381/cds.2d78664e>`_
       (Accessed on 10-May-2023)
.. [2] Zsoter, E., Harrigan, S., Barnard, C., Blick, M., Ferrario, I.,
       Wetterhall, F., Prudhomme, C. (2020): Reforecasts of river discharge
       and related data by the Global Flood Awareness System. v2.2. Copernicus
       Climate Change Service (C3S) Climate Data Store (CDS). URL:
       https://cds.climate.copernicus.eu/cdsapp#!/dataset/cems-glofas-reforecast
       (Accessed on 10-May-2023)
.. [3] Copernicus Climate Change Service (C3S) (2019): River discharge and
       related historical data from the Global Flood Awareness System.
       Copernicus Climate Change Service (C3S) Climate Data Store (CDS).
       DOI: `10.24381/cds.a4fdd6b9 <https://doi.org/10.24381/cds.a4fdd6b9>`_
       (Accessed on 10-May-2023)
.. [4] Harrigan, S., Zsoter, E., Barnard, C., Wetterhall, F., Ferrario, I.,
       Mazzetti, C., Alfieri, L., Salamon, P., Prudhomme, C. (2021): River
       discharge and related historical data from the Global Flood Awareness
       System. v2.1. Copernicus Climate Change Service (C3S) Climate Data
       Store (CDS). URL: https://cds.climate.copernicus.eu/cdsapp#!/dataset/cems-glofas-historical
       (Accessed on 10-May-2023)
.. [5] Harrigan, S., Zsoter, E., Cloke, H., Salamon, P., and Prudhomme, C.
       (2023): Daily ensemble river discharge reforecasts and real-time
       forecasts from the operational Global Flood Awareness System, Hydrol.
       Earth Syst. Sci., 27, 1–19, https://doi.org/10.5194/hess-27-1-2023.
