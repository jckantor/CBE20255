%% Methanol Production Flowsheet

%% Problem Statement
% Methanol (CH3OH) can be produced from synthesis gas (36 mol% CO, 
% 60 mol% H2, and 4 mol% inert N2) as shown in the accompanying figure. 
% The reaction is 
%
%   CO + 2 H2 -> CH3OH
%
% In steady-state operation the reactor has a fractional conversion of 
% 20% of the limiting reactant. 5% of the recycled gas is purged.
%
% # What fraction of the incoming CO is converted to CH3OH? 
% # What fraction of the incoming H2 is converted to methanol?
% # What fraction of the reactor inlet consists of inerts?

%% Required Matlab 
%
% * |CVX|
% * |displaytable.m|

%% Flowsheet
% 
% The flowsheet has been transcribed from the problem statement. The
% streams are numbered and labeled with component flows.

[I,m] = imread('methanol_production_flowsheet.png','png');
I = imresize(I,0.25,'Method','nearest','Antialiasing',false);
imshow(I,m);
axis off;

%% CVX Model
% We'll use the following abbreviations
%
%  C  Carbon Monoxide (CO)
%  H  Hydrogen (H2)
%  N  Nitrogen (N2)
%  M  Methanol (CH3OH)

cvx_begin

    % Stream Variables (20)
    variables C1 H1 N1
    variables C2 H2 N2
    variables C3 H3 N3 M3
    variables C4 H4 N4
    variables C5 H5 N5
    variables C6 H6 N6
    variables M7
    
    % Extents of Reaction (1)
    variables X
    
    % MATERIAL BALANCES (14)
    
    % Mixer (3)
    0 == C1 + C5 - C2;
    0 == H1 + H5 - H2;
    0 == N1 + N5 - N2;
    
    % Reactor (4)
    0 == C2 - C3 - X;
    0 == H2 - H3 - 2*X;
    0 == N2 - N3;
    0 == -M3 + X;
  
    % Condenser (4)
    0 == C3 - C4;
    0 == H3 - H4;
    0 == N3 - N4;
    0 == M3 - M7;
    
    % Purge (3)
    0 == C4 - C5 - C6;
    0 == H4 - H5 - H6;
    0 == N4 - N5 - N6;
    
    % SPECIFICATIONS (7)
    
    % Feed rates
    C1 == 36;
    H1 == 60;
    N1 == 4;
    
    % 20% Fractional Conversion
    H3 == 0.80*H2;
    
    % Purge Fraction
    C6 == 0.05*C4;
    H6 == 0.05*H4;
    N6 == 0.05*N4;

cvx_end

%% Stream Table
% The stream variables are organized into a stream table. To keep the width
% small enough to fit on a sheet of paper, the stream table is presented
% with columns representing components, and rows denoting streams.

flows = [ ...
    C1   C2   C3   C4   C5   C6    0;
    H1   H2   H3   H4   H5   H6    0;
    N1   N2   N3   N4   N5   N6    0;
     0    0   M3    0    0    0   M7];

comps = {'C','H','N','M'};
displaytable(flows,comps,'S');

%% What fraction of the incoming CO is converted to CH3OH?

Yield_CO = (C1-C6)/C1;
displaytable(Yield_CO,'Fraction of CO converted to CH3OH = ');

%% What fraction of the incoming H2 is converted to CH3OH?

Yield_H2 = (H1-H6)/H1;
displaytable(Yield_H2,'Fraction of H2 converted to CH3OH = ');

%% What fraction of the reactor inlet consists of inerts?

y_inerts = N2/(C2 + H2 + N2);
displaytable(y_inerts,'Mole fraction of inerts in reactor feed = ');
