%% Solving Material Balances using CVX
%
% Implementation of material balances for Ex. 2.15, Adipic Acid Production,
% R. Murphy, "Introduction to Chemical Engineering Analysis"
%
% Jeffrey Kantor
% February 10, 2014

%% Requirements
%
% * CVX (available from http://cvxr.com)
% * |displaytable.m|

%% CVX Model 

cvx_begin quiet

    % Declare unknown mass flows

    %         Oxy   Nit   Glu   Wat   Hyd   CO2   AdA   MuA
    variables  X1    N1
    variables              G2    W2
    variables                          H3
    variables        N4                      C4
    variables                    W5
    variables                                      A6
    variables  X7    N7    G7    W7
    variables        N8          W8          C8          M8
    variables                                            M9
    variables                          H10               M10
    
    % Mixer 1
    
    0 == X1 - X7;
    0 == N1 - N7;
    0 == G2 - G7;
    0 == W2 - W7;
    
    % Reactor 1
    % Extent of Reaction (7/3)G + (17/2)X -> M + 8C + 11W
    
    variables Z1
        
    0 == X7       - (17/2)*Z1;
    0 == N7 - N8;
    0 == G7       -  (7/3)*Z1;
    0 ==    - C8  +      8*Z1;
    0 ==    - M8  +        Z1;
    0 == W7 - W8  +     11*Z1;
    
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
    
    variables Z2
    
    0 == H10      - 2*Z2;
    0 == M10      -   Z2;
    0 ==     - A6 +   Z2;
    
    % Problem Specifications
    
    A6 == 82.2;
    N1 == (.79/.21)*X1;
    G2 == 0.001006*W2;   
    
cvx_end

%%
% Display Stream Table

disp('Stream Table');
Comps = {'O2','N2','Glu','H2O','H2','CO2','M Acid','A Acid'};
flows = [ ...
     X1,  0,  0,  0,  0,  0, X7,  0,  0,   0;
     N1,  0,  0, N4,  0,  0, N7, N8,  0,   0;
      0, G2,  0,  0,  0,  0, G7,  0,  0,   0;
      0, W2,  0,  0, W5,  0, W7, W8,  0,   0;
      0,  0, H3,  0,  0,  0,  0,  0,  0, H10;
      0,  0,  0, C4,  0,  0,  0, C8,  0,   0;
      0,  0,  0,  0,  0,  0,  0, M8, M9, M10;
      0,  0,  0,  0,  0, A6,  0,  0,  0,   0];

displaytable(flows,Comps,'S','%6.0f');
displaytable(Z1,'Extent 1 = ');
displaytable(Z2,'Extent 2 = ');

    