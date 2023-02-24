.. default-role:: obj

evalhyd::evald
==============

.. function:: evald(q_obs, q_prd, metrics, transform=NULL, exponent=NULL, epsilon=NULL, t_msk=NULL, bootstrap=NULL, dts=NULL, seed=NULL)

   Function to evaluate deterministic streamflow predictions.

   :Parameters:

      q_obs
         A numeric vector (or numeric matrix) of streamflow observations.
         Time steps with missing observations must be assigned `NA`
         values. Those time steps will be ignored both in the
         observations and in the predictions before the *metrics* are
         computed. Observations and predictions must feature the same
         number of dimensions.
         shape: (time,) or (1, time)

      q_prd
         A numeric vector (or numeric matrix) of streamflow prediction.
         Time steps with missing predictions must be assigned `NA`
         values. Those time steps will be ignored both in the
         observations and in the predictions before the *metrics* are
         computed. Observations and predictions must feature the same
         number of dimensions.
         shape: (time,) or (series, time)

      metrics
         A string vector of evaluation metrics to be computed.
         shape: (metrics,)

      transform, optional
         The transformation to apply to both streamflow observations
         and predictions prior to the calculation of the *metrics*.

         .. seealso:: :doc:`../../functionalities/transformation`

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

      t_msk, optional
         A logical array of mask(s) to use to temporally subset of the
         whole streamflow time series (where `TRUE`/`FALSE` is used for
         the time steps to include/discard in the subset).
         shape: (series, subsets, time)

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
      shape: [(series, subsets, samples, {components}), ...]

   :Examples:

      .. code-block:: rconsole

         > obs = c(4.7, 4.3, 5.5, 2.7, 4.1)
         > prd = c(5.3, 4.2, 5.7, 2.3, 3.1)
         > library(evalhyd)
         > evalhyd::evald(obs, prd, c("NSE"))
         [[1]]
         , , 1

                   [,1]
         [1,] 0.6254771

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
         , , 1

                    [,1]
         [1,] 0.62547710
         [2,] 0.04341603
         [3,] 0.66364504

      .. code-block:: rconsole

         > evalhyd::evald(obs, prd, c("NSE"), transform="sqrt")
         [[1]]
         , , 1

                      [,1]
         [1,]  0.603380063
         [2,] -0.006810629
         [3,]  0.697280893

      .. code-block:: rconsole

         > evalhyd::evald(obs, prd, c("NSE"), transform="log", epsilon=.5)
         [[1]]
         , , 1

                     [,1]
         [1,]  0.58134179
         [2,] -0.04589215
         [3,]  0.71432742

      .. code-block:: rconsole

         > evalhyd::evald(obs, prd, c("NSE"), transform="pow", exponent=.8)
         [[1]]
         , , 1

                    [,1]
         [1,] 0.61757466
         [2,] 0.02342582
         [3,] 0.67871023