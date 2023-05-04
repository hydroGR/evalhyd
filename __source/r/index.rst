.. currentmodule:: evalhyd
.. default-role:: obj

R
=

`evalhyd-r` is an R package to evaluate deterministic and probabilistic
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

   .. link-button:: api
      :type: ref
      :text: API reference
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`code;sd-text-info fa-4x`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`bug;sd-text-info fa-4x`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r/-/issues
      :type: url
      :text: Bug report
      :classes: btn-outline-primary btn-block stretched-link


Brief usage overview
--------------------

.. grid::
   :gutter: 0
   :margin: 0
   :padding: 0

   .. grid-item::
      :margin: 0
      :padding: 0 0 0 2
      :columns: 6

      .. code-block:: RConsole
         :caption: Deterministic evaluation

         > obs <- rbind(c(4.7, 4.3, 5.5, 2.7))
         > prd <- rbind(c(5.3, 4.2, 5.7, 2.3))
         > library(evalhyd)
         > evalhyd::evald(obs, prd, c("NSE"))
         [[1]]
         , , 1
         [,1]
         [1,] 0.8629808

   .. grid-item::
      :margin: 0
      :padding: 0 0 2 0
      :columns: 6

      .. code-block:: RConsole
         :caption: Probabilistic evaluation

         > obs <- rbind(c(4.7, 4.3, 5.5, 2.7, 4.1))
         > prd <- array(
         +     rbind(c(5.3, 4.2, 5.7, 2.3, 3.1),
         +           c(4.3, 4.2, 4.7, 4.3, 3.3),
         +           c(5.3, 5.2, 5.7, 2.3, 3.9)),
         +     dim = c(1, 1, 3, 5)
         + )
         > thr <- rbind(c(4., 5.))
         > library(evalhyd)
         > evalhyd::evalp(obs, prd, c("BS"),
         +                thr, events="high")
         [[1]]
         , , 1, 1, 1

                   [,1]
         [1,] 0.2222222

         , , 1, 1, 2

                   [,1]
         [1,] 0.1333333


.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   api
   changelog
   licence
