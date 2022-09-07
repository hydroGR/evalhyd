.. default-role:: obj

evalhyd.evalp
=============

.. function:: evalhyd.evalp(q_obs, q_prd, metrics, q_thr=None, t_msk=None, m_cdt=None)

   Function to evaluate probabilistic streamflow predictions.

   :Parameters:

       q_obs: `numpy.ndarray`
           2D array of streamflow observations. Time steps with missing
           observations must be assigned `numpy.nan` values. Those time
           steps will be ignored both in the observations and in the
           predictions before the *metrics* are computed.
           shape: (sites, time)

       q_prd: `numpy.ndarray`
           4D array of streamflow predictions. Time steps with missing
           predictions must be assigned `numpy.nan` values. Those time
           steps will be ignored both in the observations and in the
           predictions before the *metrics* are computed.
           shape: (sites, lead times, members, time)

       metrics: `List[str]`
           The sequence of evaluation metrics to be computed.
           shape: (metrics,)

       q_thr: `numpy.ndarray`, optional
           2D array of streamflow threshold(s) to consider for the
           *metrics* assessing the prediction of exceedance events. If
           the number of thresholds differs across sites, `numpy.nan`
           can be set as threshold for those sites with fewer thresholds.
           shape: (sites, thresholds)

       t_msk: `numpy.ndarray`, optional
           3D array of masks to generate temporal subsets of the whole
           streamflow time series (where `True`/`False` is used for the
           time steps to include/discard in a given subset). If not
           provided, no subset is performed and only one set of metrics
           is returned corresponding to the whole time series. If
           provided, as many sets of metrics are returned as they are
           masks provided.
           shape: (sites, subsets, time)

           .. seealso:: :doc:`../../functionalities/temporal-masking`

       m_cdt: `numpy.ndarray`, optional
           2D array of conditions to generate temporal subsets. Each
           condition consists in a string and can be specified on
           observed streamflow values or on time indices. If provided
           in combination with t_msk, the latter takes precedence. If
           not provided and neither is t_msk, no subset is performed
           and only one set of metrics is returned corresponding to
           the whole time series. If provided, as many sets of metrics
           are returned as they are conditions provided.
           shape: (sites, subsets)

           .. seealso:: :doc:`../../functionalities/conditional-masking`

   :Returns:

       `List[numpy.ndarray]`
           The sequence of evaluation metrics computed
           in the same order as given in *metrics*.
           shape: [(sites, lead times, subsets, {quantiles,} {thresholds,}
           {components}), ...]

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
      [[[[0.22222222 0.13333333]]]]
      >>> print(bs_lbd)
      [[[[[0.07222222 0.02777778 0.17777778]
          [0.07222222 0.02777778 0.08888889]]]]]

      >>> crps, = evalhyd.evalp(obs, prd, ['CRPS'])
      >>> print(crps)
      [[[0.24193548]]]
