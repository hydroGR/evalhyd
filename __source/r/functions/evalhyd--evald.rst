.. default-role:: obj

evalhyd::evald
==============

.. function:: evald(q_obs, q_prd, metrics, transform="none", exponent=1, epsilon=-9)

   Function to evaluate deterministic streamflow predictions.

   :Parameters:

      q_obs
         A numeric vector (or numeric matrix) of streamflow observations.
         Time steps with missing observations must be assigned `NA`
         values. Those time steps will be ignored both in the
         observations and in the predictions before the *metrics* are
         computed. Observations and predictions must feature the same
         number of dimensions and they must be broadcastable.

      q_prd
         A numeric vector (or numeric matrix) of streamflow prediction.
         Time steps with missing predictions must be assigned `NA`
         values. Those time steps will be ignored both in the
         observations and in the predictions before the *metrics* are
         computed. Observations and predictions must feature the same
         number of dimensions and they must be broadcastable.

      metrics
         A character vector of evaluation metrics to be computed.

      transform, optional
          The transformation to apply to both streamflow observations
          and predictions prior to the calculation of the *metrics*.
          The options are listed in the table below.

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

       exponent, optional
          The value of the exponent n to use when the *transform* is
          the power function. If not provided (or set to default value
          1), the streamflow observations and predictions remain
          untransformed.

       epsilon, optional
          The value of the small constant ε to add to both the
          streamflow observations and predictions prior to the
          calculation of the *metrics* when the *transform* is the
          reciprocal function, the natural logarithm, or the power
          function with a negative exponent (since none are defined
          for 0). If not provided (or set to default value -9),
          one hundredth of the mean of the streamflow observations
          is used as value for epsilon, as recommended by
          `Pushpalatha et al. (2012)
          <https://doi.org/10.1016/j.jhydrol.2011.11.055>`_.

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
