.. currentmodule:: evalhyd
.. default-role:: obj

Metrics
=======

For determinist predictions
---------------------------

===================  ===========================================================
:ref:`NSE`           Nash-Sutcliffe Efficiency
:ref:`RMSE`          Root Mean Square Error
:ref:`KGE`           Kling-Gupta Efficiency
:ref:`KGEPRIME`      Modified Kling-Gupta Efficiency
===================  ===========================================================

For probabilist predictions
---------------------------

===================  ===========================================================
:ref:`BS`            Brier Score
:ref:`BSS`           Brier Skill Score
:ref:`BS_CRD`        Calibration-Refinement Decomposition of the Brier Score
:ref:`BS_LBD`        Likelihood-Base rate Decomposition of the Brier Score
:ref:`QS`            Quantile Scores
:ref:`CRPS`          Continuous Ranked Probability Score
===================  ===========================================================

.. toctree::
   :hidden:
   :maxdepth: 2

   determinist
   probabilist