.. currentmodule:: evalhyd
.. default-role:: obj

C++
===

`evalhyd-cpp` is a C++ library to evaluate deterministic and probabilistic
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

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd
      :type: url
      :text: Source code
      :classes: btn-outline-primary btn-block stretched-link

   ---

   :fas:`bug;sd-text-info fa-4x`

   +++

   .. link-button:: https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd/-/issues
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

      .. code-block:: cpp
         :caption: Deterministic evaluation

         #include <xtensor/xtensor.hpp>
         #include <xtensor/xio.hpp>
         #include <evalhyd/evald.hpp>

         xt::xtensor<double, 2> obs =
             {{4.7, 4.3, 5.5, 2.7}};
         xt::xtensor<double, 2> prd =
             {{5.3, 4.2, 5.7, 2.3}};

         auto res =
             evalhyd::evald(obs, prd, {"NSE"});

         std::cout << res << std::endl;
         // {{{ 0.862981}}}

   .. grid-item::
      :columns: 12 12 6 6

      .. code-block:: cpp
         :caption: Probabilistic evaluation

         #include <xtensor/xtensor.hpp>
         #include <xtensor/xio.hpp>
         #include <evalhyd/evalp.hpp>

         xt::xtensor<double, 2> obs =
             {{4.7, 4.3, 5.5, 2.7, 4.1}};
         xt::xtensor<double, 4> prd =
             {{{{5.3, 4.2, 5.7, 2.3, 3.1},
                {4.3, 4.2, 4.7, 4.3, 3.3},
                {5.3, 5.2, 5.7, 2.3, 3.9}}}};
         xt::xtensor<double, 2> thr = {{4., 5.}};

         auto res = evalhyd::evalp(obs, prd, {"BS"},
                                   thr, "high");

         std::cout << res << std::endl;
         // {{{{{ 0.222222,  0.133333}}}}}


.. toctree::
   :hidden:
   :maxdepth: 1

   installation
   api
   changelog
   licence
