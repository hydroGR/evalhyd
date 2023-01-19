.. currentmodule:: evalhyd
.. default-role:: obj

A polyglot evaluator for streamflow predictions
===============================================

`evalhyd` is a software stack to evaluate deterministic and probabilistic
streamflow predictions. It features a :doc:`core library in C++ <cpp/index>`
where all the evaluation :doc:`metrics <metrics/index>` and the required
:doc:`functionalities <functionalities/index>` are implemented. It comes with
:doc:`Python bindings <python/index>` and :doc:`R bindings <r/index>`,
as well as a :doc:`Command Line Interface (CLI) <cli/index>`, all giving
access through very similar interfaces to the same metrics and functionalities
implemented in the C++ core.

.. panels::
   :card: + intro-card text-center
   :column: col-lg-6 col-md-6 col-sm-12 col-xs-12 p-2
   :footer: bg-white border-0

   ---

   .. image:: ../__images/evalhyd-cpp_logo.svg
      :height: 100px
      :align: center

   +++

   .. link-button:: cpp/index
      :type: ref
      :text: C++ core library
      :classes: btn-outline-primary btn-block stretched-link

   ---

   .. image:: ../__images/evalhyd-python_logo.svg
      :height: 100px
      :align: center

   +++

   .. link-button:: python/index
      :type: ref
      :text: Python bindings
      :classes: btn-outline-primary btn-block stretched-link

   ---

   .. image:: ../__images/evalhyd-r_logo.svg
      :height: 100px
      :align: center

   +++

   .. link-button:: r/index
      :type: ref
      :text: R bindings
      :classes: btn-outline-primary btn-block stretched-link

   ---

   .. image:: ../__images/evalhyd-cli_logo.svg
      :height: 100px
      :align: center

   +++

   .. link-button:: cli/index
      :type: ref
      :text: Command line interface
      :classes: btn-outline-primary btn-block stretched-link

.. toctree::
   :hidden:
   :maxdepth: 1

   metrics/index
   functionalities/index
   cpp/index
   python/index
   r/index
   cli/index
   licence
