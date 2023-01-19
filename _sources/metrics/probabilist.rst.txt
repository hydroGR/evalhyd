.. currentmodule:: evalhyd
.. default-role:: obj

Probabilist
===========

BS
--

Brier Score (`"BS"`) originally derived by `Brier (1950)
<https://doi.org/10.1175/1520-0493(1950)078\<0001:VOFEIT\>2.0.CO;2>`_, but
computed as per `Wilks (2011) <https://doi.org/10.1016/B978-0-12-385022-5.00008-7>`_:

.. math::

   BS = \frac{1}{n} \sum_{k=1}^{n} (o_k - y_k)^2

where, for a dichotomous event, :math:`y_k` is the event forecast probability,
:math:`o_k` is the observed event outcome, and :math:`n` is the number of time
steps.

=========================  ======================================================
Required inputs            Output shape
=========================  ======================================================
`q_obs`, `q_prd`, `q_thr`  `(sites, lead times, subsets, samples, thresholds)`
=========================  ======================================================

.. tabbed:: Python

   .. code-block:: python

      >>> import numpy
      ... obs = numpy.array(
      ...     [[4.7, 4.3, 5.5, 2.7, 4.1]]
      ... )
      ... prd = numpy.array(
      ...     [[[[5.3, 4.2, 5.7, 2.3, 3.1],
      ...        [4.3, 4.2, 4.7, 4.3, 3.3],
      ...        [5.3, 5.2, 5.7, 2.3, 3.9]]]]
      ... )
      ... thr = numpy.array([[4., 5.]])
      >>> import evalhyd
      ... evalhyd.evalp(obs, prd, ["BS"], thr)
      [array([[[[[0.22222222, 0.13333333]]]]])]


.. tabbed:: R

   .. code-block:: RConsole

      > obs = rbind(
      +     c(4.7, 4.3, 5.5, 2.7, 4.1)
      + )
      > prd = array(
      +     rbind(
      +         c(5.3, 4.2, 5.7, 2.3, 3.1),
      +         c(4.3, 4.2, 4.7, 4.3, 3.3),
      +         c(5.3, 5.2, 5.7, 2.3, 3.9)
      +     ),
      +     dim = c(1, 1, 3, 5)
      + )
      > thr = rbind(
      +     c(4., 5.)
      + )
      > library(evalhyd)
      > evalhyd::evalp(obs, prd, c("BS"), thr)
      [[1]]
      , , 1, 1, 1
      
                [,1]
      [1,] 0.2222222
      
      , , 1, 1, 2
      
                [,1]
      [1,] 0.1333333

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evalp "./obs/" "./prd/" "BS" --q_thr "./thr/"
      {{{{{ 0.222222,  0.133333}}}}}

BSS
---

Brier Skill Score (`"BSS"`).

=========================  ======================================================
Required inputs            Output shape
=========================  ======================================================
`q_obs`, `q_prd`, `q_thr`  `(sites, lead times, subsets, samples, thresholds)`
=========================  ======================================================

BS_CRD
------

Calibration-Refinement Decomposition of the Brier Score (`"BS_CRD"`)
into the three components reliability, resolution, and uncertainty
[returned in this order].

=========================  ======================================================
Required inputs            Output shape
=========================  ======================================================
`q_obs`, `q_prd`, `q_thr`  `(sites, lead times, subsets, samples, thresholds, 3)`
=========================  ======================================================

BS_LBD
------

Likelihood-Base rate Decomposition of the Brier Score (`"BS_LBD"`)
into the three components type 2 bias, discrimination, and sharpness
(a.k.a. refinement) [returned in this order].

=========================  ======================================================
Required inputs            Output shape
=========================  ======================================================
`q_obs`, `q_prd`, `q_thr`  `(sites, lead times, subsets, samples, thresholds, 3)`
=========================  ======================================================

QS
--

Quantile Scores (`"QS"`).

=========================  ======================================================
Required inputs            Output shape
=========================  ======================================================
`q_obs`, `q_prd`           `(sites, lead times, subsets, samples, quantiles)`
=========================  ======================================================

CRPS
----

Continuous Ranked Probability Score (`"CRPS"`).

=========================  ======================================================
Required inputs            Output shape
=========================  ======================================================
`q_obs`, `q_prd`           `(sites, lead times, subsets, samples)`
=========================  ======================================================
