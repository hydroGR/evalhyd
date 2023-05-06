.. default-role:: obj

.. _r_installation:

Installation
============

From conda-forge
----------------

The recommended way to install `evalhyd-r` is to use a `conda`-like
package manager and the conda-forge channel:

.. code-block:: console
   :caption: Install using `mamba` and the conda-forge channel

   $ mamba install -c conda-forge r-evalhyd

.. tip::

   RStudio users can install `evalhyd-r`, R, and RStudio in the same
   environment, and then use this RStudio directly:

   .. code-block:: console
      :caption: Create an environment and install the required libraries

      $ mamba create -n my-r-env -c conda-forge r rstudio r-evalhyd

   .. code-block:: console
      :caption: Activate the environment

      $ mamba activate my-r-env

   .. code-block:: console
      :caption: Fire up RStudio

      $ rstudio


From source
-----------

To install `evalhyd` R bindings from source, simply use `remotes` and
point to our GitLab repository:

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
