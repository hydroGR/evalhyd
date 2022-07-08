.. default-role:: obj

.. _r_installation:

Installation
============

.. code-block:: RConsole

   > remotes::install_gitlab("hycar-hydro/evalhyd/evalhyd-r",
   +                         host = "gitlab.irstea.fr",
   +                         dependencies = TRUE,
   +                         force = TRUE)

.. admonition:: Requirements

   The following libraries are required to install `evalhyd-r`:

   .. code-block:: text

      Rtools
      Rcpp
      remotes
