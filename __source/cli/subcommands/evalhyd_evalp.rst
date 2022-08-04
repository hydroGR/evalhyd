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

   Path to directory where streamflow observations CSV files are.
   The directory must contain separate files for each site, whose
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

   Path to directory where streamflow predictions CSV files are,
   following the example structure below to distinguish each leadtime
   and each site:

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

Optionals
---------

.. option:: -h, --help

   Print this help message and exit.

.. option:: --to_file

   Divert output to CSV file, otherwise output to console.

.. option:: --q_thr <FLOAT ...>

   Vector of streamflow thresholds

.. option:: --t_msk <TEXT:FILE>

   Path to CSV file containing masks to generate temporal subsets of
   the whole streamflow time series (where 1/0 is used for the time
   steps to include/discard in a given subset). If not provided, no
   subset is performed and only one set of metrics is returned
   corresponding to the whole time series. If provided, as many sets of
   metrics are returned as they are masks provided.

   .. important::

      Each CSV file must feature as many lines as there are temporal
      subsets, and as many columns as there are time steps in the study
      period [shape: (subsets, time)].

.. option:: --out_dir <TEXT>

   Path to output directory.

Examples
--------

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "BS" "BS_LBD" --q_thr 4 5
   {{{{ 0.222222,  0.133333}}}}
   {{{{{ 0.072222,  0.027778,  0.177778},
       { 0.072222,  0.027778,  0.088889}}}}}

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "CRPS"
   {{{ 0.241935}}}

.. code-block:: console

   $ ./evalhyd evalp "./q_obs" "./q_prd" "CRPS" --t_msk "t_msk.csv"
   {{{ 0.215054}}}
