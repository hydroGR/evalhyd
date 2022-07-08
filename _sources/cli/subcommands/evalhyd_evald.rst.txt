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

.. option:: --out_dir <TEXT>

   Path to output directory.

Examples
--------

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE"
   {{ 0.625477},
    { 0.043416},
    { 0.663645}}
