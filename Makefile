.ONESHELL:

BLD_DIR = ./__build

clone_repos:
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd.git --branch dev)
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-cli.git --branch dev)
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-python.git --branch dev)
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r.git --branch dev)

local_clean:
	rm -rf ./__code/*
	rm -rf ${BLD_DIR}/html/*

local_html:
	$(MAKE) local_clean
	$(MAKE) clone_repos
	mkdir -p ${BLD_DIR}/html
# -----------------------------------------------------------------------------
# make docs and copy SHARED part over
# -----------------------------------------------------------------------------
	mkdir -p ${BLD_DIR}/shared/__source
	cp -R ./__source/* ${BLD_DIR}/shared/__source
# copy configuration files
	-cp ./__config/* ${BLD_DIR}/shared/__source
	cp -R ./__config/shared/* ${BLD_DIR}/shared/__source
# build sphinx docs
	(cd ${BLD_DIR}/shared/__source && $(MAKE) local_html)
# copy build html over
	cp -R ${BLD_DIR}/shared/__build/html/* ${BLD_DIR}/html
# remove html related to "sub-projects"
	rm -rf ${BLD_DIR}/html/cli
	rm -rf ${BLD_DIR}/html/cpp
	rm -rf ${BLD_DIR}/html/python
	rm -rf ${BLD_DIR}/html/r
# copy files required for header (navbar-start)
	cp -R ./__config/shared/switcher.json ${BLD_DIR}/html/_static/
# clean up
	rm -rf ${BLD_DIR}/shared
# -----------------------------------------------------------------------------
# make docs and copy CLI part over
# -----------------------------------------------------------------------------
	mkdir -p ${BLD_DIR}/cli/__source
	cp -R ./__source/* ${BLD_DIR}/cli/__source
# copy configuration files
	-cp ./__config/* ${BLD_DIR}/cli/__source
	cp -R ./__config/cli/* ${BLD_DIR}/cli/__source
# build sphinx docs
	(cd ${BLD_DIR}/cli/__source && $(MAKE) local_html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/cli/_static
	cp -R ${BLD_DIR}/cli/__build/html/cli/* ${BLD_DIR}/html/cli
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/cli/__build/html/_static/evalhyd-cli_logo+text.svg ${BLD_DIR}/html/_static/
	cp -R ./__config/cli/switcher.json ${BLD_DIR}/html/cli/_static/
# clean up
	rm -rf ${BLD_DIR}/cli
# -----------------------------------------------------------------------------
# make docs and copy CPP part over
# -----------------------------------------------------------------------------
	mkdir -p ${BLD_DIR}/cpp/__source
	cp -R ./__source/* ${BLD_DIR}/cpp/__source
# copy configuration files
	-cp ./__config/* ${BLD_DIR}/cpp/__source
	cp -R ./__config/cpp/* ${BLD_DIR}/cpp/__source
# build sphinx docs
	(cd ${BLD_DIR}/cpp/__source && $(MAKE) local_html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/cpp/_static
	cp -R ${BLD_DIR}/cpp/__build/html/cpp/* ${BLD_DIR}/html/cpp
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/cpp/__build/html/_static/evalhyd-cpp_logo+text.svg ${BLD_DIR}/html/_static/
	cp -R ./__config/cpp/switcher.json ${BLD_DIR}/html/cpp/_static/
# clean up
	rm -rf ${BLD_DIR}/cpp
# -----------------------------------------------------------------------------
# make docs and copy PYTHON part over
# -----------------------------------------------------------------------------
	mkdir -p ${BLD_DIR}/python/__source
	cp -R ./__source/* ${BLD_DIR}/python/__source
# copy configuration files
	-cp ./__config/* ${BLD_DIR}/python/__source
	cp -R ./__config/python/* ${BLD_DIR}/python/__source
# build sphinx docs
	(cd ${BLD_DIR}/python/__source && $(MAKE) local_html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/python/_static
	cp -R ${BLD_DIR}/python/__build/html/python/* ${BLD_DIR}/html/python
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/python/__build/html/_static/evalhyd-python_logo+text.svg ${BLD_DIR}/html/_static/
	cp -R ./__config/python/switcher.json ${BLD_DIR}/html/python/_static/
# clean up
	rm -rf ${BLD_DIR}/python
# -----------------------------------------------------------------------------
# make docs and copy R part over
# -----------------------------------------------------------------------------
	mkdir -p ${BLD_DIR}/r/__source
	cp -R ./__source/* ${BLD_DIR}/r/__source
# copy configuration files
	-cp ./__config/* ${BLD_DIR}/r/__source
	cp -R ./__config/r/* ${BLD_DIR}/r/__source
# build sphinx docs
	(cd ${BLD_DIR}/r/__source && $(MAKE) local_html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/r/_static
	cp -R ${BLD_DIR}/r/__build/html/r/* ${BLD_DIR}/html/r
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/r/__build/html/_static/evalhyd-r_logo+text.svg ${BLD_DIR}/html/_static/
	cp -R ./__config/r/switcher.json ${BLD_DIR}/html/r/_static/
# clean up
	rm -rf ${BLD_DIR}/r
	