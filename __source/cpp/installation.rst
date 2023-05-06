.. default-role:: obj

.. _cpp_installation:

Installation
============

From conda-forge
----------------

The recommended way to install `evalhyd-cpp` is to use a `conda`-like
package manager and the conda-forge channel:

.. code-block:: console
   :caption: Install using `mamba` and the conda-forge channel

   $ mamba install -c conda-forge libevalhyd


From source
-----------

To build `evalhyd` core C++ library from source, `cmake` can be used.

.. tip::

   It is recommended that the dependencies are installed using `mamba`:

   .. code-block:: console
      :caption: Install the dependencies in a new environment

      $ mamba create -n evalhyd-env -f environment.yml

   .. code-block:: console
      :caption: Activate the environment

      $ mamba activate evalhyd-env

Then, the steps below can be followed:

.. code-block:: console
   :caption: Configure the CMake project

   $ cmake -B build/ -D CMAKE_BUILD_TYPE=Release -D CMAKE_PREFIX_PATH="${CONDA_PREFIX}"

.. code-block:: console
   :caption: Build the CMake project

   $ cmake --build build/ --parallel

.. code-block:: console
   :caption: Test the library

   $ ./build/tests/evalhyd_tests

.. code-block:: console
   :caption: Install the library

   $ cmake --install build/ --prefix <path>
