.. default-role:: obj

evalhyd::evalp
==============

.. function:: evalp(q_obs, q_prd, metrics, q_thr=NULL, t_msk=NULL)

   Function to evaluate probabilistic streamflow predictions.

   :Parameters:

      q_obs
         A numeric vector (or numeric matrix) of streamflow observations.

      q_prd
         A numeric vector (or numeric matrix) of streamflow prediction.

      metrics
         A character vector of evaluation metrics to be computed.

      q_thr, optional
         A numeric vector of streamflow thresholds to consider for
         the metrics assessing the prediction of exceedance events.
         If not provided, set to default value as an empty vector.

      t_msk, optional
        A logical matrix of masks to generate temporal subsets of the
        whole streamflow time series (where True/False is used for the
        time steps to include/discard in a given subset). If not
        provided, no subset is performed and only one set of metrics
        is returned corresponding to the whole time series. If
        provided, as many sets of metrics are returned as they are
        masks provided.

   :Returns:

      A list of numeric arrays containing evaluation metrics
      computed in the same order as given in *metrics*.

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

      .. code-block:: rconsole

         > library(evalhyd)
         > results = evalhyd::evalp(obs, prd, c("BS", "BS_LBD"), c(4., 5.))
         > results[[1]][1,1,1,]  # BS
         [1] 0.2222222 0.1333333
         > results[[2]][1,1,1,,]  # BS_LBD
                    [,1]       [,2]       [,3]
         [1,] 0.07222222 0.02777778 0.17777778
         [2,] 0.07222222 0.02777778 0.08888889

      .. code-block:: rconsole

         > evalhyd::evalp(obs, prd, c("CRPS"))[[1]][1,1,]
         [1] 0.2419355