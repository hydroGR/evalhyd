# Minimal makefile for Sphinx documentation
#
.ONESHELL:

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = ./__source
BUILDDIR      = ./__build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

clean:
	rm -rf $(BUILDDIR)/*

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

gitlab_clean:
	find . \( -type d -maxdepth 1 ! -name "." \) \
	-and \( -type d -maxdepth 1 ! -name ".*" \) \
	-and \( -type d -maxdepth 1 ! -name "__*" \) \
	-exec rm -rf {} +
	rm -f *.html *.js *.inv .buildinfo

gitlab_html:
	$(MAKE) gitlab_clean
	$(MAKE) local_html
	cp -a $(BUILDDIR)/html/. .
ifdef VERSION_RELEASE
	cp -a $(BUILDDIR)/html/. ./$(VERSION_RELEASE)
endif

local_clean:
	rm -rf $(SOURCEDIR)/cpp/functions/xml/*
	rm -rf $(BUILDDIR)/*

local_html:
	$(MAKE) local_clean
# generate doxygen XML for C++ API docs
	mkdir -p $(BUILDDIR)/xml/cpp
	(cd $(SOURCEDIR)/cpp && doxygen Doxyfile)
# build docs html with sphinx
	$(MAKE) html
