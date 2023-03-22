.. default-role:: obj

evalhyd.evalp
=============

.. function:: evalhyd.evalp(q_obs, q_prd, metrics, q_thr=None, events=None, c_lvl=None, t_msk=None, m_cdt=None, bootstrap=None, dts=None, seed=None, diagnostics=None)

   Function to evaluate probabilistic streamflow predictions.

   .. warning::

      Parameters that are `numpy.ndarray` must not be array `views
      <https://numpy.org/doc/stable/user/basics.copies.html>`_. This may
      be the case if array `indexing <https://numpy.org/doc/stable/user/
      basics.indexing.html>`_ is performed. If indexing cannot be avoided,
      array copies must be made (i.e. using `numpy.ndarray.copy`).

   :Parameters:

      q_obs: `numpy.ndarray` ``[dtype('float64')]``
         2D array of streamflow observations. Time steps with missing
         observations must be assigned `numpy.nan` values. Those time
         steps will be ignored both in the observations and in the
         predictions before the *metrics* are computed.
         shape: (sites, time)

      q_prd: `numpy.ndarray` ``[dtype('float64')]``
         4D array of streamflow predictions. Time steps with missing
         predictions must be assigned `numpy.nan` values. Those time
         steps will be ignored both in the observations and in the
         predictions before the *metrics* are computed.
         shape: (sites, lead times, members, time)

      metrics: `List[str]`
         The sequence of evaluation metrics to be computed.
         shape: (metrics,)

         .. seealso:: :doc:`../../metrics/probabilistic`

      q_thr: `numpy.ndarray` ``[dtype('float64')]``, optional
         2D array of streamflow threshold(s) to consider for the
         *metrics* assessing the prediction of exceedance events. If
         the number of thresholds differs across sites, `numpy.nan`
         can be set as threshold for those sites with fewer thresholds.
         shape: (sites, thresholds)

      events: `str`, optional
         A string specifying the type of streamflow events to consider
         for threshold exceedance-based metrics. It can either be set
         as `"high"` when flooding conditions/high flow events are
         evaluated (i.e. event occurring when streamflow goes above
         threshold) or as `"low"` when drought conditions/low flow
         events are evaluated (i.e. event occurring when streamflow goes
         below threshold). It must be provided if *q_thr* is provided.

      c_lvl: `numpy.ndarray` ``[dtype('float64')]``, optional
         1D array of confidence interval(s) in % to consider for
         intervals-based metrics.

      t_msk: `numpy.ndarray` ``[dtype('bool')]``, optional
         4D array of masks to generate temporal subsets of the whole
         streamflow time series (where `True`/`False` is used for the
         time steps to include/discard in a given subset). If not
         provided and neither is *m_cdt*, no subset is performed and
         only one set of metrics is returned corresponding to the whole
         time series. If provided, as many sets of metrics are returned
         as they are masks provided.
         shape: (sites, lead times, subsets, time)

         .. seealso:: :doc:`../../functionalities/temporal-masking`

      m_cdt: `numpy.ndarray` ``[dtype('|S32')]``, optional
         2D array of conditions to generate temporal subsets. Each
         condition consists in a string and can be specified on
         observed/predicted streamflow values (mean, median, quantile),
         or on time indices. If provided in combination with *t_msk*,
         the latter takes precedence. If not provided and neither is
         *t_msk*, no subset is performed and only one set of metrics
         is returned corresponding to the whole time series. If
         provided, as many sets of metrics are returned as they are
         conditions provided.
         shape: (sites, subsets)

         .. seealso:: :doc:`../../functionalities/conditional-masking`

      bootstrap: `dict`, optional
         The values for the parameters of the bootstrapping method used
         to estimate the sampling uncertainty in the evaluation of the
         predictions. It takes three parameters: `"n_samples"` the
         number of random samples, `"len_samples"` the length of one
         sample in number of years; `"summary"` the statistics to return
         to characterise the sampling distribution. If not provided, no
         bootstrapping is performed. If provided, *dts* must also be
         provided.

         *Parameter example:*

         .. code-block:: python

            bootstrap={"n_samples": 100, "len_sample": 10, "summary": 0}

         .. seealso:: :doc:`../../functionalities/bootstrapping`

      dts: `numpy.ndarray` ``[dtype('|S32')]``, optional
         1D array of dates and times corresponding to the temporal
         dimension of the streamflow observations and predictions.
         The date and time must be specified in a string following the
         ISO 8601-1:2019 standard, i.e. "YYYY-MM-DD hh:mm:ss" (e.g. the
         21st of May 2007 at 4 in the afternoon is "2007-05-21 16:00:00").
         If provided, it is only used if *bootstrap* is also provided.
         shape: (time,)

      seed: `int`, optional
         An integer value for the seed used by random generators. This
         parameter guarantees the reproducibility of the metric values
         between calls.

      diagnostics: `List[str]`, optional
         The sequence of evaluation diagnostics to be computed.
         shape: (diagnostics,)

         .. seealso:: :doc:`../../functionalities/diagnostics`


   :Returns:

      `List[numpy.ndarray]`
         The sequence of evaluation metrics computed in the same order
         as given in *metrics*, followed by the sequence of evaluation
         diagnostics in the same order as given in *diagnostics*.
         shape: [(sites, lead times, subsets, samples, {quantiles,}
         {thresholds,} {components,} {ranks,} {intervals}), ...]

   :Examples:

      >>> import numpy
      >>> import evalhyd
      >>> obs = numpy.array(
      ...     [[4.7, 4.3, 5.5, 2.7, 4.1]]
      ... )
      >>> prd = numpy.array(
      ...     [[[[5.3, 4.2, 5.7, 2.3, 3.1],
      ...        [4.3, 4.2, 4.7, 4.3, 3.3],
      ...        [5.3, 5.2, 5.7, 2.3, 3.9]]]]
      ... )

      >>> bs, bs_lbd = evalhyd.evalp(obs, prd, ['BS', 'BS_LBD'], [[4., 5.]])
      >>> print(bs)
      [[[[[0.22222222 0.13333333]]]]]
      >>> print(bs_lbd)
      [[[[[[0.07222222 0.02777778 0.17777778]
           [0.07222222 0.02777778 0.08888889]]]]]]

      >>> crps, = evalhyd.evalp(obs, prd, ['CRPS'])
      >>> print(crps)
      [[[[0.1875]]]]
