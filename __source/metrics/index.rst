.. currentmodule:: evalhyd
.. default-role:: obj

Metrics
=======

For deterministic predictions
-----------------------------

===================  ===========================================================
:ref:`NSE`           Nash-Sutcliffe Efficiency
:ref:`RMSE`          Root Mean Square Error
:ref:`KGE`           Kling-Gupta Efficiency
:ref:`KGEPRIME`      Modified Kling-Gupta Efficiency
===================  ===========================================================

For probabilistic predictions
-----------------------------

===================  ===========================================================
:ref:`BS`            Brier Score
:ref:`BSS`           Brier Skill Score
:ref:`BS_CRD`        Calibration-Refinement Decomposition of the Brier Score
:ref:`BS_LBD`        Likelihood-Base rate Decomposition of the Brier Score
:ref:`QS`            Quantile Scores
:ref:`CRPS`          Continuous Ranked Probability Score
:ref:`POD`           Probability Of Detection
:ref:`POFD`          Probability of False Detection
:ref:`FAR`           False Alarm Rate
:ref:`CSI`           Critical Success Index
:ref:`ROCSS`         Relative Operating Characteristic Skill Score
:ref:`REL_DIAG`      Reliability Diagram
:ref:`DS`            Delta Score
:ref:`AS`            Alpha Score
===================  ===========================================================

.. toctree::
   :hidden:
   :maxdepth: 2

   determinist
   probabilist