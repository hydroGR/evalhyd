.. currentmodule:: evalhyd
.. default-role:: obj

Determinist
===========

.. tip::

   All the metrics listed below are accessible via ``evald``, the deterministic
   entry point of `evalhyd`.

   For example, the Nash-Sutcliffe efficiency can be computed as follows:

   .. tabbed:: C++

      .. code-block:: cpp

         #include <xtensor/xtensor.hpp>
         #include <xtensor/xio.hpp>
         #include <evalhyd/evald.hpp>

         xt::xtensor<double, 2> obs = {{4.7, 4.3, 5.5, 2.7}};
         xt::xtensor<double, 2> prd = {{5.3, 4.2, 5.7, 2.3}};

         std::cout << evalhyd::evald(obs, prd, {"NSE"})[0] << std::endl;
         // {{{ 0.862981}}}

   .. tabbed:: Python

      .. code-block:: python

         >>> import numpy
         ... obs = numpy.array([[4.7, 4.3, 5.5, 2.7]])
         ... prd = numpy.array([[5.3, 4.2, 5.7, 2.3]])
         >>> import evalhyd
         ... evalhyd.evald(obs, prd, ["NSE"])
         [array([[[0.86298077]]])]

   .. tabbed:: R

      .. code-block:: RConsole

         > obs <- rbind(c(4.7, 4.3, 5.5, 2.7))
         > prd <- rbind(c(5.3, 4.2, 5.7, 2.3))
         > library(evalhyd)
         > evalhyd::evald(obs, prd, c("NSE"))
         [[1]]
         , , 1

                   [,1]
         [1,] 0.8629808

   .. tabbed:: CLI

      .. code-block:: console

         $ ./evalhyd evald "obs.csv" "prd.csv" "NSE"
         {{{ 0.862981}}}

MAE
---

Mean Absolute Error (`"MAE"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+


MARE
----

Mean Absolute Relative Error (`"MARE"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+

MSE
---

Mean Square Error (`"MSE"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+

RMSE
----

Root Mean Square Error (`"RMSE"`).

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+

NSE
---

Nash-Sutcliffe Efficiency (`"NSE"`) as per `Nash and Sutcliffe (1970)
<https://doi.org/10.1016/0022-1694(70)90255-6>`_.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+

KGE
---

Kling-Gupta Efficiency\ [1]_ (`"KGE"`) as per `Gupta et al., 2009
<https://doi.org/10.1016/j.jhydrol.2009.08.003>`_.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+

KGE_D
-----

Kling-Gupta Efficiency Decomposition\ [1]_ (`"KGE_D"`) into its
three components :math:`r_{pearson}`, :math:`\alpha`, :math:`\beta`,
in this order.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples, 3)`                |
   +-------------------------+------------------------------------------------+

KGEPRIME
--------

Modified Kling-Gupta Efficiency\ [1]_ (`"KGEPRIME"`) as per `Kling et al., 2012
<https://doi.org/10.1016/j.jhydrol.2012.01.011>`_.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+

KGEPRIME_D
----------

Modified Kling-Gupta Efficiency Decomposition\ [1]_ (`"KGEPRIME_D"`) into its
three components :math:`r_{pearson}`, :math:`\gamma`, :math:`\beta`,
in this order.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples, 3)`                |
   +-------------------------+------------------------------------------------+

KGENP
-----

Non-Parametric Kling-Gupta Efficiency\ [1]_ (`"KGENP"`) as per `Pool et al., 2018
<https://doi.org/10.1080/02626667.2018.1552002>`_.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples)`                   |
   +-------------------------+------------------------------------------------+


KGENP_D
-------

Non-Parametric Kling-Gupta Efficiency Decomposition\ [1]_ (`"KGENP_D"`) into its
three components :math:`r_{spearman}`, :math:`\alpha_{NP}`, :math:`\beta`,
in this order.

.. table::
   :widths: 35 65

   +-------------------------+------------------------------------------------+
   | Required inputs         | Output shape                                   |
   +=========================+================================================+
   | `q_obs`, `q_prd`        | `(series, subsets, samples, 3)`                |
   +-------------------------+------------------------------------------------+


.. rubric:: Footnotes

.. [1] Using a log-transform for this metric is not recommended (see `Santos
       et al., 2018 <https://doi.org/10.5194/hess-22-4583-2018>`_).
