%% Format Results with displaytable
%
% A time consuming aspect of using Matlab for routine homework
% solution is formatting tablular results for display.  The function
% |displaytable.m| saves time by allowng you to easily format and label 
% numerical results for display, or for export to a spreadsheet, a
% document, or html.
%
% |displaytable| is used in many of the following Matlab scripts.

%% Downloading and Installing
%
% |displaytable.m| can be viewed and downloaded from 
% <https://gist.github.com/jckantor/8436117>. Move to your Matlab directory
% and it is ready to use.
%
%% Examples
%
% 1. Display a simple table

A = magic(4);
displaytable(A);

%%
% 2. Annotate a simple result

displaytable(pi,'Pi = ');

%%
% 3. Display a table with row and column headings

displaytable(A,'Row','Col')

%%
% 4. Create a table of molecular weights

s = {'CH4','C2H6','C3H8'}';
mw = [16.04; 30.07; 44.1];
displaytable(mw,s,'Mol. Wt.');

%%
% 5. Format a stream table.

strms = {'Feed','Rctr. Eff.','Recycle','Purge','Product'};
comps = {'Ethylene','O2','N2','EO'};
flows = 1000*rand(4,5);
displaytable(flows,comps,strms);

%%
% 6. Format a table of molecular weights to include in a web page.

displaytable(mw,s,'Mol. Wt.','','html');


