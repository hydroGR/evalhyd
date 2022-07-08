.. default-role:: obj

evalhyd::evald
==============

.. function:: evald(q_obs, q_prd, metrics)

   Function to evaluate deterministic streamflow predictions.

   :Parameters:

      q_obs
         A numeric vector (or numeric matrix) of streamflow observations.

      q_prd
         A numeric vector (or numeric matrix) of streamflow prediction.

      metrics
         A character vector of evaluation metrics to be computed.

   :Returns:

      A list of numeric arrays containing evaluation metrics
      computed in the same order as given in *metrics*.

   :Examples:

      .. code-block:: rconsole

         > obs = c(4.7, 4.3, 5.5, 2.7, 4.1)
         > prd = c(5.3, 4.2, 5.7, 2.3, 3.1)
         > library(evalhyd)
         > evalhyd::evald(obs, prd, c("NSE"))
         [[1]]
         [1] 0.6254771

      .. code-block:: rconsole

         > obs = rbind(
         +     c(4.7, 4.3, 5.5, 2.7, 4.1)
         + )
         > prd = rbind(
         +     c(5.3, 4.2, 5.7, 2.3, 3.1),
         +     c(4.3, 4.2, 4.7, 4.3, 3.3),
         +     c(5.3, 5.2, 5.7, 2.3, 3.9)
         + )
         > evalhyd::evald(obs, prd, c("NSE"))
         [[1]]
                    [,1]
         [1,] 0.62547710
         [2,] 0.04341603
         [3,] 0.66364504
