.. currentmodule:: evalhyd
.. default-role:: obj

.. _python_installation:

Installation
============

From conda-forge
----------------

The recommended way to install `evalhyd-python` is to use a `conda`-like
package manager and the conda-forge channel:

.. code-block:: console
   :caption: Install using `mamba` and the conda-forge channel

   $ mamba install -c conda-forge evalhyd-python


From source
-----------

To build `evalhyd-python` from source, simply use `pip` and point to
our GitLab repository:

.. code-block:: console

   $ pip install "git+https://gitlab.irstea.fr/hycar-hydro/evalhyd/evalhyd-python.git"

.. admonition:: Requirements

   The following packages are required to install `evalhyd-python`:

   .. code-block:: text

      numpy
      pybind11
