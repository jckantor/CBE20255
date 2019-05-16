
# Edit the following string variables to customize tools to a new notebook repository
USER = "jckantor"
REPO = "CBE20255"
DESC = "Introduction to Chemical Engineering Analysis"
PAGE = "http://jckantor.github.io/CBE20255/"

# header to be inserted at the top of each notebook
COURSE_INFO_HEADER = """
*This notebook contains course material from 
[CBE 20255 Introduction to Chemical Engineering Analysis](http://jckantor.github.io/CBE20255/) 
by Jeffrey Kantor (jeff at nd.edu); the content is available [on GitHub](https://github.com/jckantor/CBE20255).
The text is released under the [CC-BY-NC-ND-4.0 license](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode),
and code is released under the [MIT license](https://opensource.org/licenses/MIT).*
"""

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
