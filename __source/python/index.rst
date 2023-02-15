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

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-python
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fa:`bug,text-info fa-4x,style=fa`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-python/-/issues
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
   | .. code-block:: python                           | .. code-block:: python                         |
   |                                                  |                                                |
   |    >>> import numpy                              |    >>> import numpy                            |
   |    ... obs = numpy.array(                        |    ... obs = numpy.array(                      |
   |    ...     [[4.7, 4.3, 5.5, 2.7]]                |    ...     [[4.7, 4.3, 5.5, 2.7, 4.1]]         |
   |    ... )                                         |    ... )                                       |
   |    ... prd = numpy.array(                        |    ... prd = numpy.array(                      |
   |    ...     [[5.3, 4.2, 5.7, 2.3]]                |    ...     [[[[5.3, 4.2, 5.7, 2.3, 3.1],       |
   |    ... )                                         |    ...        [4.3, 4.2, 4.7, 4.3, 3.3],       |
   |    >>> import evalhyd                            |    ...        [5.3, 5.2, 5.7, 2.3, 3.9]]]]     |
   |    ... evalhyd.evald(obs, prd, ["NSE"])          |    ... )                                       |
   |    [array([[[0.86298077]]])]                     |    ... thr = numpy.array([[4., 5.]])           |
   |                                                  |    >>> import evalhyd                          |
   |                                                  |    ... evalhyd.evalp(obs, prd, ["BS"],         |
   |                                                  |    ...               thr, events="high")       |
   |                                                  |    [array([[[[[0.22222222, 0.13333333]]]]])]   |
   |                                                  |                                                |
   +--------------------------------------------------+------------------------------------------------+

.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   api
   changelog
   licence
