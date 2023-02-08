.ONESHELL:

BLD_DIR = ./__build
SRC_DIR = ./__source
CFG_DIR = ./__config

clean_repos:
	rm -rf ./__code/evalhyd
	rm -rf ./__code/evalhyd-cli
	rm -rf ./__code/evalhyd-python
	rm -rf ./__code/evalhyd-r

clone_repos:
	$(MAKE) clean_repos
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd.git --branch dev)
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-cli.git --branch dev)
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-python.git --branch dev)
	(cd ./__code && git clone https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd/evalhyd-r.git --branch dev)

clean_xml:
	rm -rf ${BLD_DIR}/xml

build_xml:
	$(MAKE) clean_xml
	# generate doxygen XML for C++ API docs
	mkdir -p ${BLD_DIR}/xml/cpp
	(cd ${SRC_DIR}/cpp && doxygen Doxyfile)

clean_html:
	rm -rf ${BLD_DIR}/html/*

build_html:
	$(MAKE) clean_html
	mkdir -p ${BLD_DIR}/html
# -----------------------------------------------------------------------------
# make docs and copy SHARED part over
# -----------------------------------------------------------------------------
	$(eval SPHINX_DIR = shared)
# create subdirectory for project build
	mkdir -p ${BLD_DIR}/${SPHINX_DIR}
# build sphinx docs
	(export EVALHYD_PROJECT=evalhyd && sphinx-build -b html ${SRC_DIR} ${BLD_DIR}/${SPHINX_DIR}/html)
# copy build html over
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/* ${BLD_DIR}/html
# remove html related to "sub-projects"
	rm -rf ${BLD_DIR}/html/cli
	rm -rf ${BLD_DIR}/html/cpp
	rm -rf ${BLD_DIR}/html/python
	rm -rf ${BLD_DIR}/html/r
# copy files required for header (navbar-start)
	cp -R ${CFG_DIR}/${SPHINX_DIR}/switcher.json ${BLD_DIR}/html/_static/
# clean up
	rm -rf ${BLD_DIR}/${SPHINX_DIR}
# -----------------------------------------------------------------------------
# make docs and copy CLI part over
# -----------------------------------------------------------------------------
	$(eval SPHINX_DIR = cli)
	$(eval EVALHYD_PROJECT = evalhyd-cli)
# create subdirectory for project build
	mkdir -p ${BLD_DIR}/${SPHINX_DIR}
# build sphinx docs
	(export EVALHYD_PROJECT=${EVALHYD_PROJECT} && sphinx-build -b html ${SRC_DIR} ${BLD_DIR}/${SPHINX_DIR}/html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/${SPHINX_DIR}/* ${BLD_DIR}/html/${SPHINX_DIR}
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/_static/${EVALHYD_PROJECT}_logo+text.svg ${BLD_DIR}/html/_static/
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}/_static
	cp -R ${CFG_DIR}/${SPHINX_DIR}/switcher.json ${BLD_DIR}/html/${SPHINX_DIR}/_static/
# clean up
	rm -rf ${BLD_DIR}/${SPHINX_DIR}
# -----------------------------------------------------------------------------
# make docs and copy CPP part over
# -----------------------------------------------------------------------------
	$(eval SPHINX_DIR = cpp)
	$(eval EVALHYD_PROJECT = evalhyd-cpp)
# create subdirectory for project build
	mkdir -p ${BLD_DIR}/${SPHINX_DIR}
# build sphinx docs
	(export EVALHYD_PROJECT=${EVALHYD_PROJECT} && sphinx-build -b html ${SRC_DIR} ${BLD_DIR}/${SPHINX_DIR}/html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/${SPHINX_DIR}/* ${BLD_DIR}/html/${SPHINX_DIR}
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/_static/${EVALHYD_PROJECT}_logo+text.svg ${BLD_DIR}/html/_static/
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}/_static
	cp -R ${CFG_DIR}/${SPHINX_DIR}/switcher.json ${BLD_DIR}/html/${SPHINX_DIR}/_static/
# clean up
	rm -rf ${BLD_DIR}/${SPHINX_DIR}
# -----------------------------------------------------------------------------
# make docs and copy PYTHON part over
# -----------------------------------------------------------------------------
	$(eval SPHINX_DIR = python)
	$(eval EVALHYD_PROJECT = evalhyd-python)
# create subdirectory for project build
	mkdir -p ${BLD_DIR}/${SPHINX_DIR}
# build sphinx docs
	(export EVALHYD_PROJECT=${EVALHYD_PROJECT} && sphinx-build -b html ${SRC_DIR} ${BLD_DIR}/${SPHINX_DIR}/html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/${SPHINX_DIR}/* ${BLD_DIR}/html/${SPHINX_DIR}
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/_static/${EVALHYD_PROJECT}_logo+text.svg ${BLD_DIR}/html/_static/
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}/_static
	cp -R ${CFG_DIR}/${SPHINX_DIR}/switcher.json ${BLD_DIR}/html/${SPHINX_DIR}/_static/
# clean up
	rm -rf ${BLD_DIR}/${SPHINX_DIR}
# -----------------------------------------------------------------------------
# make docs and copy R part over
# -----------------------------------------------------------------------------
	$(eval SPHINX_DIR = r)
	$(eval EVALHYD_PROJECT = evalhyd-r)
# create subdirectory for project build
	mkdir -p ${BLD_DIR}/${SPHINX_DIR}
# build sphinx docs
	(export EVALHYD_PROJECT=${EVALHYD_PROJECT} && sphinx-build -b html ${SRC_DIR} ${BLD_DIR}/${SPHINX_DIR}/html)
# copy build html over
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/${SPHINX_DIR}/* ${BLD_DIR}/html/${SPHINX_DIR}
# copy files required for header (navbar-start)
	cp -R ${BLD_DIR}/${SPHINX_DIR}/html/_static/${EVALHYD_PROJECT}_logo+text.svg ${BLD_DIR}/html/_static/
	mkdir -p ${BLD_DIR}/html/${SPHINX_DIR}/_static
	cp -R ${CFG_DIR}/${SPHINX_DIR}/switcher.json ${BLD_DIR}/html/${SPHINX_DIR}/_static/
# clean up
	rm -rf ${BLD_DIR}/${SPHINX_DIR}

build_docs:
	$(MAKE) clone_repos
	$(MAKE) build_xml
	$(MAKE) build_html