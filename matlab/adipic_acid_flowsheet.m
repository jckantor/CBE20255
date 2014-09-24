%% Solving Material Balances using CVX
%
% Implementation of material balances for Ex. 2.15, Adipic Acid Production,
% R. Murphy, "Introduction to Chemical Engineering Analysis"
%
% Jeffrey Kantor
% September 24, 2014

%% Requirements
%
% * CVX (available from http://cvxr.com)
% * |displaytable.m|

%% CVX Model 

cvx_begin quiet

    % Declare unknown molar flowrates (kg-moles/hour)
    %         Oxy   Nit   Glu   Wat   Hyd   CO2   AdA   MuA
    variables  O1    N1                                       % Stream  1
    variables              G2    W2                           % Stream  2
    variables                          H3                     % Stream  3
    variables        N4                      C4               % Stream  4
    variables                    W5                           % Stream  5
    variables                                      A6         % Stream  6
    variables  O7    N7    G7    W7                           % Stream  7
    variables        N8          W8          C8          M8   % Stream  8
    variables                                            M9   % Stream  9
    variables                          H10               M10  % Stream 10
    
    % Declare unknown extents of reaction
    variables Extent1 Extent2
    
    % Mixer 1
    0 == O1 - O7;
    0 == N1 - N7;
    0 == G2 - G7;
    0 == W2 - W7;
    
    % Reactor 1
    % Extent of Reaction (7/3)G + (17/2)X -> M + 8C + 11W
    0 == O7       - (17/2)*Extent1;
    0 == N7 - N8;
    0 == G7       -  (7/3)*Extent1;
    0 ==    - C8  +      8*Extent1;
    0 ==    - M8  +        Extent1;
    0 == W7 - W8  +     11*Extent1;
    
    % Separator
    0 == N8 - N4;
    0 == C8 - C4;
    0 == M8 - M9;
    0 == W8 - W5;
    
    % Mixer 2
    0 == M9 - M10;
    0 == H3 - H10;
    
    % Reactor 2
    % Extent of Reaction M + 2H -> A   
    0 == H10      - 2*Extent2;
    0 == M10      -   Extent2;
    0 ==     - A6 +   Extent2;
    
    % Problem Specifications
    A6 == 82.2;
    N1 == (.79/.21)*O1;
    G2 == 0.001006*W2;   
    
cvx_end

%%
% Display Stream Table

disp('Stream Table (flows in kg-moles/hour)');
Comps = {'O2','N2','Glu','H2O','H2','CO2','M Acid','A Acid'};
flows = [ ...
     O1,  0,  0,  0,  0,  0, O7,  0,  0,   0;
     N1,  0,  0, N4,  0,  0, N7, N8,  0,   0;
      0, G2,  0,  0,  0,  0, G7,  0,  0,   0;
      0, W2,  0,  0, W5,  0, W7, W8,  0,   0;
      0,  0, H3,  0,  0,  0,  0,  0,  0, H10;
      0,  0,  0, C4,  0,  0,  0, C8,  0,   0;
      0,  0,  0,  0,  0,  0,  0, M8, M9, M10;
      0,  0,  0,  0,  0, A6,  0,  0,  0,   0];

displaytable(flows,Comps,'S','%6.0f');
displaytable(Extent1,'Extent 1 = ');
displaytable(Extent2,'Extent 2 = ');

    