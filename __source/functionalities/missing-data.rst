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
forecasts are issued daily from the 1st until the 4th of January 2017
with a one-day, two-day, and three-day lead time.

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
