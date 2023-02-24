.. currentmodule:: evalhyd
.. default-role:: obj

Transformation
==============

.. image:: https://img.shields.io/badge/-deterministic--only-275662?style=flat-square
   :alt: deterministic-only

It is common practice in hydrology to apply transform functions to the
streamflow data prior to the computation of the evaluation metrics on them.

This is typically done because most evaluation metrics are based on the
squared residuals, such that errors on high flows contribute more to the
metric value than errors on low flows. To reduce the emphasis on high flows,
various transform functions can be applied (see e.g. `Garcia et al. (2017)
<https://doi.org/10.1080/02626667.2017.1308511>`_ for transformations
putting more emphasis on low flows).

`evalhyd` offers a variety of transform functions accessible through the
*transform* parameter and whose possible values are summarised in the
table below.

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

.. note::

   Since none of the reciprocal function, the natural logarithm, nor
   the power function with a negative exponent are defined for zero, a
   small constant ε must be added to both the streamflow observations
   and predictions prior to the calculation of the evaluation metrics.
   By default, one hundredth of the mean of the streamflow observations
   is used as value for ε, as recommended by `Pushpalatha et al. (2012)
   <https://doi.org/10.1016/j.jhydrol.2011.11.055>`_. It is customisable
   through the *epsilon* parameter.

A few examples of flow transformations are provided below.

.. tabbed:: Python

   .. code-block:: python

      >>> res = evalhyd.evald(obs, prd, ["NSE"], transform="sqrt")
      >>> res = evalhyd.evald(obs, prd, ["RMSE"], transform="log")
      >>> res = evalhyd.evald(obs, prd, ["KGE"], transform="inv", epsilon=.5)
      >>> res = evalhyd.evald(obs, prd, ["NSE"], transform="pow", exponent=.8)

.. tabbed:: R

   .. code-block:: RConsole

      > res <- evalhyd::evald(obs, prd, c("NSE"), transform="sqrt")
      > res <- evalhyd::evald(obs, prd, c("RMSE"), transform="log")
      > res <- evalhyd::evald(obs, prd, c("KGE"), transform="inv", epsilon=.5)
      > res <- evalhyd::evald(obs, prd, c("NSE"), transform="pow", exponent=.8)

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evald "obs.csv" "prd.csv" "NSE" --to_file --transform "sqrt"
      $ ./evalhyd evald "obs.csv" "prd.csv" "RMSE" --to_file --transform "log"
      $ ./evalhyd evald "obs.csv" "prd.csv" "KGE" --to_file --transform "inv" --epsilon .5
      $ ./evalhyd evald "obs.csv" "prd.csv" "NSE" --to_file --transform "pow" --exponent .8
