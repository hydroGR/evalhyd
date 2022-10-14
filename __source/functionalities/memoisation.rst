.. currentmodule:: evalhyd
.. default-role:: obj

Memoisation
===========

.. image:: https://img.shields.io/badge/-determinist-275662?style=flat-square
   :alt: determinist

.. image:: https://img.shields.io/badge/-probabilist-275662?style=flat-square
   :alt: probabilist

Since certain evaluation metrics require the same intermediate computations,
there is scope for some optimisation by storing these intermediate computations
so that they can be used by all the evaluation metrics requiring them (i.e.
the concept of *memoisation* in computing).

For example, the determinist metrics *NSE* and *KGE* both require to compute
the quadratic error between the observations and their arithmetic mean, so it
is more efficient to compute this quadratic error only once, and reuse it in
the computation of both *NSE* and *KGE*.

`evalhyd` implements such approach to compute its evaluation metrics, this is
why it is recommended to ask for all evaluation metrics of interest at once in
a single call to `evalhyd` rather than ask for them separately in several
calls.

That is to say, prefer:

.. tabbed:: Python

   .. code-block:: python

      >>> evalhyd.evald(obs, prd, ["NSE", "KGE"])

.. tabbed:: R

   .. code-block:: RConsole

      > evalhyd::evald(obs, prd, c("NSE", "KGE"))

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evald "obs.csv" "prd.csv" "NSE" "KGE"

over:


.. tabbed:: Python

   .. code-block:: python

      >>> evalhyd.evald(obs, prd, ["NSE"])
      >>> evalhyd.evald(obs, prd, ["KGE"])

.. tabbed:: R

   .. code-block:: RConsole

      > evalhyd::evald(obs, prd, c("NSE"))
      > evalhyd::evald(obs, prd, c("KGE"))

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evald "obs.csv" "prd.csv" "NSE"
      $ ./evalhyd evald "obs.csv" "prd.csv" "KGE"