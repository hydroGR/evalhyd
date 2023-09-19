.. currentmodule:: evalhyd
.. default-role:: obj

Metrics
=======

For deterministic predictions
-----------------------------

=====================  ========================================================
:ref:`MAE`             Mean Absolute Error
:ref:`MARE`            Mean Absolute Relative Error
:ref:`MSE`             Mean Square Error
:ref:`RMSE`            Root Mean Square Error
:ref:`NSE`             Nash-Sutcliffe Efficiency
:ref:`KGE`             Kling-Gupta Efficiency
:ref:`KGE_D`           Kling-Gupta Efficiency Decomposed
:ref:`KGEPRIME`        Modified Kling-Gupta Efficiency
:ref:`KGEPRIME_D`      Modified Kling-Gupta Efficiency Decomposed
:ref:`KGENP`           Non-Parametric Kling-Gupta Efficiency
:ref:`KGENP_D`         Non-Parametric Kling-Gupta Efficiency Decomposed
:ref:`CONT_TBL`        Contingency Table
=====================  ========================================================

For probabilistic predictions
-----------------------------

=====================  ========================================================
:ref:`BS`              Brier Score
:ref:`BSS`             Brier Skill Score
:ref:`BS_CRD`          Calibration-Refinement Decomposition of the Brier Score
:ref:`BS_LBD`          Likelihood-Base rate Decomposition of the Brier Score
:ref:`REL_DIAG`        Reliability Diagram
:ref:`CRPS_FROM_BS`    Continuous Ranked Probability Score from Brier Scores
:ref:`CRPS_FROM_ECDF`  Continuous Ranked Probability Score from Empirical CDF
:ref:`QS`              Quantile Scores
:ref:`CRPS_FROM_QS`    Continuous Ranked Probability Score from Quantile Scores
:ref:`POD`             Probability Of Detection
:ref:`POFD`            Probability of False Detection
:ref:`FAR`             False Alarm Rate
:ref:`CSI`             Critical Success Index
:ref:`ROCSS`           Relative Operating Characteristic Skill Score
:ref:`RANK_HIST`       Rank Histogram
:ref:`DS`              Delta Score
:ref:`AS`              Alpha Score
:ref:`CR`              Coverage Ratio
:ref:`AW`              Average Width
:ref:`AWN`             Average Width Normalised
:ref:`WS`              Winkler Score
:ref:`ES`              Energy Score
=====================  ========================================================

.. toctree::
   :hidden:
   :maxdepth: 2

   deterministic
   probabilistic
