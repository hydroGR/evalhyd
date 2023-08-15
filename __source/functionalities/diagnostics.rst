.. currentmodule:: evalhyd
.. default-role:: obj

Diagnostics
===========

Completeness
------------

:bdg-primary-line:`deterministic` :bdg-primary-line:`probabilistic`

Because of :doc:`missing data <missing-data>`, the optional use of
:doc:`temporal <temporal-masking>`/:doc:`conditional <conditional-masking>`,
and/or the optional use of :doc:`bootstrapping <bootstrapping>`, the
number of time steps in the period used to compute the evaluation metrics
may vary and may be reduced unreasonably. This is why the *completeness*
diagnostic is available: it returns the number of time steps included in
each period considered, i.e. once missing data have been discarded, and
masking and bootstrapping temporal subsets have been performed.

:bdg-primary-line:`deterministic-only`

The returned shape of the *completeness* diagnostic is
``(series, subsets, samples)``.

.. tabbed:: Python

   .. code-block:: python

      >>> res = evalhyd.evald(
      ...     obs, prd,
      ...     metrics=["NSE"],
      ...     diagnostics=["completeness"]
      ... )

.. tabbed:: R

   .. code-block:: RConsole

      > res <- evalhyd::evald(
      +     obs, prd,
      +     metrics = c("NSE"),
      +     diagnostics = c("completeness")
      + )

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evald "obs.csv" "prd.csv" "NSE" --to_file \
      > --diagnostics "completeness"

:bdg-primary-line:`probabilistic-only`

The returned shape of the *completeness* diagnostic is
``(sites, lead times, subsets, samples)``.

.. tabbed:: Python

   .. code-block:: python

      >>> res = evalhyd.evalp(
      ...     obs, prd,
      ...     metrics=["CRPS_FROM_ECDF"],
      ...     diagnostics=["completeness"]
      ... )

.. tabbed:: R

   .. code-block:: RConsole

      > res <- evalhyd::evalp(
      +     obs, prd,
      +     metrics = c("CRPS_FROM_ECDF"),
      +     diagnostics = c("completeness")
      + )

.. tabbed:: CLI

   .. code-block:: console

      $ ./evalhyd evalp "./obs" "./prd" "CRPS_FROM_ECDF" --to_file \
      > --diagnostics "completeness"