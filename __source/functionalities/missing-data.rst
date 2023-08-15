.. currentmodule:: evalhyd
.. default-role:: obj

Handling of missing data
========================

:bdg-primary-line:`deterministic` :bdg-primary-line:`probabilistic`

Missing data must be flagged as "not a number" regardless of the utility
used in the `evalhyd` stack. Missing data can be present both in the
streamflow observations and/or the streamflow predictions. All time steps
where either observations or predictions are missing are not taken into
account in the computation of the metrics (a method sometimes referred
to as *pairwise deletion*).

That is to say that these two calls to `evalhyd` yield the same result:

.. tabbed:: Python

   .. code-block:: python

      >>> import evalhyd
      >>> import numpy as np
      >>> (
      ...     evalhyd.evald(np.array([7, 3, 3, np.nan, 5]), np.array([5, 4, 3, 5, np.nan]), ["KGE"])
      ...     == evalhyd.evald(np.array([7, 3, 3]), np.array([5, 4, 3]), ["KGE"])
      ... )
      True

.. tabbed:: R

   .. code-block:: RConsole

      > all(
      +    evalhyd::evald(c(7, 3, 3, NA, 5), c(5, 4, 3, 5, NA), c("KGE"))[[1]]
      +    == evalhyd::evald(c(7, 3, 3), c(5, 4, 3), c("KGE"))[[1]]
      + )
      [1] TRUE

:bdg-primary-line:`probabilistic-only`

For a given site, `evalhyd` expects that the time indices in the
streamflow predictions and in the streamflow observations correspond to
the same datetime. This means that, when evaluating several lead times at
once, the time series of streamflow observations will typically be longer
than any of the time series of streamflow predictions. Indeed, missing
predictions will exist for the longer lead times at the beginning of the
time series, because the forecast datetime plus the lead time will
not correspond to the first observed datetime (required for shorter lead
times), but a later one. In turn, missing predictions will exist for the
shorter lead times at the end of the time series, because the forecast
datetime plus the lead time will not correspond to the last observed datetime
(required for longer lead times), but an earlier one. For these datetimes,
missing predictions must be filled with "not a number" value to make sure
that the length of the observations and predictions are the same, so that
a single time series of streamflow observations can be used across the
prediction lead times evaluated.

To illustrate, let's look at the simple example below where streamflow
forecasts (only one ensemble member shown) are issued daily from the 1st until
the 4th of January 2017 with a one-day, two-day, and three-day lead time.

.. code-block:: text

   time index       0           1           2           3           4           5
   datetime         2017-01-02  2017-01-03  2017-01-04  2017-01-05  2017-01-06  2017-01-07

   observations     351         367         377         378         330         324

   predictions
   1-day lead time  312         335         358         342         NaN         NaN
   2-day lead time  NaN         341         364         351         332         NaN
   3-day lead time  NaN         NaN         361         358         327         327


For a complete forecast evaluation, the one-day lead time will require
observations from the 2nd until the 5th of January, the two-day lead time
from the 3rd until the 6th, and the three-day lead time from the 4th
until the 7th. Since only one time series of streamflow observations is
expected by `evalhyd`, it must start on the 2nd and end on the 7th of
January, while the streamflow predictions must "flag" those time steps
for which they are not making predictions as "not a number" (identified
as `NaN` in the above example). Indeed, each forecast can only feature
4 predicted values if forecasts were issued only on 4 consecutive days.

This example translates into the following call to `evalhyd` (where the
ensemble member shown above is duplicated four times for the only purpose
of illustration):

.. tabbed:: Python

   .. code-block:: python

      >>> import evalhyd
      >>> import numpy as np
      >>> res = evalhyd.evalp(
      ...     q_obs=np.array([[351, 367, 377, 378, 330, 324]]),
      ...     q_prd=np.array([[[[312, 335, 358, 342, np.nan, np.nan],
      ...                       [312, 335, 358, 342, np.nan, np.nan],
      ...                       [312, 335, 358, 342, np.nan, np.nan],
      ...                       [312, 335, 358, 342, np.nan, np.nan]],
      ...                      [[np.nan, 341, 364, 351, 332, np.nan],
      ...                       [np.nan, 341, 364, 351, 332, np.nan],
      ...                       [np.nan, 341, 364, 351, 332, np.nan],
      ...                       [np.nan, 341, 364, 351, 332, np.nan]],
      ...                      [[np.nan, np.nan, 361, 358, 327, 327],
      ...                       [np.nan, np.nan, 361, 358, 327, 327],
      ...                       [np.nan, np.nan, 361, 358, 327, 327],
      ...                       [np.nan, np.nan, 361, 358, 327, 327]]]]),
      ...     metrics=["CRPS_FROM_ECDF"]
      ... )

.. tabbed:: R

   .. code-block:: RConsole

      > res <- evalhyd::evalp(
      +     q_obs = rbind(c(351, 367, 377, 378, 330, 324)),
      +     q_prd = aperm(
      +         array(
      +             data = c(
      +                 rbind(c(312, 335, 358, 342, NA, NA),
      +                       c(312, 335, 358, 342, NA, NA),
      +                       c(312, 335, 358, 342, NA, NA),
      +                       c(312, 335, 358, 342, NA, NA)),
      +                 rbind(c(NA, 341, 364, 351, 332, NA),
      +                       c(NA, 341, 364, 351, 332, NA),
      +                       c(NA, 341, 364, 351, 332, NA),
      +                       c(NA, 341, 364, 351, 332, NA)),
      +                 rbind(c(NA, NA, 361, 358, 327, 327),
      +                       c(NA, NA, 361, 358, 327, 327),
      +                       c(NA, NA, 361, 358, 327, 327),
      +                       c(NA, NA, 361, 358, 327, 327))
      +             ),
      +             dim = c(4, 6, 3, 1)
      +         ),
      +         perm = c(4, 3, 1, 2)
      +     ),
      +     metrics = c("CRPS_FROM_ECDF")
      + )
