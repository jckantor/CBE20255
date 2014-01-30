# -*- coding: utf-8 -*-
"""
=========
tikzmagic
=========

Magics for generating figures with TikZ.

.. note::

  ``TikZ`` and ``LaTeX`` need to be installed separately.

Usage
=====

``%%tikz``

{TIKZ_DOC}

"""

#-----------------------------------------------------------------------------
#  Copyright (C) 2013 The IPython Development Team
#
#  Distributed under the terms of the BSD License.  The full license is in
#  the file COPYING, distributed as part of this software.
#-----------------------------------------------------------------------------

import sys
import tempfile
from glob import glob
from os import chdir, getcwd
from subprocess import call
from shutil import rmtree
from shutil import move
from xml.dom import minidom

from IPython.core.displaypub import publish_display_data
from IPython.core.magic import (Magics, magics_class, line_magic,
                                line_cell_magic, needs_local_scope)
from IPython.testing.skipdoctest import skip_doctest
from IPython.core.magic_arguments import (
    argument, magic_arguments, parse_argstring
)
from IPython.utils.py3compat import unicode_to_str

_mimetypes = {'png' : 'image/png',
             'svg' : 'image/svg+xml',
             'jpg' : 'image/jpeg',
              'jpeg': 'image/jpeg'}

@magics_class
class TikzMagics(Magics):
    """A set of magics useful for creating figures with TikZ.
    """
    def __init__(self, shell):
        """
        Parameters
        ----------
        shell : IPython shell

        """
        super(TikzMagics, self).__init__(shell)
        self._plot_format = 'png'

        # Allow publish_display_data to be overridden for
        # testing purposes.
        self._publish_display_data = publish_display_data


    def _fix_gnuplot_svg_size(self, image, size=None):
        """
        GnuPlot SVGs do not have height/width attributes.  Set
        these to be the same as the viewBox, so that the browser
        scales the image correctly.

        Parameters
        ----------
        image : str
            SVG data.
        size : tuple of int
            Image width, height.

        """
        (svg,) = minidom.parseString(image).getElementsByTagName('svg')
        viewbox = svg.getAttribute('viewBox').split(' ')

        if size is not None:
            width, height = size
        else:
            width, height = viewbox[2:]

        svg.setAttribute('width', '%dpx' % width)
        svg.setAttribute('height', '%dpx' % height)
        return svg.toxml()
    
    
    def _run_latex(self, code, dir):
        f = open(dir + '/tikz.tex', 'w')
        f.write(code)
        f.close()
        
        current_dir = getcwd()
        chdir(dir)
        
        ret_log = False
        log = None
        
        try:
            retcode = call("pdflatex -shell-escape tikz.tex", shell=True)
            if retcode != 0:
                print >> sys.stderr, "LaTeX terminated with signal", -retcode
                ret_log = True
        except OSError as e:
            print >> sys.stderr, "LaTeX execution failed:", e
            ret_log = True
        
        # in case of error return LaTeX log
        if ret_log:
            try:
                f = open('tikz.log', 'r')
                log = f.read()
                f.close()
            except IOError:
                print >> sys.stderr, "No log file generated."
        
        chdir(current_dir)
    
        return log
    

    def _convert_pdf_to_svg(self, dir):
        current_dir = getcwd()
        chdir(dir)
        
        try:
            retcode = call("pdf2svg tikz.pdf tikz.svg", shell=True)
            if retcode != 0:
                print >> sys.stderr, "pdf2svg terminated with signal", -retcode
        except OSError as e:
            print >> sys.stderr, "pdf2svg execution failed:", e
        
        chdir(current_dir)
        

    def _convert_png_to_jpg(self, dir):
        current_dir = getcwd()
        chdir(dir)
        
        try:
            retcode = call("convert tikz.png -quality 100 -background white -flatten tikz.jpg", shell=True)
            if retcode != 0:
                print >> sys.stderr, "convert terminated with signal", -retcode
        except OSError as e:
            print >> sys.stderr, "convert execution failed:", e

        chdir(current_dir)
        

    @skip_doctest
    @magic_arguments()
    @argument(
        '-sc', '--scale', action='store',
        help='Scaling factor of plots. Default is "--scale 1".'
        )
    @argument(
        '-s', '--size', action='store',
        help='Pixel size of plots, "width,height". Default is "-s 400,240".'
        )
    @argument(
        '-f', '--format', action='store',
        help='Plot format (png, svg or jpg).'
        )

    @needs_local_scope
    @argument(
        'code',
        nargs='*',
        )
    @line_cell_magic
    def tikz(self, line, cell=None, local_ns=None):
        '''
        Run TikZ code in LaTeX and plot result.
        
            In [9]: %tikz \draw (0,0) rectangle (1,1);

        As a cell, this will run a block of TikZ code::

            In [10]: %%tikz
               ....: \draw (0,0) rectangle (1,1);

        In the notebook, plots are published as the output of the cell.

        The size and format of output plots can be specified::

            In [18]: %%tikz -s 600,800 -f svg --scale 2
                ...: \draw (0,0) rectangle (1,1);
                ...: \filldraw (0.5,0.5) circle (.1);

        '''
        args = parse_argstring(self.tikz, line)

        # arguments 'code' in line are prepended to the cell lines
        if cell is None:
            code = ''
            return_output = True
        else:
            code = cell
            return_output = False

        code = ' '.join(args.code) + code

        # if there is no local namespace then default to an empty dict
        if local_ns is None:
            local_ns = {}

        # generate plots in a temporary directory
        plot_dir = tempfile.mkdtemp().replace('\\', '/')
        
        if args.scale is not None:
            scale = args.scale
        else:
            scale = '1'

        if args.size is not None:
            size = args.size
        else:
            size = '400,240'

        width, height = size.split(',')
        
        if args.format is not None:
            plot_format = args.format
        else:
            plot_format = 'png'
        
        add_params = ""
        
        if plot_format == 'png' or plot_format == 'jpg' or plot_format == 'jpeg':
            add_params += "density=300,"
        
#\\documentclass[convert={%(add_params)ssize=%(width)sx%(height)s,outext=.%(plot_format)s},border=0pt]{standalone}
        
        pre_tex = '''
\\documentclass[convert={%(add_params)ssize=%(width)sx%(height)s,outext=.png},border=0pt]{standalone}
\\usepackage{tikz}
\\begin{document}
\\begin{tikzpicture}[scale=%(scale)s]
        ''' % locals()

        post_tex = '''
\\end{tikzpicture}
\\end{document}
        '''

        code = ' '.join((pre_tex, code, post_tex))
        text_output = self._run_latex(code, plot_dir)
        
        if plot_format == 'jpg' or plot_format == 'jpeg':
            self._convert_png_to_jpg(plot_dir)
        elif plot_format == 'svg':
            self._convert_pdf_to_svg(plot_dir)
        
        key = 'TikZMagic.Tikz'
        display_data = []

        # Publish text output
        if text_output:
            display_data.append((key, {'text/plain': text_output}))

        # Publish image
        try:
            image = open("%s/tikz.%s" % (plot_dir, plot_format), 'rb').read()
            plot_mime_type = _mimetypes.get(plot_format, 'image/%s' % (plot_format))
            width, height = [int(s) for s in size.split(',')]
            if plot_format == 'svg':
                image = self._fix_gnuplot_svg_size(image, size=(width, height))
            display_data.append((key, {plot_mime_type: image}))

        except IOError:
            print >> sys.stderr, "No image generated."
        
        rmtree(plot_dir)

        for source, data in display_data:
            self._publish_display_data(source, data)


__doc__ = __doc__.format(
    TIKZ_DOC = ' '*8 + TikzMagics.tikz.__doc__,
    )


def load_ipython_extension(ip):
    """Load the extension in IPython."""
    ip.register_magics(TikzMagics)
