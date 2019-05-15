
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

### [Getting Started](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/00.00-Getting-Started.ipynb)
- [Getting Started with Jupyter Notebooks, Python, and Google Colaboratory](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/00.01-Getting-Started-with-Jupyter-Notebooks-and-Python.ipynb)

### [Chapter 1. Units, Quantities, and Engineering Calculations](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/01.00-Units-Quantities-and-Engineering-Calculations.ipynb)

### [Chapter 2. Stoichiometry](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/02.00-Stoichiometry.ipynb)
- [2.1 Balancing Reactions](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/02.01-Balancing-Reactions.ipynb)

### [Chapter 3. Process Flows and Balances](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/03.00-Process-Flows-and-Balances.ipynb)
- [3.2 $CO_2$ Production by Automobiles](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/03.02-CO2-Production-by-Automobiles.ipynb)
- [3.5 Adipic Acid Flowsheet](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/03.05-Adipic-Acid-Flowsheet.ipynb)

### [Chapter 4. Material Balances](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/04.00-Material-Balances.ipynb)
- [4.2 Ethylene Oxide Flowsheet](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/04.02-Ethylene-Oxide-Flowsheet.ipynb)

### [Chapter 5. Reactors](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/05.00-Reactors.ipynb)
- [5.1 Dehydrogenation of Propane](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/05.01-Dehydrogenation-of-Propane.ipynb)

### [Chapter 6. Vapors and Gases](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/06.00-Vapors-and-Gases.ipynb)

### [Chapter 7. Vapor/Liquid Equilibrium](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/07.00-Vapor-Liquid-Equilibrium.ipynb)
- [7.7 Bubble and Dew Points for Binary Mixtures](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/07.07-Bubble-and-Dew-Points-for-Binary-Mixtures.ipynb)
- [7.8 Bubble and Dew Points for Multicomponent Mixtures](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/07.08-Bubble-and-Dew-Points-for-Multicomponent-Mixtures.ipynb)
- [7.10 Binary Distillation with McCabe-Thiele](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/07.10-Binary-Distillation-with-McCabe-Thiele.ipynb)

### [Chapter 8. Energy Balances](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/08.00-Energy-Balances.ipynb)
- [8.1 Energy Balances on a Classroom](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/08.01-Energy-Balances-on-a-Classroom.ipynb)
- [8.3 Basic Energy Computations](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/08.03-Basic-Energy-Calculations.ipynb)
- [8.4 Energy Balances for a Steam Turbine](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/08.04-Energy-Balances-for-a-Steam-Turbine.ipynb)
- [8.6 Adiabatic Flame Temperature](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/08.06-Adiabatic-Flame-Temperature.ipynb)
- [8.6 Binary Phase Diagrams for Ideal Mixtures](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/08.06-Binary-Phase-Diagrams-for-Ideal-Mixtures.ipynb)

### [Appendix A. Products: Product Design and Analysis](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/A.00-Projects-Product-Design-and-Analysis.ipynb)
- [A.1 Diesel Engine Emissions Control](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/A.01-Diesel-Engine-Emissions-Control.ipynb)

### [Appendix B. Projects: Process Systems Analysis](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/B.00-Projects-Process-Systems-Analysis.ipynb)
- [B.2 Ajka Alumina Plant Spill](http://nbviewer.jupyter.org/github/jckantor/CBE20255/blob/master/notebooks/B.02-Ajka-Alumina-Plant-Spill.ipynb)
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
Permission to use these videos is gratefully acknowledged.
