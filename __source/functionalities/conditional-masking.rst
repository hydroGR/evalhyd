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
masking. It generates temporal subsets from user-provided conditions.

The conditions can be specified on:

- observed streamflow with one of the following syntaxes:

  .. code-block:: text

     q{<opr><val>}
     q{<opr><val>,<opr><val>}

  where ``<opr>`` can be one of the following operators: `>`, `<`, `>=`,
  `<=`, `==`, `\!=`, and where `<val>` is the observed streamflow value
  as a floating point number. Combinations of two conditions are allowed
  and must be comma-separated inside the curly brackets. Examples of
  valid conditions are: `q{>30}`, `q{<=10}`, `q{<=5,>35}`. Time steps
  where observed streamflow complies with the condition(s) are included
  in the temporal subset. Note that `q{<=5,>35}` and `q{>5,<=35}` are
  complement conditions of one another.

  To illustrate, see the examples below.

  .. code-block:: text

     observations     351         367         377         378         330         324
     -------------------------------------------------------------------------------------
     condition        q{>=330,<370}
     mask             True        True        False       False       True        False
     -------------------------------------------------------------------------------------
     condition        q{<360}
     mask             True        False       False       False       True        True

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

  To illustrate, see the examples below.

  .. code-block:: text

     time index       0           1           2           3           4           5
     -------------------------------------------------------------------------------------
     condition        t{0,1,4}
     mask             True        True        False       False       True        False
     -------------------------------------------------------------------------------------
     condition        t{1:4}
     mask             False       True        True        True        False       False

.. _determinist-only

.. image:: https://img.shields.io/badge/-determinist--only-275662?style=flat-square
   :alt: determinist-only

Given that the determinist evaluation can be performed on arrays whose
dimension (i.e. 1D, 2D, etc.) is not known until runtime, an additional
restriction exists on the number of conditions that can be provided
for determinist evaluation and as many conditions as there are time
series of streamflow observations must be provided.
