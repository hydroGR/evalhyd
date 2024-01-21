.. currentmodule:: evalhyd
.. default-role:: obj

Diagnostics
===========

Completeness
------------

.. image:: https://img.shields.io/badge/-deterministic-275662?style=flat-square
   :alt: deterministic

.. image:: https://img.shields.io/badge/-probabilistic-275662?style=flat-square
   :alt: probabilistic

Because of :doc:`missing data <missing-data>`, the optional use of
:doc:`temporal <temporal-masking>`/:doc:`conditional <conditional-masking>`,
and/or the optional use of :doc:`bootstrapping <bootstrapping>`, the
number of time steps in the period used to compute the evaluation metrics
may vary and may be reduced unreasonably. This is why the *completeness*
diagnostic is available: it returns the number of time steps included in
each period considered, i.e. once missing data have been discarded, and
masking and bootstrapping temporal subsets have been performed.

.. image:: https://img.shields.io/badge/-deterministic--only-275662?style=flat-square
   :alt: deterministic-only

The returned shape of the *completeness* diagnostic is
``(series, subsets, samples)``.

.. image:: https://img.shields.io/badge/-probabilistic--only-275662?style=flat-square
   :alt: probabilistic-only

The returned shape of the *completeness* diagnostic is
``(sites, lead times, subsets, samples)``.
