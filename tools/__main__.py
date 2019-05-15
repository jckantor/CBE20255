import os
import re
import nbformat
from nbformat.v4.nbbase import new_markdown_cell
import itertools

###  EDIT THESE STRINGS

# header for README.md
README_HEADER = """
# Introduction to Chemical Engineering Analysis

_Introduction to Chemical Engineering Analysis_ demonstrates the use of mass and energy balances for the analysis of 
chemical processes and products. The notebooks in the repository show how to prepare and analyze conceptual flowsheets 
for chemical processes, perform generation-consumption analysis, and perform basic engineering calculations for 
stoichiometry, reactor performance, separations, and energy analysis.

The notebooks demonstrate basic chemical engineering calculations in Python. The `open in colab` opens notebooks 
directly in Google Colaboratory where they can be run, edited, shared, and saved to your Google Drive. All you need is 
a browser, either Google Chrome, Mozilla Firefox, or Apple Safari. Alternatively, the `render in nbviewer` link allows 
notebooks to be downloaded and executed in a Python development distribution installed on your computer. These notebooks
were developed and tested using the [Anaconda](https://www.anaconda.com/download/) distribution.

Most notebooks are 3-5 pages in length covering a single topic. Notebooks marked as examples are shorter, and present 
one or more problem statements with solutions.

## Contents
---
"""

README_FOOTER = """
<p>
**Note on the use of Python.** The Python used in these notebooks is deliberately limited to a core set of language 
features.  These notebooks use scalar variables and lists of scalar variables to represent data. Also used are 
arithmetic, math, print, and plotting functions from the `matplotlib.pyplot` library. Functions created with `def` 
and `lambda` are used when root-finding calculations are required. List comprehesions are used on occasion when the 
result is more readable code. The `Sympy` library for symbolic math is used extensively for writing mass balances. Other
 libraries included `numpy`, `math`, and the root-finding functions from `scipy.optimize`. Notebooks with more advanced 
 use of Python, such as dictionaries, are marked with an asterisk.

**License Requirements.** The materials in this repository are available at 
[http://github.com/jckantor/CBE20255](http://github.com/jckantor/CBE20255) for noncommercial use under terms of the 
[Creative Commons Attribution Noncommericial ShareAlike License](http://creativecommons.org/licenses/by-nc-sa/4.0/). 
You are invited to fork this repository, and to use, adapt, remix these material for non-commericial purposes. The 
license terms require you to give attribution and share your work under the same terms. Pull requests for corrections 
and additions to these materials are most welcome.

**Acknowledgements.** Several notebooks embed videos from [LearnChemE](http://www.learncheme.com/) hosted at the 
University of Colorado at Boulder and sponsored by the National Science Foundation (NSF) and Shell Corporation. 
Permission to use these videos is gratefully acknowledged.</p>
"""

# header for the index file and notebook
INDEX_HEADER = """
# [Introduction to Chemical Engineering Analysis](http://jckantor.github.io/CBE20255/)

## Table of Contents
"""

# header to be inserted at the top of each notebook
COURSE_INFO_HEADER = """
*This notebook contains course material from [CBE 20255 Introduction to Chemical Engineering Analysis](http://jckantor.github.io/CBE20255/) 
by Jeffrey Kantor (jeff at nd.edu); the content is available [on GitHub](https://github.com/jckantor/CBE20255).
The text is released under the [CC-BY-NC-ND-4.0 license](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode),
and code is released under the [MIT license](https://opensource.org/licenses/MIT).*
"""

# template for link to open notebooks in Google colaboratory
COLAB_LINK = """
<p><a href="https://colab.research.google.com/github/jckantor/CBE20255/blob/master/notebooks/{notebook_filename}">
<img align="left" src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open in Colab" title="Open in Google Colaboratory"></a>
"""

# location of remote notebook directory
NOTEBOOK_DIR_REMOTE = 'http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/'


### DO NOT EDIT BELOW THIS LINE

# location of the README.md file in the local repository
README_FILE = os.path.join(os.path.dirname(__file__), '..', 'README.md')

# find location of notebook directory in the local repository
NOTEBOOK_DIR = os.path.join(os.path.dirname(__file__), '..', 'notebooks')

# location of the index file in the local respository
INDEX_FILE = os.path.join(NOTEBOOK_DIR, 'index.md')

# location of the index notebook in the local repository
INDEX_NB = os.path.join(NOTEBOOK_DIR, 'index.ipynb')

# html comment used to tag the location of the course information in each notebook
COURSE_COMMENT = "<!--COURSE_INFORMATION-->"

# course information header to be inserted into each notebook
COURSE_INFO = COURSE_COMMENT + COURSE_INFO_HEADER

# regular expression that matches notebook filenames to be included in the TOC
REG = re.compile(r'(\d\d|[A-Z])\.(\d\d)-(.*)\.ipynb')
def iter_notebooks():
    """Return list of notebooks matched by regular expression"""
    return sorted(nb_file for nb_file in os.listdir(NOTEBOOK_DIR) if REG.match(nb_file))

def get_notebook_title(nb_file):
    """Returns notebook title header if it exists, else None"""
    nb = nbformat.read(os.path.join(NOTEBOOK_DIR, nb_file), as_version=4)
    for cell in nb.cells:
        if cell.cell_type == "markdown":
            if cell.source.startswith('#'):
                return cell.source[1:].splitlines()[0].strip()

def add_course_info():
    """Inserts COURSE_INFO_HEADER as the first cell in each notebook"""
    for nb_name in iter_notebooks():
        nb_file = os.path.join(NOTEBOOK_DIR, nb_name)
        nb = nbformat.read(nb_file, as_version=4)

        if nb.cells[0].source.startswith(COURSE_COMMENT):
            print('- amending comment for: {0}'.format(nb_name))
            nb.cells[0].source = COURSE_INFO
        else:
            print('- inserting comment for {0}'.format(nb_name))
            nb.cells.insert(0, new_markdown_cell(COURSE_INFO))
        print('        notebook title: {0}'.format(get_notebook_title(nb_name)))
        nbformat.write(nb, nb_file)

# functions to create Nav bar
def prev_this_next(it):
    a, b, c = itertools.tee(it, 3)
    next(c)
    return zip(itertools.chain([None], a), b, itertools.chain(c, [None]))

PREV_TEMPLATE = "< [{title}]({url}) "
CONTENTS = "| [Contents](index.ipynb) |"
NEXT_TEMPLATE = " [{title}]({url}) >"
NAV_COMMENT = "<!--NAVIGATION-->\n"

def iter_navbars():
    for prev_nb, nb, next_nb in prev_this_next(iter_notebooks()):
        navbar = NAV_COMMENT
        if prev_nb:
            navbar += PREV_TEMPLATE.format(title=get_notebook_title(prev_nb), url=prev_nb)
        navbar += CONTENTS
        if next_nb:
            navbar += NEXT_TEMPLATE.format(title=get_notebook_title(next_nb), url=next_nb)
        navbar += COLAB_LINK.format(notebook_filename=os.path.basename(nb))
        yield os.path.join(NOTEBOOK_DIR, nb), navbar

def write_navbars():
    for nb_name, navbar in iter_navbars():
        nb = nbformat.read(nb_name, as_version=4)
        nb_file = os.path.basename(nb_name)
        if nb.cells[1].source.startswith(NAV_COMMENT):
            print("- amending navbar for {0}".format(nb_file))
            nb.cells[1].source = navbar
        else:
            print("- inserting navbar for {0}".format(nb_file))
            nb.cells.insert(1, new_markdown_cell(source=navbar))
        if nb.cells[-1].source.startswith(NAV_COMMENT):
            nb.cells[-1].source = navbar
        else:
            nb.cells.append(new_markdown_cell(source=navbar))
        nbformat.write(nb, nb_name)

# functions to create Readme and Index files
def gen_contents(directory=None):
    for nb_file in iter_notebooks():
        nb_url = os.path.join(directory, nb_file) if directory else nb_file
        chapter, section, name = REG.match(nb_file).groups()
        if chapter.isdigit():
            chapter = int(chapter)
            if chapter == 0:
                fmt = "\n### [{2}]({3})" if section in '00' else "- [{2}]({3})"
            else:
                fmt = "\n### [Chapter {0}. {2}]({3})" if section in '00' else "- [{0}.{1} {2}]({3})"
        else:
            fmt = "\n### [Appendix {0}. {2}]({3})" if section in '00' else "- [{0}.{1} {2}]({3})"

        yield fmt.format(chapter, int(section), get_notebook_title(nb_file), nb_url)

def write_contents(FILE, HEADER, FOOTER=None, directory=None):
    with open(FILE, 'w') as f:
        f.write(HEADER)
        f.write('\n'.join(gen_contents(directory)))
        if FOOTER:
            f.write(FOOTER)

add_course_info()
write_navbars()
write_contents(INDEX_FILE, INDEX_HEADER, None, NOTEBOOK_DIR_REMOTE)
os.system(' '.join(['notedown', INDEX_FILE, '>', INDEX_NB]))
write_contents(README_FILE, README_HEADER, README_FOOTER, NOTEBOOK_DIR_REMOTE)
