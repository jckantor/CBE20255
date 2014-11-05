%% Bubble and Dew Point Calculations
%
% These notes demonstrate bubble point and dew point calculations in
% Matlab.

%% Antoine Coefficients 
% The following data for methanol (MeOH) and water (H2O) are taken from
% Appendix B.4 of the textbook. Note that the units are assumed to be mmHg
% for pressure, and degrees C for temperature.

clear all

A.MeOH = 7.97328;
B.MeOH = 1515.14;
C.MeOH = 232.85;

A.H2O = 7.96681;
B.H2O = 1668.21;
C.H2O = 228.0;

%% Antoine Equation
% The following functions implement Antoine's equation for MeOH and H2O.
% The units are converted to accept temperature in degrees Kelvin and
% return pressure in kPa.

Psat.MeOH = @(T) (101.325/760)*(10.^(A.MeOH - B.MeOH/((T-273.15) + C.MeOH)));
Psat.H2O  = @(T) (101.325/760)*(10.^(A.H2O - B.H2O/((T-273.15) + C.H2O)));

%%
% Plot Saturate Pressure vs. Temperature

T = linspace(330,370,100);
plot(T,arrayfun(Psat.MeOH,T),T,arrayfun(Psat.H2O,T));
xlabel('Temperature [deg K]');
ylabel('Pressure [kPa]');
title('Saturation (Vapor) Pressure');
legend('Methanol','Water','Location','Best');
grid;

%% Boiling Points
% As an initial check, we compute the  boiling points of methanol and
% water. Here we use implement a straightforward calculation.

P = 101.325;

Tboil.MeOH = fzero(@(T) Psat.MeOH(T) - P, 300);
Tboil.H2O = fzero(@(T) Psat.H2O(T) - P, 300);

disp(['Boiling Points [deg K] at ',num2str(P),' kPa:']);
disp(Tboil);

%% Bubble Point Calculations
% The bubble point calculations begin by solving the equation
%
% $$\underbrace{\sum_{i} x_i \frac{P^{sat}_i(T)}{P} - 1}_{f_{bub}(P,T,x)} = 0 $$
%

fbub = @(P,T,x) x*Psat.MeOH(T)/P + (1-x)*Psat.H2O(T)/P - 1;

%%
% Given P and x, the bubble point temperature is the value of T for which
%
% $$f_{bub}(P,T,x) = 0$$

P = 97.99;
x.MeOH = 0.24;

Tbub = fzero(@(T)fbub(P,T,x.MeOH),360);

disp('Bubble Point Temperature');
disp(Tbub);

%%
% Once the bubble point temperature has been found, we can compute the
% vapor phase composition by Raoult's law
%
% $$ y_i = \frac{P^{sat}_i(T_{bub})}{P}x_i $$

x.H2O = 1 - x.MeOH;

y.MeOH = x.MeOH*Psat.MeOH(Tbub)/P;
y.H2O = x.H2O*Psat.H2O(Tbub)/P;

%%
% Display summary of results

disp(['Pressure: ',num2str(P),' kPa']);
disp(['Bubble Point Temperature ',num2str(Tbub),' deg K']);
disp(['Liquid Phase Composition:']);
disp(x);
disp(['Vapor Phase Composition:']);
disp(y);

%% Dew Point Calculations
% The dew point calculations begin by solving the equation
%
% $$\underbrace{\sum_i y_i \frac{P}{P^{sat}_i(T)} - 1}_{f_{dew}(P,T,y)} = 0 $$

fdew = @(P,T,y) y*P/Psat.MeOH(T) + (1-y)*P/Psat.H2O(T) - 1;

%%
% Given P and y, the dew point temperature is the value of T for which 
%
% $$f_{dew}(P,T,y) = 0$$

P = 97.99;
y.MeOH = 0.4;

Tdew = fzero(@(T) fdew(P,T,y.MeOH),360);

disp('Dew Point Temperature');
disp(Tdew);

%%
% Once the dew point temperature has been determined, the liquid phase
% composition is found from Raoult's law
%
% $$x_i = y_i \frac{P}{P^{sat}_i(T_{dew})}$$

y.H2O = 1 - y.MeOH;

x.MeOH = y.MeOH*P/Psat.MeOH(Tdew);
x.H2O = y.H2O*P/Psat.H2O(Tdew);

%%
% Display summary of results

disp(['Pressure: ',num2str(P),' kPa']);
disp(['Dew Point Temperature ',num2str(Tdew),' deg K']);
disp(['Liquid Phase Composition:']);
disp(x);
disp(['Vapor Phase Composition:']);
disp(y);

%% Txy Diagram
% Vapor/Liquid Equilibrium data is commonly displayed in the form of a
% T-x-y diagram. For example, the following experimental data for a binary
% Methanol/Water system is available from
% |http://www.ddbst.com/en/EED/VLE/VLE%20Methanol%3BWater.php|

% Experimental Data
P = 97.99;
Texpt = [373.22 369.65 365.45 360.65 353.25 349.05 343.75 341.85 339.55 336.98];
xexpt = [0.0000 0.0084 0.0258 0.0680 0.1370 0.2400 0.4800 0.5720 0.7410 1.0000];
yexpt = [0.0000 0.1030 0.2270 0.3910 0.5680 0.6800 0.7900 0.8200 0.9060 1.0000];

plot(xexpt,Texpt,'b.','Markersize',25);
hold on;
plot(yexpt,Texpt,'r.','Markersize',25);
grid;
xlabel('x,y mole fraction Methanol');
ylabel('Temperature [K]');
title('Txy Diagram for Methanol/Water');

%%
% Given pressure and the liquid (or vapor) composition, we can solve for
% the bubble (or dew) point temperature.  We


% Add our calculations

P = 97.99;
Tbub = @(x) fzero(@(T) fbub(P,T,x), 360);
Tdew = @(y) fzero(@(T) fdew(P,T,y), 360);

x = linspace(0,1,100);
plot(x,arrayfun(Tbub,x),'Linewidth',2)

y = linspace(0,1,100);
plot(y,arrayfun(Tdew,y),'Linewidth',2);
hold off;
