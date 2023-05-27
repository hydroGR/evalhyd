.. currentmodule:: evalhyd
.. default-role:: obj

Python
======

`evalhyd-python` is a Python package to evaluate deterministic and probabilistic
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

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-python
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`bug;sd-text-info fa-4x`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-python/-/issues
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

      .. code-block:: python
         :caption: Deterministic evaluation

         >>> import numpy
         ... obs = numpy.array(
         ...     [[4.7, 4.3, 5.5, 2.7]]
         ... )
         ... prd = numpy.array(
         ...     [[5.3, 4.2, 5.7, 2.3]]
         ... )
         >>> import evalhyd
         ... evalhyd.evald(obs, prd, ["NSE"])
         [array([[[0.86298077]]])]

   .. grid-item::
      :columns: 12 12 6 6

      .. code-block:: python
         :caption: Probabilistic evaluation

         >>> import numpy
         ... obs = numpy.array(
         ...     [[4.7, 4.3, 5.5, 2.7, 4.1]]
         ... )
         ... prd = numpy.array(
         ...     [[[[5.3, 4.2, 5.7, 2.3, 3.1],
         ...        [4.3, 4.2, 4.7, 4.3, 3.3],
         ...        [5.3, 5.2, 5.7, 2.3, 3.9]]]]
         ... )
         ... thr = numpy.array([[4., 5.]])
         >>> import evalhyd
         ... evalhyd.evalp(obs, prd, ["BS"],
         ...               thr, events="high")
         [array([[[[[0.22222222, 0.13333333]]]]])]

   .. grid-item::
      :columns: 12 12 12 12

      .. button-link:: https://mybinder.org/v2/git/https%3A%2F%2Fgitlab.irstea.fr%2FHYCAR-Hydro%2Fevalhyd%2Fevalhyd-notebooks%2Fpython/HEAD?filepath=evalhyd-python.ipynb
         :color: primary
         :outline:
         :expand:

         Try it yourself in a notebook :fas:`arrow-up-right-from-square`

.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   api
   changelog
   licence
