.. default-role:: obj

.. _cli_installation:

Installation
============

.. code-block:: console

   $ git clone --recursive "https://gitlab.irstea.fr/hycar-hydro/evalhyd/evalhyd-cli.git"
   $ cmake -Sevalhyd-cli -Bbuild
   $ cmake --build build

.. admonition:: Requirements

   A C++ compiler and the following libraries are required to install `evalhyd-cli`:

   .. code-block:: text

      cmake
