.. currentmodule:: evalhyd
.. default-role:: obj

Probabilist
===========

.. tip::

   All the metrics listed below are accessible via ``evalp``, the probabilistic
   entry point of `evalhyd`.

   For example, the Brier score can be computed as follows:

   .. tabbed:: C++

      .. code-block:: cpp

         #include <xtensor/xtensor.hpp>
         #include <xtensor/xio.hpp>
         #include <evalhyd/evalp.hpp>

         xt::xtensor<double, 2> obs = {{4.7, 4.3, 5.5, 2.7, 4.1}};
         xt::xtensor<double, 4> prd = {{{{5.3, 4.2, 5.7, 2.3, 3.1},
                                         {4.3, 4.2, 4.7, 4.3, 3.3},
                                         {5.3, 5.2, 5.7, 2.3, 3.9}}}};
         xt::xtensor<double, 2> thr = {{4., 5.}};

         std::cout << evalhyd::evalp(obs, prd, {"BS"}, thr, "high")[0] << std::endl;
         // {{{{{ 0.222222,  0.133333}}}}}

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
         ... evalhyd.evalp(obs, prd, ["BS"], thr, events="high")
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
         > evalhyd::evalp(obs, prd, c("BS"), thr, events="high")
         [[1]]
         , , 1, 1, 1

                   [,1]
         [1,] 0.2222222

         , , 1, 1, 2

                   [,1]
         [1,] 0.1333333

   .. tabbed:: CLI

      .. code-block:: console

         $ ./evalhyd evalp "./obs/" "./prd/" "BS" --q_thr "./thr/" --events "high"
         {{{{{ 0.222222,  0.133333}}}}}

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

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | thresholds)`                                   |
   +-------------------------+------------------------------------------------+

BSS
---

Brier Skill Score (`"BSS"`), computed as per `Wilks (2011)
<https://doi.org/10.1016/B978-0-12-385022-5.00008-7>`_:

.. math::

   BSS = 1 - \frac{BS}{BS_{reference}}

where :math:`BS_{reference} = \frac{1}{n} \sum_{k=1}^{n} (o_k - \bar{o})^2`\ [2]_,
:math:`o_k` is the observed event outcome, :math:`n` is the number of time
steps, and :math:`\bar{o}` is the mean observed event occurrence for the
study period.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | thresholds)`                                   |
   +-------------------------+------------------------------------------------+

BS_CRD
------

Calibration-Refinement Decomposition of the Brier Score (`"BS_CRD"`)
into the three components reliability, resolution, and uncertainty
[returned in this order].

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | thresholds, 3)`                                |
   +-------------------------+------------------------------------------------+

BS_LBD
------

Likelihood-Base rate Decomposition of the Brier Score (`"BS_LBD"`)
into the three components type 2 bias, discrimination, and sharpness
(a.k.a. refinement) [returned in this order].

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | thresholds, 3)`                                |
   +-------------------------+------------------------------------------------+

REL_DIAG
--------

X and Y axes of the reliability diagram (`"REL_DIAG"`) and ordinates
of its associated sampling histogram: forecast probabilities (X),
observed frequencies (Y), and number of forecasts for each forecast
probability [returned in this order].

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | thresholds, bins, 3)`                          |
   +-------------------------+------------------------------------------------+

QS
--

Quantile Scores (`"QS"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(sites, lead times, subsets, samples,         |
   |                         | quantiles)`                                    |
   +-------------------------+------------------------------------------------+

CRPS
----

Continuous Ranked Probability Score (`"CRPS"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(sites, lead times, subsets, samples)`        |
   +-------------------------+------------------------------------------------+

POD
---

Probability Of Detection (`"POD"`) also known as "hit rate", derived
from the contingency table.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | levels, thresholds)`                           |
   +-------------------------+------------------------------------------------+

POFD
----

Probability Of False Detection (`"POFD"`) also known as "false alarm rate",
derived from the contingency table.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | levels, thresholds)`                           |
   +-------------------------+------------------------------------------------+

FAR
---

False Alarm Ratio (`"FAR"`), derived from the contingency table.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | levels, thresholds)`                           |
   +-------------------------+------------------------------------------------+

CSI
---

Critical Success Index (`"CSI"`), derived from the contingency table.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | levels, thresholds)`                           |
   +-------------------------+------------------------------------------------+


ROCSS
-----

Relative Operating Characteristic Skill Score (`"ROCSS"`), derived from
the contingency table, and based on computing the area under the ROC curve.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples,         |
   | `q_thr`, `events`\ [1]_ | thresholds)`                                   |
   +-------------------------+------------------------------------------------+

RANK_HIST
---------

Frequencies of the Rank Histogram (`"RANK_HIST"`), also known as the
Talagrand diagram.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(sites, lead times, subsets, samples,         |
   |                         | ranks)`                                        |
   +-------------------------+------------------------------------------------+

DS
--

Delta score (`"DS"`) as per `Candille and Talagrand (2005) <https://doi.org/10.1256/qj.04.71>`_.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(sites, lead times, subsets, samples)`        |
   +-------------------------+------------------------------------------------+

AS
--

Alpha score (`"AS"`) as per `Renard et al. (2010) <https://doi.org/10.1029/2009WR008328>`_.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(sites, lead times, subsets, samples)`        |
   +-------------------------+------------------------------------------------+

CR
--

Coverage ratio (`"CR"`), i.e. the portion of observations falling within the
predictive intervals. It is a measure of the reliability of the predictions.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples          |
   | `c_lvl`                 | intervals)`                                    |
   +-------------------------+------------------------------------------------+

AW
--

Average width (`"AW"`) of the predictive interval(s). It is a measure of the
sharpness of the predictions.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples          |
   | `c_lvl`                 | intervals)`                                    |
   +-------------------------+------------------------------------------------+

AWN
---

Average width of the predictive interval(s) normalised by the mean
observation\ [2]_ (`"AWN"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples          |
   | `c_lvl`                 | intervals)`                                    |
   +-------------------------+------------------------------------------------+

AWI
---

Average width index (`"AWI"`), computed as per
`Bourgin et al. (2015) <https://doi.org/10.5194/hess-19-2535-2015>`_.

.. math::

   AWI = 1 - \frac{AW}{AW_{climatology}}

where :math:`AW_{climatology}`\ [2]_ is the average width computed using the
observed quantiles (drawn from the observed flow duration curve)
corresponding to the confidence levels as a constant predictive interval
for the study period.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples          |
   | `c_lvl`                 | intervals)`                                    |
   +-------------------------+------------------------------------------------+

WS
---

Winkler score (`"WS"`), also known as interval score, computed as per
`Gneiting and Raftery (2007) <https://doi.org/10.1198/016214506000001437>`_.

.. math::

   WS = \frac{1}{n} \sum_{k=1}^{n} (u_k - l_k) + \frac{2}{\alpha} (l_k - x_k)𝟙\{x_k < l_k\} + \frac{2}{\alpha} (x_K - u_k)𝟙\{x_k > u_k\}

where, for a given confidence level, :math:`\alpha` is the portion not included
in the central predictive interval, :math:`u` and :math:`l` are the upper and
lower bounds of the predictive interval, respectively, :math:`x` are the
observations, and :math:`n` is the number of time steps.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples          |
   | `c_lvl`                 | intervals)`                                    |
   +-------------------------+------------------------------------------------+

WSS
---

Winkler skill score (`"WSS"`), also known as interval skill score.

.. math::

   WSS = 1 - \frac{WS}{WS_{climatology}}

where :math:`WS_{climatology}`\ [2]_ is the Winkler score computed using the
observed quantiles (drawn from the observed flow duration curve)
corresponding to the confidence levels as a constant predictive interval
for the study period.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`,       | `(sites, lead times, subsets, samples          |
   | `c_lvl`                 | intervals)`                                    |
   +-------------------------+------------------------------------------------+

.. rubric:: Footnotes

.. [1] The threshold value is included in the definition of the *events*
       both for low flow and high flow events, i.e. where a streamflow
       observation/prediction value is equal to the threshold value, the
       event is considered to have occurred.

.. [2] The metric value returned is :math:`-\infty` when the
       reference/climatology/normalisation value is zero.
