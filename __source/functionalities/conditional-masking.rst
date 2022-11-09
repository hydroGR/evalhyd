.. currentmodule:: evalhyd
.. default-role:: obj

Conditional masking
===================

.. image:: https://img.shields.io/badge/-not%20available%20for%20evalhyd--r-ed6e6c?style=flat-square
   :alt: not available for evalhyd-r

.. raw:: html

   <br/>

.. image:: https://img.shields.io/badge/-determinist-275662?style=flat-square
   :alt: determinist

.. image:: https://img.shields.io/badge/-probabilist-275662?style=flat-square
   :alt: probabilist

An alternative to :doc:`temporal masking <temporal-masking>` is conditional
masking. It generates temporal subsets from user-provided conditions. The
conditions can be specified on streamflow values or time indices.

On streamflow values
--------------------

The conditions can be specified on observed/predicted streamflow variables
with one of the following syntaxes:

.. code-block:: text

   <var>{<opr><val>}
   <var>{<opr><val>,<opr><val>}

where:

- ``<var>`` is the streamflow variable to use to generate the mask and
  can be the observed streamflow `q_obs` (and, for probabilist evaluation
  only, the median or the mean across the predicted ensemble members
  `q_prd_median` or `q_prd_mean`, respectively) ;
- ``<opr>`` can be one of the following operators: `>`, `<`, `>=`,
  `<=`, `==`, `\!=` ;
- ``<val>`` is the streamflow value to use to condition the mask and
  can be a given numerical value or a statistic applied on ``<var>``
  (`mean`, `median`, or `quantile#` supported).

.. raw:: html

   <br/>

Combinations of two conditions are allowed and must be comma-separated
inside the curly brackets.

Examples of valid conditions are: `q_obs{>30}`, `q_prd_median{<=10}`,
`q_prd_mean{<=5,>35}`, `q_obs{>mean}`, `q_prd_median{<=quantile0.7}`.

Time steps where the streamflow variable complies with the condition(s)
are included in the temporal subset.

.. note::

   `q_obs{<=5,>35}` and `q_obs{>5,<=35}` are complement conditions of
   one another.

To illustrate, see the examples below.

.. code-block:: text

   observations     351         367         377         378         330         324
   -------------------------------------------------------------------------------------
   condition        q_obs{>=330,<370}
   mask             True        True        False       False       True        False
   -------------------------------------------------------------------------------------
   condition        q_obs{<360}
   mask             True        False       False       False       True        True

.. code-block:: text

   predictions

   1st member       312         335         358         342         328         335
   2nd member       315         341         364         351         332         333
   3rd member       306         359         358         327         327         328

   mean             311         345         360         340        [329]        332
   -------------------------------------------------------------------------------------
   condition        q_prd_mean{>quantile0.2}
   mask             False       True        True        True        False       True


On time indices
---------------

The conditions can be specified on time indices with one of the following
syntaxes:

.. code-block:: text

   t{<idx_#>,<idx_#>,...}
   t{<start_idx>:<stop_idx>}

where:

- ``<idx_#>`` is the position of the given time step to include in
  the temporal subset (with first time step at index `0`) ;
- ``<start_idx>`` and ``<stop_idx>`` are the beginning and ending
  positions of the time steps determining the period to include in the
  temporal subset, respectively (with [start, stop[, i.e. start
  included and stop excluded).

.. raw:: html

   <br/>

Combinations of conditions are allowed and must be comma-separated
inside the curly brackets.

Examples of valid conditions are: `t{0:100}`, `t{2,3,4}`, `t{0:10,15,16}`.

.. note::

   `t{0,1,2,3}` and `t{0:4}` are strictly equivalent.

To illustrate, see the examples below.

.. code-block:: text

   time index       0           1           2           3           4           5
   -------------------------------------------------------------------------------------
   condition        t{0,1,4}
   mask             True        True        False       False       True        False
   -------------------------------------------------------------------------------------
   condition        t{1:4}
   mask             False       True        True        True        False       False
   -------------------------------------------------------------------------------------
   condition        t{:}
   mask             True        True        True        True        True        True
