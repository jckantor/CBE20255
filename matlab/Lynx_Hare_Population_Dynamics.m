%% Population Cycles of Hare and Lynx

a = 3.2; 
b = 0.6; 
c = 50; 
d = 0.56; 
k = 125; 
r = 1.6;

dH = @(H,L) r*H*(1-H/k) - a*H*L/(c+H); 
dL = @(H,L) b*a*H*L/(c+H) - d*L;

deriv = @(x) [dH(x(1),x(2)); dL(x(1),x(2))];
% Simulate
tspan = [0 70];
ic = [20;20];
[t,x] = ode45(@(t,x)deriv(x),tspan, ic);
% Diplay results
plot(t,x);

xlabel('Time [years]'); 
ylabel('Population');
title('Lynx/Hare Preditor-Prey Dynamics'); 
legend('Hare','Lynx','Location','NW');