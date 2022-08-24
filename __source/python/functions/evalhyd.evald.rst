.. default-role:: obj

evalhyd.evald
=============

.. function:: evalhyd.evald(q_obs, q_prd, metrics)

   Function to evaluate deterministic streamflow predictions.

   :Parameters:

       q_obs: `numpy.ndarray`
           1D or 2D array of streamflow observations. Time steps with
           missing observations must be assigned `numpy.nan` values.
           Those time steps will be ignored both in the observations and
           in the predictions before the *metrics* are computed.
           Observations and predictions must feature the same number of
           dimensions and they must be broadcastable.
           shape: (time,) or (1+, time)

       q_prd: `numpy.ndarray`
           1D or 2D array of streamflow predictions. Time steps with
           missing predictions must be assigned `numpy.nan` values.
           Those time steps will be ignored both in the observations and
           the predictions before the *metrics* are computed.
           Observations and predictions must feature the same number of
           dimensions and they must be broadcastable.
           shape: (time,) or (1+, time)

       metrics: `List[str]`
           The sequence of evaluation metrics to be computed.

       transform: `str`, optional
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

       exponent: `float`, optional
          The value of the exponent n to use when the *transform* is
          the power function. If not provided (or set to default value
          1), the streamflow observations and predictions remain
          untransformed.

       epsilon: `float`, optional
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

       `List[numpy.ndarray]`
           The sequence of evaluation metrics computed
           in the same order as given in *metrics*.
           shape: [(components,), ...] or [(1+, components), ...]

   :Examples:

      >>> import numpy
      >>> import evalhyd
      >>> obs = numpy.array(
      ...     [4.7, 4.3, 5.5, 2.7, 4.1]
      ... )
      >>> prd = numpy.array(
      ...     [5.3, 4.2, 5.7, 2.3, 3.1]
      ... )
      >>> nse, = evalhyd.evald(obs, prd, ['NSE'])
      >>> print(nse)
      [0.6254771]
      
      >>> obs = numpy.array(
      ...     [[4.7, 4.3, 5.5, 2.7, 4.1]]
      ... )
      >>> prd = numpy.array(
      ...     [[5.3, 4.2, 5.7, 2.3, 3.1],
      ...      [4.3, 4.2, 4.7, 4.3, 3.3],
      ...      [5.3, 5.2, 5.7, 2.3, 3.9]]
      ... )
      >>> nse, = evalhyd.evald(obs, prd, ['NSE'])
      >>> print(nse)
      [[0.6254771 ]
       [0.04341603]
       [0.66364504]]

      >>> nse, = evalhyd.evald(obs, prd, ['NSE'], transform='sqrt')
      >>> print(nse)
      [[ 0.60338006]
       [-0.00681063]
       [ 0.69728089]]

      >>> nse, = evalhyd.evald(obs, prd, ['NSE'], transform='log', epsilon=.5)
      >>> print(nse)
      [[ 0.58134179]
       [-0.04589215]
       [ 0.71432742]]

      >>> nse, = evalhyd.evald(obs, prd, ['NSE'], transform='pow', exponent=.8)
      >>> print(nse)
      [[0.61757466]
       [0.02342582]
       [0.67871023]]
