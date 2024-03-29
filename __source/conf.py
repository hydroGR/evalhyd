# Configuration file for the Sphinx documentation builder.
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

import os
import sys

sys.path.insert(0, os.path.abspath('..'))

# -- Project information -----------------------------------------------------

from datetime import datetime

project = os.getenv('EVALHYD_PROJECT')
author = 'INRAE'
copyright = (
    f'2022-{datetime.now().year}, {author}'
    if datetime.now().year != 2022
    else f'2022, {author}'
)

var_release = f'VERSION_RELEASE_{project.upper().replace("-", "_")}'
if os.getenv(var_release):
    version = f"v{os.getenv(var_release)}"
    release = f"v{os.getenv(var_release)}"
else:
    version = 'latest'
    release = 'latest'

import pydata_sphinx_theme

# -- General configuration ---------------------------------------------------

language = "en"

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    'sphinx.ext.doctest',
    'sphinx.ext.githubpages',
    'sphinx.ext.autosectionlabel',
    'sphinx.ext.mathjax',
    'sphinx_panels',
    'sphinx_design',
    'breathe'
]

autosummary_generate = True
autoclass_content = 'both'

autodoc_member_order = 'bysource'
autosummary_member_order = 'bysource'
autodoc_typehints = 'none'
autodoc_default_flags = ['members', 'inherited-members', 'show-inheritance']

templates_path = ['../__templates']
source_suffix = '.rst'

master_doc = 'index'

exclude_patterns = ['Thumbs.db', '.DS_Store']

add_function_parentheses = False
add_module_names = False

show_authors = False

pygments_style = 'sphinx'
highlight_language = 'python'

todo_include_todos = False

# prolog is a string added to every RST file
# used here to define a Python role 'globally'
rst_prolog = """
.. role:: py(code)
   :language: python
   :class: highlight

.. role:: cpp(code)
   :language: c++
   :class: highlight

.. role:: rlang(code)
   :language: r
   :class: highlight
"""

# -- Options for HTML output -------------------------------------------------

html_short_title = project

html_theme = 'pydata_sphinx_theme'

html_static_path = ['../__static']

htmlhelp_basename = f'{project}-docs'

html_css_files = [
    'custom.css', 'my_pygments_light.css', 'my_pygments_dark.css',
    'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css'
]

html_sidebars = {}

html_baseurl = f'https://hydrogr.github.io/{project.replace("-", "/")}'
html_logo = f'../__images/{project}_logo+text.svg'
html_favicon = '../__images/evalhyd_favicon.ico'

html_permalinks_icon = '<span class="fa fa-link">'

html_theme_options = {
    # "logo": {
    #     "text": html_short_title,
    # },
    "icon_links": [
        {
            "name": "GitLab",
            "url": f"https://gitlab.irstea.fr/HYCAR-Hydro/evalhyd",
            "icon": "fa-brands fa-gitlab",
            "type": "fontawesome",
        }
    ],
    "show_prev_next": False,
    "show_toc_level": 1,
    # "show_nav_level": 2,
    "navbar_align": "content",
    "navbar_start": ["navbar-logo", "version-switcher"],
    # "navbar_center": ["navbar-nav", "navbar-version"],  # Just for testing
    "navbar_end": ["theme-switcher", "navbar-icon-links"],
    # "left_sidebar_end": ["custom-template.html", "sidebar-ethical-ads.html"],
    "footer_start": ["copyright", "sphinx-version", "last-updated"],
    "footer_end": ["corporate-logo"],
    "header_links_before_dropdown": 6,
    "switcher": {
        "json_url": f"{html_baseurl}/_static/switcher.json",
        "version_match": version
    },
}

html_last_updated_fmt = '%b %d, %Y'

html_use_smartypants = True

html_domain_indices = True
html_use_index = True
html_split_index = False

html_show_sourcelink = False

# -- Extension configuration -------------------------------------------------

# -- Options for breathe extension -------------------------------------------

breathe_projects = {
    'evalhyd': '../__build/xml/cpp'
}

# -- Options for intersphinx extension ---------------------------------------

intersphinx_mapping = {
    'sphinx': ('https://www.sphinx-doc.org/en/master/',  None),
    'python': ('https://docs.python.org/3', None),
    'numpy': ('https://docs.scipy.org/doc/numpy', None),
    'xtensor': ("https://xtensor.readthedocs.io/en/stable", None),
    'xtensor-python': ("https://xtensor-python.readthedocs.io/en/stable", None),
    'xtensor-r': ("https://xtensor-r.readthedocs.io/en/stable", None)
}

intersphinx_cache_limit = 5

# -- Options for mathjax extension ---------------------------------------

# to get left alignment of equations
mathjax3_config = {
    "chtml": {
        "displayAlign": "left"
    },
    "options": {
        "ignoreHtmlClass": "tex2jax_ignore",
        "processHtmlClass": "tex2jax_process"
    }
}

# -- Options for sphinx-panels extension -------------------------------------

panels_add_bootstrap_css = False
