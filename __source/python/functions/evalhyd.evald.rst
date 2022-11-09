.. default-role:: obj

evalhyd.evald
=============

.. function:: evalhyd.evald(q_obs, q_prd, metrics, transform="none", exponent=1, epsilon=-9, t_msk=[[]], m_cdt=[], bootstrap={"n_samples": -9, "len_sample": -9, "summary": 0}, dts=[])

   Function to evaluate deterministic streamflow predictions.

   :Parameters:

       q_obs: `numpy.ndarray`
          1D or 2D array of streamflow observations. Time steps with
          missing observations must be assigned `numpy.nan` values.
          Those time steps will be ignored both in the observations
          and in the predictions before the *metrics* are computed.
          Observations and predictions must feature the same number of
          dimensions.
          shape: (time,) or (1, time)

       q_prd: `numpy.ndarray`
          1D or 2D array of streamflow predictions. Time steps with
          missing predictions must be assigned `numpy.nan` values.
          Those time steps will be ignored both in the observations
          and the predictions before the *metrics* are computed.
          Observations and predictions must feature the same number of
          dimensions.
          shape: (time,) or (series, time)

       metrics: `List[str]`
          The sequence of evaluation metrics to be computed.

       transform: `str`, optional
          The transformation to apply to both streamflow observations
          and predictions prior to the calculation of the *metrics*.

          .. seealso:: :doc:`../../functionalities/transformation`

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

       t_msk: `numpy.ndarray`, optional
          2D array of mask(s) used to generate temporal subsets of
          the whole streamflow time series (where `True`/`False` is used
          for the time steps to include/discard in a given subset). If
          not provided and neither is *m_cdt*, no subset is performed.
          If provided, masks must feature the same number of dimensions
          as observations and predictions, and it must broadcastable
          with both of them.
          shape: (subsets, time)

          .. seealso:: :doc:`../../functionalities/temporal-masking`

       m_cdt: `numpy.ndarray`, optional
          1D array of masking condition(s) to use to generate temporal
          subsets. Each condition consists in a string and can be
          specified on observed streamflow values/statistics (mean,
          median, quantile), or on time indices. If provided in
          combination with *t_msk*, the latter takes precedence. If not
          provided and neither is *t_msk*, no subset is performed. If
          provided, only one condition per time series of observations
          can be provided.
          shape: (subsets,)

          .. seealso:: :doc:`../../functionalities/conditional-masking`

       bootstrap: `dict`, optional
          The values for the parameters of the bootstrapping method used
          to estimate the sampling uncertainty in the evaluation of the
          predictions. Three parameters are mandatory: `"n_samples"`
          the number of random samples, `"len_samples"` the length of
          one sample in number of years; `"summary"` the statistics to
          return to characterise the sampling distribution. One
          parameter is optional: `"seed"` the seed for the random
          generator. If not provided, no bootstrapping is performed. If
          provided, *dts* must also be provided.

          *Parameter example:*

          .. code-block:: python

             bootstrap={"n_samples": 100, "len_sample": 10, "summary": 0}

          .. seealso:: :doc:`../../functionalities/bootstrapping`

       dts: `List[str]`, optional
          The sequence of corresponding dates and times for the
          temporal dimension of the streamflow observations and
          predictions. The date and time must be specified in a string
          following the ISO 8601-1:2019 standard, i.e.
          "YYYY-MM-DD hh:mm:ss" (e.g. the 21st of May 2007 at 4 in the
          afternoon is "2007-05-21 16:00:00"). If provided, it is only
          used if *bootstrap* is also provided.
          shape: (time,)

   :Returns:

       `List[numpy.ndarray]`
           The sequence of evaluation metrics computed
           in the same order as given in *metrics*.
           shape: [(series, subsets, samples), ...]

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
      [[[0.6254771]]]
      
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
      [[[0.6254771 ]]
       [[0.04341603]]
       [[0.66364504]]]

      >>> nse, = evalhyd.evald(obs, prd, ['NSE'], transform='sqrt')
      >>> print(nse)
      [[[ 0.60338006]]
       [[-0.00681063]]
       [[ 0.69728089]]]

      >>> nse, = evalhyd.evald(obs, prd, ['NSE'], transform='log', epsilon=.5)
      >>> print(nse)
      [[[ 0.58134179]]
       [[-0.04589215]]
       [[ 0.71432742]]]

      >>> nse, = evalhyd.evald(obs, prd, ['NSE'], transform='pow', exponent=.8)
      >>> print(nse)
      [[[0.61757466]]
       [[0.02342582]]
       [[0.67871023]]]
