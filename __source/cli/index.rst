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

   :fas:`rocket;sd-text-info fa-4x`

   +++

   .. link-button:: installation
      :type: ref
      :text: Installation
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`gear;sd-text-info fa-4x`

   +++

   .. link-button:: cli
      :type: ref
      :text: CLI reference
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`code;sd-text-info fa-4x`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-cli
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`bug;sd-text-info fa-4x`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-cli/-/issues
      :type: url
      :text: Bug report
      :classes: btn-outline-primary btn-block stretched-link


Brief usage overview
--------------------

.. grid::
   :gutter: 3
   :margin: 0
   :padding: 0

   .. grid-item::
      :columns: 12 12 6 6

      .. code-block:: console
         :caption: Deterministic evaluation

         $ evalhyd evald "obs.csv" "prd.csv" "NSE"
         {{{ 0.862981}}}

   .. grid-item::
      :columns: 12 12 6 6

      .. code-block:: console
         :caption: Probabilistic evaluation

         $ evalhyd evalp "./obs/" "./prd/" "BS" \
         > --q_thr "./thr/" --events "high"
         {{{{{ 0.222222,  0.133333}}}}}

   .. grid-item::
      :columns: 12 12 12 12

      .. button-link:: https://mybinder.org/v2/git/https%3A%2F%2Fgitlab.irstea.fr%2FHYCAR-Hydro%2Fevalhyd%2Fevalhyd-notebooks%2Fcli/HEAD?filepath=evalhyd-cli.ipynb
         :color: primary
         :outline:
         :expand:

         Try it yourself in a notebook


.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   cli
   changelog
   licence
