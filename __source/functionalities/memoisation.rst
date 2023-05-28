.. currentmodule:: evalhyd
.. default-role:: obj

Memoisation
===========

Across metrics
--------------

:bdg-primary-line:`deterministic` :bdg-primary-line:`probabilistic`

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

Across masks
------------

:bdg-primary-line:`deterministic` :bdg-primary-line:`probabilistic`

In addition, most evaluation metrics first perform intermediate computations
on each time step individually (e.g. errors between individual observations
and their corresponding predictions), before performing some reduction
across all time steps (e.g. arithmetic mean of these individual errors).

If different subset periods of the entire study period are needed (i.e.
using the :doc:`temporal masking <conditional-masking>` or the
:doc:`conditional masking <conditional-masking>` functionalities), and these
sub-periods happen to overlap, it is recommended to provide several masks
at once to `evalhyd` rather than one mask at a time. Indeed, `evalhyd`
applies the masks only after the intermediate computations on individual
time steps are computed, thus optimising the computation time by avoiding
performing these intermediate computations on the same time steps several
times.
