.. default-role:: obj

.. _cli_evalp:

evalhyd evalp
=============

Evaluate probabilistic predictions.

Usage
-----

`evalhyd evalp [OPTIONS] q_obs q_prd metrics...`

Positionals
-----------

.. option:: q_obs <TEXT:DIR>

   Path to directory where CSV files containing streamflow observations
   are. The directory must contain separate files for each site, whose
   filenames must match those found in *q_prd*.

   .. code-block:: text
      :caption: Directory structure to follow for observations.

      <q_obs>
      ├── site_a.csv
      ├── site_b.csv
      ┆   ···
      └── site_z.csv

   .. important::

      Each CSV file must feature one line and as many columns as there
      are time steps in the study period [shape: (1, time)]. Time steps
      with missing observations must be assigned `NAN` values. Those
      time steps will be ignored both in the observations and in the
      predictions before the *metrics* are computed.

.. option:: q_prd <TEXT:DIR>

   Path to directory where CSV files containing streamflow predictions
   are, following the example structure below to distinguish each
   leadtime and each site:

   .. code-block:: text
      :caption: Directory structure to follow for predictions.

      <q_prd>
      ├── leadtime_1
      │   ├── site_a.csv
      │   ├── site_b.csv
      │   ┆   ···
      │   └── site_z.csv
      ├── leadtime_2
      │   ├── site_a.csv
      │   ├── site_b.csv
      │   ┆   ···
      │   └── site_z.csv
      ┆   ···
      └── leadtime_9
          ├── site_a.csv
          ├── site_b.csv
          ┆   ···
          └── site_z.csv

   The leadtime sub-directories must contain separate files for each
   site, whose filenames must match those found in *q_obs*, and each
   site must be found across all leadtimes. Time steps with missing
   observations must be assigned `NAN` values.

   .. important::

      Each CSV file must feature as many lines as there are ensemble
      members, and as many columns as there are time steps in the study
      period [shape: (members, time)]. Time steps with missing
      observations must be assigned `NAN` values. Those time steps will
      be ignored both in the observations and in the predictions before
      the *metrics* are computed.

.. option:: metrics <TEXT ...>

   List of evaluation metrics to compute.

   .. note::

      For each computed metric, the output shape is (sites, lead times,
      subsets, samples, {quantiles,} {thresholds,} {components}). Each
      of the last three axes may or may not be present depending on the
      metric chosen (e.g. threshold-based, quantile-based, multi-component,
      etc.).

   .. seealso:: :doc:`../../metrics/probabilistic`

Optionals
---------

.. option:: --q_thr <TEXT:DIR>

   Path to directory where CSV files containing streamflow thresholds
   are. The directory must contain separate files for each site, whose
   filenames must match those found in *q_obs*.

   .. code-block:: text
      :caption: Directory structure to follow for thresholds.

      <q_thr>
      ├── site_a.csv
      ├── site_b.csv
      ┆   ···
      └── site_z.csv

   .. important::

      Each CSV file must feature one line and as many columns as there
      are thresholds in the study period [shape: (1, thresholds)].

      .. note::

         While the number of thresholds must be the same across all CSV
         files (i.e. across all sites), if some sites require less
         thresholds than others, it is possible to use `NAN` to match
         the number of thresholds of the other sites.

.. option:: --events <TXT>

   A string specifying the type of streamflow events to consider for
   threshold exceedance-based metrics. It can either be set as `"high"`
   when flooding conditions/high flow events are evaluated (i.e. event
   occurring when streamflow goes above threshold) or as `"low"` when
   drought conditions/low flow events are evaluated (i.e. event
   occurring when streamflow goes below threshold). It must be provided
   if *q_thr* is provided.

.. option:: --c_lvl <FLOAT ...>

   List of confidence interval(s) in % to consider for intervals-based
   metrics.

.. option:: --t_msk <TEXT:DIR>

   Path to directory where CSV files containing temporal subsets are,
   whose structure must be the same as for *q_prd* to distinguish each
   leadtime and each site:

   .. code-block:: text
      :caption: Directory structure to follow for temporal masks.

      <t_msk>
      ├── leadtime_1
      │   ├── site_a.csv
      │   ├── site_b.csv
      │   ┆   ···
      │   └── site_z.csv
      ├── leadtime_2
      │   ├── site_a.csv
      │   ├── site_b.csv
      │   ┆   ···
      │   └── site_z.csv
      ┆   ···
      └── leadtime_9
          ├── site_a.csv
          ├── site_b.csv
          ┆   ···
          └── site_z.csv

   The leadtime sub-directories must contain separate files for each
   site, whose filenames must match those found in *q_prd*. Each subset
   consists in a series of `0`/`1` indicating which time steps to
   include/discard. If not provided and neither is *m_cdt*, no subset is
   performed and only one set of metrics is returned corresponding to
   the whole time series. If provided, as many sets of metrics are
   returned as they are masks provided.

   .. important::

      Each CSV file must feature as many lines as there are temporal
      subsets, and as many columns as there are time steps in the study
      period [shape: (subsets, time)].

   .. seealso:: :doc:`../../functionalities/temporal-masking`

.. option:: --m_cdt <TEXT:DIR>

   Path to directory where CSV files containing masking conditions are.
   The directory must contain separate files for each site, whose
   filenames must match those found in *q_obs*. Each condition consists
   in a string and can be specified on observed/predicted streamflow
   values/statistics (mean, median, quantile), or on time indices. If
   provided in combination with *t_msk*, the latter takes precedence.
   If not provided and neither is *t_msk*, no subset is performed and
   only one set of metrics is returned corresponding to the whole time
   series. If provided, as many sets of metrics are returned as they are
   conditions provided.

   .. code-block:: text
      :caption: Directory structure to follow for masking conditions.

      <m_cdt>
      ├── site_a.csv
      ├── site_b.csv
      ┆   ···
      └── site_z.csv

   .. important::

      Each CSV file must feature as many lines as there are temporal
      subsets [shape: (conditions,)].

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

.. option:: diagnostics <TEXT ...>

   List of evaluation diagnostics to compute.

   .. note::

      For each computed diagnostic, the output shape is (sites,
      lead times, subsets, samples).

   .. seealso:: :doc:`../../functionalities/diagnostics`

.. option:: --to_file

   Divert output to CSV file, otherwise output to console.

.. option:: --out_dir <TEXT:DIR>

   Path to output directory.

   .. note::

      The generated content in the output directory will follow the same
      structure and the same namings as *q_prd*, i.e. each leadtime in a
      separate folder, and each site (and each metric) in a separate
      file within it. The shape in each CSV output file is (subsets,
      samples, {quantiles,} {thresholds,} {components}).

      .. important::

         Since CSV files are intrinsically two-dimensional (i.e. lines
         and columns), for three-dimensional outputs (e.g. *BS* or *QS*)
         or four-dimensional outputs (e.g. *BS_CRD* or *BS_LBD*), the
         first few dimensions are stacked on top of one another. For
         example, the output shape (4 subsets, 2 samples, 5 thresholds,
         3 components) is stored into a CSV file containing 40 lines and
         three columns (where the first five lines correspond to the
         five thresholds of the first subset and the first sample, the
         five following lines to the first subset and the second sample,
         the five following lines to the second subset and the first
         sample, and so on).

      .. note::

         For multisite metrics, a single file with prefix *multisite*
         is generated.

.. option:: -h, --help

   Print this help message and exit.

Examples
--------

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "BS" "BS_LBD" --q_thr "./q_thr" --events "high"
   {{{{{ 0.222222,  0.133333}}}}}
   {{{{{{ 0.072222,  0.027778,  0.177778},
        { 0.072222,  0.027778,  0.088889}}}}}}

.. code-block:: console

   $ evalhyd evalp "./q_obs" "./q_prd" "CRPS_FROM_QS"
   {{{{ 0.241935}}}}

.. code-block:: console

   $ evalhyd evalp "./q_obs" "./q_prd" "CRPS_FROM_QS" --t_msk "./t_msk"
   {{{{ 0.1875}}}}
