# How to update the static documentation

The documentation of the `evalhyd` stack is a collection of static HTML 
pages. It relies on Sphinx (and the help of `breathe`+`Doxygen` for the 
C++ source code) to build the HTML pages from RST source files and 
RST-formatted docstrings. 

There is a makefile to control the documentation build. The makefile can 
be used locally to build the documentation, but there is also a GitHub 
Actions workflow that makes use of this same makefile to build the 
documentation remotely each time a new commit arises.

To get access to the relevant state of the docstrings (i.e. latest or 
version-specific) of the packages that make the stack up, the related 
repositories (for the bindings) are cloned as part of the build process.

The documentation is designed as a collection of four independent 
documentations containing the package-/language-specific parts (one for 
each of the packages that make the stack up), and a fifth part 
containing the shared aspects between the four packages. This is why the 
documentation is, in effect, build five times (this is a trick notably 
to get a different header logo and version number for each part).

The documentation features a version switcher. Each release gets its own 
entry in the switcher, and an additional entry corresponds to the latest 
state of the documentation sources in the repository (i.e. latest 
commit in the *main* branch). 

## Build documentation locally

To build the documentation locally, clone this repository, install the 
dependencies, and call the makefile:

```console
git clone https://github.com/hydroGR/evalhyd.git
cd evalhyd
mamba env create --name evalhyd-docs-env --file requirements-docs.yml --yes
mamba activate evalhyd-docs-env
make build_docs
```

## Build documentation remotely

To build the documentation remotely, make a new commit to this 
repository, this will trigger the GitHub Actions workflow.

The workflow can also be triggered manually using 
[GitHub CLI](https://cli.github.com/). To do so, install `gh` and use 
it to trigger the relevant workflow:

```console
mamba install gh
gh workflow run static.yml
```

## Specific case for a build in the event of a new version release

Since the software stack is structured as a core C++ library and four 
satellite bindings depending on this C++ core, the version numbers 
of the satellite bindings are kept in sync with the version of the core: 
the version number of the core follows the 
[semantic versioning](https://semver.org/) scheme, i.e. 
``MAJOR.MINOR.PATCH`` (e.g. ``0.1.0``), and the versions of the 
satellite bindings start with the version number of the core version 
they depend on, and an additional trailing item for binding-specific bug 
fixes, i.e. ``MAJOR.MINOR.PATCH.BINDING-SPECIFIC-PATCH``. 

> [!WARNING]  
> As it is, the automated documentation build process is not capable of 
> handling a release for a binding-specific version, so this needs to 
> be handled manually.

The algorithm contained in the makefile features conditional statements 
to activate the specific actions needed in case of a version release:
in particular, to display the version release number and not "latest" in 
the version switcher, and to archive the built documentation for the 
given version released in a subdirectory. This activation relies on the 
setting of an environment variable called *VERSION_RELEASE_EVALHYD* that 
takes as value the version number corresponding to the C++ core being 
released.

In addition, for the version switcher to feature an entry for the newly 
released versions, the corresponding JSON files must be amended to add 
an item for the new version, for example:

https://github.com/hydroGR/evalhyd/blob/fb8734598fb09076d50fabbf5f4cbd162279359a/__config/shared/switcher.json#L22-L26

> [!NOTE]  
> Since the makefile does not include instructions to update the 
> *switcher.json* files, this must be done manually, both for local 
> and remote builds.

### Locally

Set the environment variable before calling the build process:

```console
export VERSION_RELEASE_EVALHYD=0.1.0
make build_docs
```

### Remotely

The GitHub Actions workflow is able to set the environment variable 
before calling the build process. To do so, the *release* input property 
must be used, as configured in the workflow YAML file:

https://github.com/hydroGR/evalhyd/blob/fb8734598fb09076d50fabbf5f4cbd162279359a/.github/workflows/static.yml#L9-L15

Using GitHub CLI, this can be passed as a raw field:

```console
gh workflow run static.yml -f release='0.1.0'
```

> [!WARNING]  
> This remote build process for a new release does not seem to work 
> properly for now, as the input property does not seem to be passed
> as expected.
