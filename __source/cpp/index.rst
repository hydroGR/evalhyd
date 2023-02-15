.. currentmodule:: evalhyd
.. default-role:: obj

C++
===

`evalhyd` is a C++ library to evaluate deterministic and probabilistic
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

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fa:`bug,text-info fa-4x,style=fa`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd/-/issues
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
   | .. code-block:: cpp                              | .. code-block:: cpp                            |
   |                                                  |                                                |
   |    #include <xtensor/xtensor.hpp>                |    #include <xtensor/xtensor.hpp>              |
   |    #include <xtensor/xio.hpp>                    |    #include <xtensor/xio.hpp>                  |
   |    #include <evalhyd/evald.hpp>                  |    #include <evalhyd/evalp.hpp>                |
   |                                                  |                                                |
   |    xt::xtensor<double, 2> obs =                  |    xt::xtensor<double, 2> obs =                |
   |        {{4.7, 4.3, 5.5, 2.7}};                   |        {{4.7, 4.3, 5.5, 2.7, 4.1}};            |
   |    xt::xtensor<double, 2> prd =                  |    xt::xtensor<double, 4> prd =                |
   |        {{5.3, 4.2, 5.7, 2.3}};                   |        {{{{5.3, 4.2, 5.7, 2.3, 3.1},           |
   |                                                  |           {4.3, 4.2, 4.7, 4.3, 3.3},           |
   |    auto res =                                    |           {5.3, 5.2, 5.7, 2.3, 3.9}}}};        |
   |        evalhyd::evald(obs, prd, {"NSE"});        |    xt::xtensor<double, 2> thr = {{4., 5.}};    |
   |                                                  |                                                |
   |    std::cout << res << std::endl;                |    auto res = evalhyd::evalp(obs, prd, {"BS"}  |
   |    // {{{ 0.862981}}}                            |                              thr, "high");     |
   |                                                  |                                                |
   |                                                  |    std::cout << res << std::endl;              |
   |                                                  |    // {{{{{ 0.222222,  0.133333}}}}}           |
   |                                                  |                                                |
   +--------------------------------------------------+------------------------------------------------+

.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   api
   changelog
   licence
