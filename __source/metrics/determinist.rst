.. currentmodule:: evalhyd
.. default-role:: obj

Determinist
===========

NSE
---

Nash-Sutcliffe Efficiency (`"NSE"`) as per `Nash and Sutcliffe (1970)
<https://doi.org/10.1016/0022-1694(70)90255-6>`_.

==================  ====================================  =====================
Required inputs     Optional inputs                       Output shape
==================  ====================================  =====================
`q_obs`, `q_prd`    `transform`, `exponent`, `epsilon`    `({...,} 1)`
==================  ====================================  =====================

.. tabbed:: Python

   .. code-block:: python

      >>> import numpy
      ... obs = numpy.array([4.7, 4.3, 5.5, 2.7])
      ... prd = numpy.array([5.3, 4.2, 5.7, 2.3])
      >>> import evalhyd
      ... evalhyd.evald(obs, prd, ["NSE"])
      [array([[[0.86298077]]])]

.. tabbed:: R

   .. code-block:: RConsole

      > obs = c(4.7, 4.3, 5.5, 2.7)
      > prd = c(5.3, 4.2, 5.7, 2.3)
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

RMSE
----

Root Mean Square Error (`"RMSE"`).

==================  ====================================  =====================
Required inputs     Optional inputs                       Output shape
==================  ====================================  =====================
`q_obs`, `q_prd`    `transform`, `exponent`, `epsilon`    `({...,} 1)`
==================  ====================================  =====================


KGE
---

Kling-Gupta Efficiency (`"KGE"`) as per `Gupta et al., 2009
<https://doi.org/10.1016/j.jhydrol.2009.08.003>`_.

==================  ====================================  =====================
Required inputs     Optional inputs                       Output shape
==================  ====================================  =====================
`q_obs`, `q_prd`    `transform`, `exponent`, `epsilon`    `({...,} 1)`
==================  ====================================  =====================

.. warning::

   Using a log-transform for this metric is not recommended (see `Santos
   et al., 2018 <https://doi.org/10.5194/hess-22-4583-2018>`_).


KGEPRIME
--------

Modified Kling-Gupta Efficiency (`"KGEPRIME"`) as per `Kling et al., 2012
<https://doi.org/10.1016/j.jhydrol.2012.01.011>`_.

==================  ====================================  =====================
Required inputs     Optional inputs                       Output shape
==================  ====================================  =====================
`q_obs`, `q_prd`    `transform`, `exponent`, `epsilon`    `({...,} 1)`
==================  ====================================  =====================

.. warning::

   Using a log-transform for this metric is not recommended (see `Santos
   et al., 2018 <https://doi.org/10.5194/hess-22-4583-2018>`_).
