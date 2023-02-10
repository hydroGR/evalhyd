.. default-role:: obj

.. _cli_evald:

evalhyd evald
=============

Evaluate deterministic predictions.

.. program:: evalhyd evald

Usage
-----

`evalhyd evald [OPTIONS] q_obs q_prd metrics...`

Positionals
-----------

.. option:: q_obs <TEXT:FILE>

   Path to streamflow observations CSV file. Time steps with missing
   observations must be assigned `NAN` values. Those time steps will
   be ignored both in the observations and in the predictions before
   the *metrics* are computed.

   .. important::

      The CSV file must feature one line and as many columns as there
      are time steps in the study period [shape: (1, time)].


.. option:: q_prd <TEXT:FILE>

   Path to streamflow predictions CSV file. Time steps with missing
   predictions must be assigned `NAN` values. Those time steps will
   be ignored both in the observations and in the predictions before
   the *metrics* are computed.

   .. important::

      The CSV file must feature one line or more and as many columns as
      there are time steps in the study period [shape: (series, time)].

.. option:: metrics <TEXT ...>

   List of evaluation metrics to compute.

   .. note::

      For each computed metric, the output shape is (series, subsets,
      samples). Since CSV files are intrinsically two-dimensional (i.e.
      lines and columns), the series are stacked on one another. For
      example, the output shape (2 series, 4 subsets, 3 samples) is
      stored into a CSV file containing eight lines and three columns
      (where the four first lines correspond to the four subsets and
      three samples of the first series, and the last four lines
      correspond to those of the second series).

Optionals
---------

.. option:: --transform <TEXT>

   The transformation to apply to both streamflow observations
   and predictions prior to the calculation of the *metrics*.

   .. seealso:: :doc:`../../functionalities/transformation`

.. option:: --exponent <FLOAT>

   The value of the exponent n to use when the transform is the power
   function. If not provided (or set to default value 1), the streamflow
   observations and predictions remain untransformed.

.. option:: --epsilon <FLOAT>

   The value of the small constant ε to add to both the streamflow
   observations and predictions prior to the calculation of the
   *metrics* when the *transform* is the reciprocal function, the
   natural logarithm, or the power function with a negative exponent
   (since none are defined for 0). If not provided (or set to default
   value -9), one hundredth of the mean of the streamflow observations
   is used as value for epsilon, as recommended by `Pushpalatha et al.
   (2012) <https://doi.org/10.1016/j.jhydrol.2011.11.055>`_.

.. option:: --t_msk <TEXT:FILE>

   Path to CSV file containing the temporal subsets. Each subset consists
   in a series of `0`/`1` indicating which time steps to include/discard.
   If not provided and neither is *m_cdt*, no subset is performed. If
   provided, as many subsets as they are observed time series must be
   provided.

   .. important::

      The CSV file must feature as many lines as there are prediction
      series times temporal subsets, and as many columns as there are
      time steps in the study period [shape: (series, subsets, time)].
      For example, for five predictions series and two temporal subsets,
      the first five lines must correspond to the five series for the
      first subset, and the last five lines to the five series for the
      second subset.

   .. seealso:: :doc:`../../functionalities/temporal-masking`

.. option:: --m_cdt <TEXT:FILE>

   Path to CSV file containing the masking conditions. Each condition
   consists in a string and can be specified on observed streamflow
   values/statistics (mean, median, quantile), or on time indices. If
   provided in combination with *t_msk*, the latter takes precedence. If
   not provided and neither is *t_msk*, no subset is performed. If
   provided, as many conditions as they are observed time series must
   be provided.

   .. important::

      The CSV file must feature as many lines as there are prediction
      series, and as many columns as there are masking conditions
      [shape: (series, subsets)].

   .. seealso:: :doc:`../../functionalities/conditional-masking`

.. option:: --bootstrap <TEXT ...>

   The values for the parameters of the bootstrapping method used to
   estimate the sampling uncertainty in the evaluation of the
   predictions. It takes three parameters: `"n_samples"` the number of
   random samples; `"len_samples"` the length of one sample in number of
   years; `"summary"` the statistics to return to characterise the
   sampling distribution. If not provided, no bootstrapping is
   performed. If provided, *dts* must also be provided.

   *Parameter example:* ::

      --bootstrap "n_samples" 100 "len_sample" 10 "summary" 0

   .. seealso:: :doc:`../../functionalities/bootstrapping`

.. option:: --dts <TEXT:FILE>

   Path to CSV file containing the corresponding dates and times for the
   temporal dimension of the streamflow observations and predictions.
   The date and time must be specified in a string following the
   ISO 8601-1:2019 standard, i.e. "YYYY-MM-DD hh:mm:ss" (e.g. the
   21st of May 2007 at 4 in the afternoon is "2007-05-21 16:00:00").
   If provided, it is only used if *bootstrap* is also provided.

   .. important::

      The CSV file must feature as many columns as there are time steps
      in the evaluation period [shape: (time,)].

.. option:: --seed <INT>

   An integer value for the seed used by random generators. This
   parameter guarantees the reproducibility of the metric values
   between calls.

.. option:: --to_file

   Divert output to CSV file, otherwise output to console.

.. option:: --out_dir <TEXT:DIR>

   Path to output directory.

   .. note::

      Each metric is returned in a separate CSV file.

.. option:: -h, --help

   Print this help message and exit.


Examples
--------

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE"
   {{{ 0.625477}},
    {{ 0.043416}},
    {{ 0.663645}}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" --transform "sqrt"
   {{{ 0.60338 }},
    {{-0.006811}},
    {{ 0.697281}}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" --transform "log" --epsilon .5
   {{ 0.581342},
    {-0.045892},
    { 0.714327}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" --transform "pow" --exponent .8
   {{{ 0.617575}},
    {{ 0.023426}},
    {{ 0.67871 }}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" \
   > --bootstrap "n_samples" 5 "len_sample" 10 "summary" 0 --dts "dts.csv"
   {{{ 0.625477,  0.625477,  0.625477,  0.625477,  0.625477}},
    {{ 0.043416,  0.043416,  0.043416,  0.043416,  0.043416}},
    {{ 0.663645,  0.663645,  0.663645,  0.663645,  0.663645}}}