%% Material balances for Example 3.19: Ethylene Oxide Flowsheet
%
% The example demonstrates the formulation and solution of material
% balances for a simple process flowsheet with recycle. The solution is
% computed using CVX, a convex optimization package distributed by
% cvxr.com. The following example solves Example 3.19 of the Murphy
% textbook.
%
% JCK 9/28/2012

%% Functions Used
%
% * |CVX|
% * |displaytable.m|

%% Process Flowsheet
%
% The process flowsheet consists of three units, five streams, and three
% components: ethylene (E), oxygen (O), and ethylene oxide (EO). The
% feedstream consists of 196 kgmol/hr E and 84.5 kgmol/hr. The reaction
% stoichiometry is given by
%
%                  Reaction:  2 E + O --> 2 EO
%              ____________________________________
%             |                  5                 |
%         ____V____         _________         _____|_____
%    1   |         |   2   |         |   3   |           |     4
%  ----->|  Mixer  |------>| Reactor |------>| Separator |--------->
%        |_________|       |_________|       |___________|
%
%

%% Component Numbering
%
% To minimize the potential for coding errors, we use component indices
% chosen as mnemonics of the species contained in the process flowsheet.

O  = 1;   % oxygen
E  = 2;   % ethylene
EO = 3;   % ethylene oxide

%% Stoichometric Coefficients
%
% Stoichiometric coefficients are stored in a vector. The index
% corresponds to the species involved in the reactions.

v(O)  = -1;
v(E)  = -2;
v(EO) =  2;

%% Reactor Conversion
%
% The reactor performance is stated in terms of the fraction of the feed E
% converted to EO. This fraction is fce3.

fce3 = 0.06;

%% Separator Efficiencies
%
% The separator efficiency is specified in terms of the fraction of each
% incoming component that goes to the preferred outlet stream.

fo5  = 0.995;
fe5  = 0.98;
feo4 = 0.97;

%% Solution of the Steady State Equations
%
% The stream variables are represented by a matrix n(3,5) of variables, and
% the extent of reaction is a single variable x. Once these are declared,
% we simply write out all of the material balance equations and process
% specifications.

cvx_begin quiet
    
    % Declare the problem variables
    variables n(3,5);    % A table of molar flowrates
    variables x;         % Extent of reaction
    
    % Mixer Balance
    0 == n(O,1) + n(O,5) - n(O,2);
    0 == n(E,1) + n(E,5) - n(E,2);
    0 == n(EO,1) + n(EO,5) - n(EO,2);
    
    % Reactor Balance
    0 == n(O,2) - n(O,3) + v(O)*x;
    0 == n(E,2) - n(E,3) + v(E)*x;
    0 == n(EO,2) - n(EO,3) + v(EO)*x;
       
    % Seperator Balance
    0 == n(O,3) - n(O,4) - n(O,5);
    0 == n(E,3) - n(E,4) - n(E,5);
    0 == n(EO,3) - n(EO,4) - n(EO,5);
    
    % Feed Stream Specifications
    n(O,1) == 84.5;
    n(E,1) == 196;
    n(EO,1) == 0;
    
    % Reactor Conversion
    2*x == fce3*n(E,2);
    
    % Seperator Effciencies
    n(O,5) == fo5*n(O,3);
    n(E,5) == fe5*n(E,3);
    n(EO,4) == feo4*n(EO,3);

cvx_end

%% Display Results

disp('Stream Table [kgmol/hr]');
displaytable([n;sum(n)],{'O','E','EO','TOTAL'},'Stream','%5.1f');
fprintf('\nEO purity     = %5.3f  mol%%\n',100*n(3,4)/sum(n(:,4)));
