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

.. option:: q_obs <TEXT:FILE>

   Path to streamflow observations CSV file.

.. option:: q_prd <TEXT:FILE>

   Path to streamflow predictions CSV file.

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

.. option:: --out_dir <TEXT>

   Path to output directory.

Examples
--------

.. code-block:: console

   $ ./evalhyd evalp "q_obs.csv" "q_prd.csv" "BS" "BS_LBD" --q_thr 4 5
   {{ 0.222222},
    { 0.133333}}
   {{ 0.072222,  0.027778,  0.177778},
    { 0.072222,  0.027778,  0.088889}}


.. code-block:: console

   $ ./evalhyd evalp "q_obs.csv" "q_prd.csv" "CRPS"
   {{ 0.241935}}
