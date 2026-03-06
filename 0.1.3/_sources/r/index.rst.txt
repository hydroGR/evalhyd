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

   .. button-ref:: installation
      :ref-type: doc
      :color: primary
      :click-parent:
      :outline:

      Installation

   ---

   :fas:`gear;sd-text-info fa-4x`

   +++

   .. button-ref:: api
      :ref-type: doc
      :color: primary
      :click-parent:
      :outline:

      API reference

   ---

   :fas:`code;sd-text-info fa-4x`

   +++

   .. button-link:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r
      :color: primary
      :click-parent:
      :outline:

      Source code :fas:`arrow-up-right-from-square`

   ---

   :fas:`bug;sd-text-info fa-4x`

   +++

   .. button-link:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r/-/issues
      :color: primary
      :click-parent:
      :outline:

      Bug report :fas:`arrow-up-right-from-square`


Brief usage overview
--------------------

.. grid::
   :gutter: 3
   :margin: 0
   :padding: 0

   .. grid-item::
      :columns: 12 12 6 6

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
      :columns: 12 12 6 6

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

   .. grid-item::
      :columns: 12 12 12 12

      .. button-link:: https://mybinder.org/v2/git/https%3A%2F%2Fgitlab.irstea.fr%2FHYCAR-Hydro%2Fevalhyd%2Fevalhyd-notebooks%2Fr/HEAD?filepath=evalhyd-r.ipynb
         :color: primary
         :outline:
         :expand:

         Try it yourself in a notebook :fas:`arrow-up-right-from-square`


.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   api
   tutorials/index
   changelog
   licence
