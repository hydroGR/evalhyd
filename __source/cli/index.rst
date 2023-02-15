.. currentmodule:: evalhyd
.. default-role:: obj

Command Line
============

`evalhyd-cli` is a command line executable to evaluate deterministic and probabilistic
streamflow predictions.

Getting started
---------------

.. panels::
   :card: + intro-card text-center
   :column: col-lg-3 col-md-3 col-sm-6 col-xs-12 p-2
   :footer: bg-white border-0

   ---

   :fa:`rocket,text-info fa-4x,style=fa`

   +++

   .. link-button:: installation
      :type: ref
      :text: Installation
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fa:`gear,text-info fa-4x,style=fa`

   +++

   .. link-button:: api
      :type: ref
      :text: API reference
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fa:`code,text-info fa-4x,style=fa`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-cli
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fa:`bug,text-info fa-4x,style=fa`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-cli/-/issues
      :type: url
      :text: Bug report
      :classes: btn-outline-primary btn-block stretched-link


Brief usage overview
--------------------

.. table::
   :widths: 50 50

   +--------------------------------------------------+------------------------------------------------+
   | Deterministic evaluation                         | Probabilistic evaluation                       |
   |                                                  |                                                |
   | .. code-block:: console                          | .. code-block:: console                        |
   |                                                  |                                                |
   |    $ ./evalhyd evald "obs.csv" "prd.csv" "NSE"   |    $ ./evalhyd evalp "./obs/" "./prd/" "BS" \  |
   |    {{{ 0.862981}}}                               |    > --q_thr "./thr/" --events "high"          |
   |                                                  |    {{{{{ 0.222222,  0.133333}}}}}              |
   |                                                  |                                                |
   +--------------------------------------------------+------------------------------------------------+

.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   cli
   changelog
   licence
