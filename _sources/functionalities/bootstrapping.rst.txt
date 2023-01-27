.. currentmodule:: evalhyd
.. default-role:: obj

Bootstrapping
=============

.. image:: https://img.shields.io/badge/-determinist-275662?style=flat-square
   :alt: determinist

.. image:: https://img.shields.io/badge/-probabilist-275662?style=flat-square
   :alt: probabilist

A bootstrapping method is available in `evalhyd` to assess the sampling
uncertainty in the evaluation metrics computed. It follows a non-overlapping
block bootstrapping approach (see e.g. `Clark et al. (2021)
<https://doi.org/10.1029/2020WR029001>`_) where blocks are taken to be
hydrological years of data. For a given period, the bootstrap method
randomly draws with replacement from the hydrological years it contains.

This allows for the estimation of the sampling uncertainty of the
evaluation metrics, i.e. the influence of the choice of the study period
on the metric values.

The bootstrap method is configurable through three parameters:

============  ===========================  ========================  ==========
parameter     description                  possible values           mandatory?
============  ===========================  ========================  ==========
`n_samples`   the number of random         any integer               yes
              samples to generate
`len_sample`  the length of one sample     any integer               yes
              in number of blocks (i.e.
              hydrological years)
`summary`     the statistics to summarise  `0` (for no summary)      yes
              the sampling distribution
              (i.e. across the samples)
============  ===========================  ========================  ==========

..
   `summary`     the statistics to summarise  `0` (for no summary),     yes
                 the sampling distribution    `1` (for mean & standard
                 (i.e. across the samples)    deviation), or `2` (for
                                              percentiles 5, 10, 15,
                                              25, 50, 75, 85, 90, 95)

.. hint::

   The seed of the random generator is configurable through the *seed*
   parameter.

.. note::

   Since the sampling is performed with replacement, the number of
   samples and the length of a sample have no upper limit.

Examples using the bootstrapping functionality are provided below.

.. tabbed:: Python

   .. code-block:: python

      >>> res = evalhyd.evald(
      ...     obs, prd, ["NSE"],
      ...     bootstrap={"n_samples": 100, "len_sample": 10, "summary": 0},
      ...     dts=dts
      ... )
      >>> res = evalhyd.evalp(
      ...     obs, prd, ["CRPS"],
      ...     bootstrap={"n_samples": 100, "len_sample": 10, "summary": 0},
      ...     dts=dts
      ... )

.. tabbed:: R

   .. code-block:: RConsole

      > res = evalhyd::evald(
      +     obs, prd, c("NSE"),
      +     bootstrap=list(n_samples=100, len_sample=10, summary=0),
      +     dts=dts
      + )
      > res = evalhyd::evalp(
      +     obs, prd, c("CRPS"),
      +     bootstrap=list(n_samples=100, len_sample=10, summary=0),
      +     dts=dts
      + )

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evald "obs.csv" "prd.csv" "NSE" --to_file \
      > --bootstrap "n_samples" 100 "len_sample" 10 "summary" 0 --dts "dts.csv"
      $ ./evalhyd evalp "./obs" "./prd" "CRPS" --to_file \
      > --bootstrap "n_samples" 100 "len_sample" 10 "summary" 0 --dts "dts.csv"
