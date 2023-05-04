.. default-role:: obj

evalhyd::evalp
==============

.. function:: evalp(q_obs, q_prd, metrics, q_thr=NULL, events=NULL, c_lvl=NULL, t_msk=NULL, bootstrap=NULL, dts=NULL, seed=NULL, diagnostics=NULL)

   Function to evaluate probabilistic streamflow predictions.

   :Parameters:

      q_obs
         A numeric array of streamflow observations. Time steps with
         missing observations must be assigned `NA` values. Those time
         steps will be ignored both in the observations and in the
         predictions before the *metrics* are computed.
         shape: (sites, time)

      q_prd
         A numeric array of streamflow predictions. Time steps with
         missing predictions must be assigned `NA` values. Those time
         steps will be ignored both in the observations and in the
         predictions before the *metrics* are computed.
         shape: (sites, lead times, members, time)

      metrics
         A string vector of evaluation metrics to be computed.
         shape: (metrics,)

         .. seealso:: :doc:`../../metrics/probabilistic`

      q_thr, optional
         A numeric matrix of streamflow thresholds to consider for
         the metrics assessing the prediction of exceedance events.
         If the number of thresholds differs across sites, `NA` can be
         set as threshold for those sites with fewer thresholds.
         shape: (sites, thresholds)

      events, optional
         A string specifying the type of streamflow events to consider
         for threshold exceedance-based metrics. It can either be set as
         `"high"` when flooding conditions/high flow events are
         evaluated (i.e. event occurring when streamflow goes above
         threshold) or as `"low"` when drought conditions/low flow
         events are evaluated (i.e. event occurring when streamflow goes
         below threshold). It must be provided if *q_thr* is provided.

      c_lvl, optional
         A numeric vector containing the confidence interval(s) in % to
         consider for intervals-based metrics.

      t_msk, optional
         A logical array of masks to generate temporal subsets of the
         whole streamflow time series (where `TRUE`/`FALSE` is used for
         the time steps to include/discard in a given subset). If not
         provided, no subset is performed and only one set of metrics
         is returned corresponding to the whole time series. If
         provided, as many sets of metrics are returned as they are
         masks provided.
         shape: (sites, lead times, subsets, time)

         .. warning::

            The use of this parameter will raise a warning regarding
            a coerced object from 'logical' to 'double'. This is a
            known issue (see `#2 <https://gitlab.irstea.fr/HYCAR-Hydro/
            evalhyd/evalhyd-r/-/issues/2>`_) that does not impact on
            the numerical validity of the results obtained. However,
            until this issue is resolved, the user is warned that an
            unnecessary copy of the provided mask is made to comply
            with the expected data type.

         .. seealso:: :doc:`../../functionalities/temporal-masking`

      bootstrap, optional
         The values for the parameters of the bootstrapping method used
         to estimate the sampling uncertainty in the evaluation of the
         predictions. It takes three parameters: `"n_samples"` the
         number of random samples, `"len_samples"` the length of one
         sample in number of years, and `"summary"` the statistics to
         return to characterise the sampling distribution. If not
         provided, no bootstrapping is performed. If provided, *dts*
         must also be provided.

         *Parameter example:*

         .. code-block:: r

            bootstrap=list(n_samples=100, len_sample=10, summary=0)

         .. seealso:: :doc:`../../functionalities/bootstrapping`

      dts, optional
         A string vector of corresponding dates and times for the
         temporal dimension of the streamflow observations and
         predictions. The date and time must be specified in a string
         following the ISO 8601-1:2019 standard, i.e.
         "YYYY-MM-DD hh:mm:ss" (e.g. the 21st of May 2007 at 4 in the
         afternoon is "2007-05-21 16:00:00"). If provided, it is only
         used if *bootstrap* is also provided.
         shape: (time,)

      seed, optional
         An integer value for the seed used by random generators. This
         parameter guarantees the reproducibility of the metric values
         between calls.

      diagnostics, optional
         A string vector of evaluation diagnostics to be computed.
         shape: (diagnostics,)

         .. seealso:: :doc:`../../functionalities/diagnostics`

   :Returns:

      A list of numeric arrays containing evaluation metrics computed
      in the same order as given in *metrics*, followed by evaluation
      diagnostics in the same order as given in *diagnostics*.
      shape: [(sites, lead times, subsets, samples, {quantiles,}
      {thresholds,} {components,} {ranks,} {intervals}), ...]


   :Examples:

      .. code-block:: rconsole

         > obs = rbind(
         +     c(4.7, 4.3, 5.5, 2.7, 4.1)
         + )
         > prd = array(
         +     rbind(
         +         c(5.3, 4.2, 5.7, 2.3, 3.1),
         +         c(4.3, 4.2, 4.7, 4.3, 3.3),
         +         c(5.3, 5.2, 5.7, 2.3, 3.9)
         +     ),
         +     dim=c(1, 1, 3, 5)
         + )
         > thr = rbind(
         +     c(4., 5.)
         + )

      .. code-block:: rconsole

         > library(evalhyd)
         > results = evalhyd::evalp(obs, prd, c("BS", "BS_LBD"), thr)
         > results[[1]][1,1,1,1,]  # BS
         [1] 0.2222222 0.1333333
         > results[[2]][1,1,1,1,,]  # BS_LBD
                    [,1]       [,2]       [,3]
         [1,] 0.07222222 0.02777778 0.17777778
         [2,] 0.07222222 0.02777778 0.08888889

      .. code-block:: rconsole

         > evalhyd::evalp(obs, prd, c("CRPS_FROM_QS"))[[1]][1,1,1,]
         [1] 0.1875