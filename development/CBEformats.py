# CBEformats.py
# Python script to initialize IPython notebooks. Run with command
# run -i CBEformats

# Increase the size of the default inline graphics used in IPython notebooks

pylab.rcParams['figure.figsize'] = (10.0, 6.0)
pylab.rcParams['font.size'] = 12

# Utility function to run cells from another notebook in the current namespace.
# Use with execute_notebook("AntoineEquation.ipynb")

import io
from IPython.nbformat import current
def execute_notebook(nbfile):
    with io.open(nbfile) as f:
        nb = current.read(f,'json')
    ip = get_ipython()
    for cell in nb.worksheets[0].cells:
        if cell.cell_type != 'code':
            continue
        ip.run_cell(cell.input)