import os
import re
import nbformat
from nbformat.v4.nbbase import new_markdown_cell
import itertools

###  EDIT THESE STRINGS

# header for README.md
README_HEADER = """
# Introduction to Chemical Engineering Analysis

*Introduction to Chemical Engineering Analysis* demonstrates the use of mass and energy balances for the analysis of 
chemical processes and products. The notebooks in the repository show how to prepare and analyze conceptual flowsheets 
for chemical processes, perform generation-consumption analysis, and perform basic engineering calculations for 
stoichiometry, reactor performance, separations, and energy analysis.

The notebooks demonstrate these basic chemical engineering calculations using Python. The notebooks can be open
directly in Google Colaboratory where they can be run, edited, shared, and saved to your Google Drive. Alternatively,
the notebooks can be downloaded and executed on your computer. These notebooks
were developed and tested using the [Anaconda](https://www.anaconda.com/download/) distribution.

## Notebooks

### [Table of Contents](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/index.ipynb?flush=True)
---
"""

README_FOOTER = """

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

"""

# header to be inserted at the top of each notebook
COURSE_INFO_HEADER = """

*This notebook contains course material from 
[CBE 20255 Introduction to Chemical Engineering Analysis](http://jckantor.github.io/CBE20255/) 
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
NBVIEWER_BASE_URL = 'http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/'

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

# functions to create Nav bar
PREV_TEMPLATE = "< [{title}]({url}) "
CONTENTS = "| [Contents](index.ipynb) |"
NEXT_TEMPLATE = " [{title}]({url}) >"
NAV_COMMENT = "<!--NAVIGATION-->\n"

FMT = {   '##':'    - [{0}]({1})',
         '###':'        - [{0}]({1})',
        '####':'            - [{0}]({1})',
       '#####':'                - [{0}]({1})'}


class notebook():
    def __init__(self, filename):
        self.filename = filename
        self.path = os.path.join(NOTEBOOK_DIR, filename)
        self.chapter, self.section, _ = REG.match(filename).groups()
        self.url = os.path.join(NBVIEWER_BASE_URL, filename)
        self.colab_link = COLAB_LINK.format(notebook_filename=os.path.basename(self.filename))
        self.nb = nbformat.read(self.path, as_version=4)
        self.title = self.read_title()
        self.navbar = None
        self.toc_entry = self.get_toc_entry()
        self.toc = self.get_toc()

    def read_title(self):
        title = None
        for cell in self.nb.cells:
            if cell.cell_type == "markdown":
                if cell.source.startswith('#'):
                    title = cell.source[1:].splitlines()[0].strip()
                    break
        return title

    def write_course_info(self):
        if self.nb.cells[0].source.startswith(COURSE_COMMENT):
            print('- amending comment for: {0}'.format(self.filename))
            self.nb.cells[0].source = COURSE_INFO
        else:
            print('- inserting comment for {0}'.format(self.filename))
            self.nb.cells.insert(0, new_markdown_cell(COURSE_INFO))
        nbformat.write(self.nb, self.path)

    def write_navbar(self):
        if self.nb.cells[1].source.startswith(NAV_COMMENT):
            print("- amending navbar for {0}".format(self.filename))
            self.nb.cells[1].source = self.navbar
        else:
            print("- inserting navbar for {0}".format(self.filename))
            self.nb.cells.insert(1, new_markdown_cell(source=self.navbar))
        if self.nb.cells[-1].source.startswith(NAV_COMMENT):
            self.nb.cells[-1].source = self.navbar
        else:
            self.nb.cells.append(new_markdown_cell(source=self.navbar))
        nbformat.write(self.nb, self.path)

    def get_toc_entry(self):
        if self.chapter.isdigit():
            self.chapter = int(self.chapter)
            if self.chapter == 0:
                fmt = "\n### [{2}]({3})" if self.section in '00' else "- [{2}]({3})"
            else:
                fmt = "\n### [Chapter {0}. {2}]({3})" if self.section in '00' else "- [{0}.{1} {2}]({3})"
        else:
            fmt = "\n### [Appendix {0}. {2}]({3})" if self.section in '00' else "- [{0}.{1} {2}]({3})"
        return fmt.format(self.chapter, int(self.section), self.title, self.url)

    def get_toc(self):
        toc = []
        for cell in self.nb.cells:
            if cell.cell_type == "markdown":
                if cell.source.startswith('##'):
                    header = cell.source.splitlines()[0].strip().split()
                    txt = ' '.join(header[1:])
                    url = '#'.join([self.url, '-'.join(header[1:])])
                    toc.append(FMT[header[0]].format(txt, url))
        return toc

    def __gt__(self, nb):
        return self.filename > nb.filename

    def __str__(self):
        return self.filename


def set_navbars(notebooks):
    a, b, c = itertools.tee(notebooks, 3)
    next (c)
    for prev_nb, this_nb, next_nb in zip(itertools.chain([None], a), b, itertools.chain(c, [None])):
        this_nb.navbar = NAV_COMMENT
        this_nb.navbar += PREV_TEMPLATE.format(title=prev_nb.title, url=prev_nb.url) if prev_nb else ''
        this_nb.navbar += CONTENTS
        this_nb.navbar += NEXT_TEMPLATE.format(title=next_nb.title, url=next_nb.url) if next_nb else ''
        this_nb.navbar += this_nb.colab_link

notebooks = sorted([notebook(filename) for filename in os.listdir(NOTEBOOK_DIR) if REG.match(filename)])

set_navbars(notebooks)

for n in notebooks:
    n.write_course_info()
    n.write_navbar()

with open(README_FILE, 'w') as f:
    f.write(README_HEADER)
    f.write('\n'.join([n.toc_entry for n in notebooks]))
    f.write(README_FOOTER)

with open(INDEX_FILE, 'w') as f:
    f.write(INDEX_HEADER)
    f.write('\n'.join(['\n'.join([n.toc_entry, *n.toc]) for n in notebooks]))

os.system(' '.join(['notedown', INDEX_FILE, '>', INDEX_NB]))





