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

.. option:: --out_dir <TEXT:DIR>

   Path to output directory.

.. option:: --transform <TEXT>

   The transformation to apply to both streamflow observations
   and predictions prior to the calculation of the *metrics*.
   The options are listed in the table below.

   ========================  ==================================
   transformations           details
   ========================  ==================================
   ``"sqrt"``                The square root function
                             **f(Q) = √Q** is applied.
   ``"pow"``                 The power function
                             **f(Q) = Qⁿ** is applied (where
                             the power **n** can be set through
                             the *exponent* parameter).
   ``"inv"``                 The reciprocal function
                             **f(Q) = 1/Q** is applied.
   ``"log"``                 The natural logarithm function
                             **f(Q) = ln(Q)** is applied.
   ========================  ==================================

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

Examples
--------

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE"
   {{ 0.625477},
    { 0.043416},
    { 0.663645}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" --transform "sqrt"
   {{ 0.60338 },
    {-0.006811},
    { 0.697281}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" --transform "log" --epsilon 0.5
   {{ 0.581342},
    {-0.045892},
    { 0.714327}}

.. code-block:: console

   $ ./evalhyd evald "q_obs.csv" "q_prd.csv" "NSE" --transform "pow" --exponent 0.8
   {{ 0.617575},
    { 0.023426},
    { 0.67871 }}
