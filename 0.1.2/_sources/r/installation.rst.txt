.. default-role:: obj

.. _r_installation:

Installation
============

From R-universe
---------------

The recommended way to install `evalhyd-r` is to use the R-universe platform:

.. code-block:: RConsole
   :caption: Install `evalhyd-r` from R-universe

   > install.packages(
   +     'evalhyd',
   +     repos = c('https://hydrogr.r-universe.dev',
   +               'https://cloud.r-project.org')
   + )


From conda-forge
----------------

`evalhyd-r` is also available on conda-forge, so that it
can be installed with any `conda`-like package manager:

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

   .. warning:: This method will not work for Windows users.


From source
-----------

To build `evalhyd-r` from source, use the following shell commands:

.. code-block:: console
   :caption: Clone GitLab repository

   $ git clone --recursive "https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r.git"

.. code-block:: console
   :caption: Install from cloned source

   $ R CMD INSTALL evalhyd-r

.. admonition:: Requirements

   The following libraries are required to install `evalhyd-r`:

   .. code-block:: text

      Rtools
      Rcpp
      git
