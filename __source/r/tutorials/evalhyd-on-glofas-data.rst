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
in turn to form a multi-sites dataset. This can be done in R using the library
`RNetCDF`.

.. code-block:: r
   :caption: Import the libraries needed for this tutorial

   library(dplyr)
   library(tidyr)
   library(magrittr)
   library(RNetCDF)
   library(lubridate)
   library(RcppRoll)
   library(evalhyd)

.. code-block:: r
   :caption: Find all the files contained in the data subdirectories

   setwd(".")
   li_fi = Sys.glob("GloFAS-v2.2_river_discharge_reforecast_*.nc")
   li_ob = Sys.glob("GloFAS-ERA5_v2.1_river_discharge_reanalysis_*.nc")


.. code-block:: r
   :caption: Find the number of time steps with the first reforecast file

   fi_nc = RNetCDF::open.nc(li_fi[1])
   tmp_prd = RNetCDF::read.nc(fi_nc)
   dim3D = dim(tmp_prd$dis24)

   for (i_ech in 1:dim3D[1]) {
     dt_prd =
       RNetCDF::utcal.nc(RNetCDF::att.get.nc(fi_nc, "valid_time", "units"),
                         tmp_prd$valid_time[i_ech, ],
                         type = "c")
     if (i_ech == 1) vec_dt = dt_prd
     vec_dt = c(vec_dt, dt_prd)
   }
   vec_dt = vec_dt %>% unique() %>% sort()
   length_dt = length(vec_dt)

.. code-block:: r
   :caption: For each lead time, find the valid time values with the first reforecast file

   n_i_ech = NULL
   for (i_ech in 1:dim3D[1]) {
     dt_prd = RNetCDF::utcal.nc(RNetCDF::att.get.nc(fi_nc, "valid_time", "units"),
                                tmp_prd$valid_time[i_ech, ],
                                type = "c")
     n_i_ech[[i_ech]] = which(vec_dt %in% dt_prd)
   }

.. code-block:: r
   :caption: Find the t0 time steps

   dt_ini = RNetCDF::utcal.nc(RNetCDF::att.get.nc(fi_nc, "time", "units"),
                              tmp_prd$time,
                              type = "c")

.. code-block:: r
   :caption: Find the time steps for obs with the first observation file

   ob_nc = RNetCDF::open.nc(li_ob[1])
   tmp_obs = RNetCDF::read.nc(ob_nc)
   dt_obs = RNetCDF::utcal.nc(RNetCDF::att.get.nc(ob_nc, "valid_time", "units"),
                              tmp_obs$valid_time,
                              type = "c")
   n_dt_obs = which(dt_obs %in% vec_dt)

.. code-block:: r
   :caption: Define the 4D and 2D arrays

   q_prd = array(NA, dim=c(length(li_fi), dim3D[1], dim3D[3], length_dt))
   q_obs = array(NA, dim=c(length(li_fi), length(tmp_obs$dis24)))

.. code-block:: r
   :caption: Read each station and fill the arrays

   for (i in 1:length(li_fi)) {

     # forecast data
     fi_nc = RNetCDF::open.nc(li_fi[i])
     tmp_prd = RNetCDF::read.nc(fi_nc)

     # for each lead time find the valid time values
     for (i_ech in 1:dim3D[1]) {
       q_prd[i, i_ech, , n_i_ech[[i_ech]]] =
         array(t(tmp_prd$dis24[i_ech, , ]), dim=c(1, 1, dim3D[3], dim3D[2]))
     }

     # observed data
     ob_nc = RNetCDF::open.nc(li_ob[i])
     tmp_obs = RNetCDF::read.nc(ob_nc)
     q_obs_i = tmp_obs$dis24
     q_obs[i, ] = array(q_obs_i, dim=c(1, length(q_obs_i)))

   }

Compute scores to evaluate the prediction against the observation data
----------------------------------------------------------------------

Now that the prediction and observation dates are aligned, `evalhyd` can
be used to compute any of the :doc:`probabilistic metrics <../../metrics/probabilistic>`
it gives access to. Here, we show how to compute the CRPS computed from
the empirical cumulative density function.

.. code-block:: r
   :caption: Compute the CRPS

   metrics = c("CRPS_FROM_ECDF")
   gc()
   score =
     evalhyd::evalp(
       q_obs[1:4, n_dt_obs, drop = FALSE], q_prd[1:4, , , , drop = FALSE],
       metrics
     )
   names(score) = metrics
   crps_forecast = score$CRPS_FROM_ECDF %>% data.frame()

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

.. code-block:: r
   :caption: Compute the persistence benchmark

   res = NULL
   for (i in 1:length(li_fi)) {

     prs_arr = array(NA, dim=c(dim3D[1], length_dt))

     # for each lead time find the valid time values
     for (i_ech in 1:dim3D[1]) {
       prs_arr[i_ech, n_i_ech[[i_ech]]] =
         q_obs[i, which(dt_obs %in% dt_ini)]
     }

     metrics = c("MAE")
     gc()
     scores_ =
       evalhyd::evald(q_obs[i, n_dt_obs, drop = FALSE], prs_arr, metrics)
     names(scores_) = metrics
     res[[i]] = scores_$MAE %>% data.frame()
   }
   crps_persistence = res %>% bind_cols() %>% t() %>% data.frame() %>% slice(1:4)

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

.. code-block:: r
   :caption:

   year_obs = lubridate::year(dt_obs)
   doy_obs = lubridate::yday(dt_obs)
   i_wdw = which(year_obs %in% 1979:2018)

.. code-block:: r
   :caption: Apply 31-day rolling windows on 40-year climatological sample

   wdw = apply(
     q_obs[, i_wdw], 1, function(x) RcppRoll::roll_mean(x, n=31, fill=c(NA, NA, NA))
   )

.. code-block:: r
   :caption: Compute quantiles for each day of year over time and window (i.e. across 40y and 31d)

   qtl = apply(
     wdw, 2, function(x) array2DF(
       tapply(
         x, doy_obs[i_wdw], function(y) quantile(y, probs = seq(0,1,0.1), na.rm=T)
       )
     )
   )

.. code-block:: r
   :caption: Map climatology benchmark onto observation dates

   clm_arr = array(NA, dim=c(length(li_fi), dim3D[1], dim3D[3], length_dt))

   # for each lead time find the valid time values
   for (i_ech in 1:dim3D[1]) {

     doy_ech = lubridate::yday(vec_dt[n_i_ech[[i_ech]]])

     # for each station
     for (i in 1:length(li_fi)) {
       tmp =
         doy_ech %>% as.character %>% data.frame() %>%
         left_join(qtl[[i]], by=c("."="Var1")) %>% select(-1)
       clm_arr[i, i_ech, , n_i_ech[[i_ech]]] = array(t(tmp), dim=c(dim3D[3], dim3D[2]))
     }

   }

.. code-block:: r
   :caption: Compute the climatology benchmark CRPS

   metrics = c("CRPS_FROM_ECDF")
   gc()
   score = evalhyd::evalp(
     q_obs[1:4, n_dt_obs, drop = FALSE], clm_arr[1:4, , , , drop = FALSE],
     metrics
   )
   names(score) = metrics
   crps_climatology = score$CRPS_FROM_ECDF %>% data.frame()

Compute skill scores
--------------------

Once the benchmarks have been computed, it is trivial to obtain the
skill scores from the score and the benchmarks.

.. code-block:: r
   :caption: Compute the CRPSS against the persistence benchmark

   crpss_persistence = 1 - (crps_forecast / crps_persistence)

.. code-block:: r
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
