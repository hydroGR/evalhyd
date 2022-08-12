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
      are time steps in the study period [shape: (1, time)].

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
   site must be found across all leadtimes.

   .. important::

      Each CSV file must feature as many lines as there are ensemble
      members, and as many columns as there are time steps in the study
      period [shape: (members, time)].

.. option:: metrics <TEXT ...>

   List of evaluation metrics to compute.

   .. note::

      For each computed metric, the output shape is (sites, lead times,
      subsets, {quantiles,} {thresholds,} {components}). Each of the
      last three axes may or may not be present depending on the metric
      chosen (e.g. threshold-based, quantile-based, multi-component,
      etc.).

Optionals
---------

.. option:: -h, --help

   Print this help message and exit.

.. option:: --to_file

   Divert output to CSV file, otherwise output to console.

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

.. option:: --t_msk <TEXT:DIR>

   Path to directory where CSV files containing temporal subsets are.
   The directory must contain separate files for each site, whose
   filenames must match those found in *q_obs*. Each subset consists in
   a series of 0/1 indicating which time steps to include/discard. If
   not provided and neither is *m_cdt*, no subset is performed and only
   one set of metrics is returned corresponding to the whole time
   series. If provided, as many sets of metrics are returned as they
   are masks provided.

   .. code-block:: text
      :caption: Directory structure to follow for temporal masks.

      <t_msk>
      ├── site_a.csv
      ├── site_b.csv
      ┆   ···
      └── site_z.csv

   .. important::

      Each CSV file must feature as many lines as there are temporal
      subsets, and as many columns as there are time steps in the study
      period [shape: (subsets, time)].

.. option:: --m_cdt <TEXT:DIR>

   Path to directory where CSV files containing masking conditions are.
   The directory must contain separate files for each site, whose
   filenames must match those found in *q_obs*. Each condition consists
   in a string and can be specified on observed streamflow or on time
   indices. If provided in combination with *t_msk*, the latter takes
   precedence. If not provided and neither is *t_msk*, no subset is
   performed and only one set of metrics is returned corresponding to
   the whole time series. If provided, as many sets of metrics are
   returned as they are conditions provided.

   .. code-block:: text
      :caption: Directory structure to follow for masking conditions.

      <m_cdt>
      ├── site_a.csv
      ├── site_b.csv
      ┆   ···
      └── site_z.csv

   .. important::

      Each CSV file must feature as many lines as there are temporal
      subsets, and one column [shape: (conditions, 1)].


   The conditions can be specified on:

   - observed streamflow with one of the following syntaxes:

     .. code-block:: text

        q{<opr><val>}
        q{<opr><val>,<opr><val>}

     where ``<opr>`` can be one of the following operators: `>`, `<`, `>=`,
     `<=`, `==`, `\!=`, and where `<val>` is the observed streamflow value
     as a floating point number. Combinations of conditions are allowed
     and must be comma-separated inside the curly brackets. Examples of
     valid conditions are: `q{>30}`, `q{<=10}`, `q{<=5,>35}`. Time steps
     where observed streamflow complies with the condition(s) are included
     in the temporal subset.

   - time indices with one of the following syntaxes:

     .. code-block:: text

        t{<idx_#>,<idx_#>,...}
        t{<start_idx>:<stop_idx>}

     where ``<idx_#>`` is the position of the given time step to include in
     the temporal subset (with first time step at index 0), and where
     ``<start_idx>`` and ``<stop_idx>`` are the beginning and ending
     positions of the time steps determining the period to include in the
     temporal subset, respectively (with [start, stop[, i.e. start
     included and stop excluded). Combinations of conditions are allowed
     and must be comma-separated inside the curly brackets. Examples of
     valid conditions are: `t{0:100}`, `t{2,3,4}`, `t{0:10,15,16}`. Note
     that `t{0,1,2,3}` and `t{0:4}` are strictly equivalent.

.. option:: --out_dir <TEXT:DIR>

   Path to output directory.

   .. note::

      The generated content in the output directory will follow the same
      structure and the same namings as *q_thr*, i.e. each leadtime in a
      separate folder, and each site in a separate file within it. The
      shape in each CSV output file is (subsets, {quantiles,}
      {thresholds,} {components}).

      .. important::

         Since CSV files are intrinsically two-dimensional (i.e. lines
         and columns), for three-dimensional outputs (e.g. for
         multi-component metrics such as *BS_CRD* or *BS_LBD*), the
         subsets are stacked on top of one another. For example, the
         output shape (4 subsets, 2 thresholds, 3 components) is turned
         into a CSV file containing 8 lines and 3 columns (where the two
         first lines correspond to the first subset, the two following
         lines to the second subset, and so on).

Examples
--------

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "BS" "BS_LBD" --q_thr "./q_thr"
   {{{{ 0.222222,  0.133333}}}}
   {{{{{ 0.072222,  0.027778,  0.177778},
       { 0.072222,  0.027778,  0.088889}}}}}

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "CRPS"
   {{{ 0.241935}}}

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "CRPS" --t_msk "./t_msk"
   {{{ 0.215054}}}
