% Author: Steven Wang    Date: 20161208
% XOM option chain data as of 20161116

%% Initialization

clear all

sigma=0.6;
r=0.005;
delta=0.035;
T=0.5;
n=15;
h=T/n;
K1=80;
K2=85;
X0=85;
S_t = 85.75;

%% Boundary

X = zeros(n,1);

% Initialize the first values

syms X
d1 = (log(X/K2) + (r - delta + 0.5*sigma^2)*h)/(sigma*sqrt(h));
d2 = (log(X/X0) + (r - delta + 0.5*sigma^2)*h)/(sigma*sqrt(h));
eqn = X - K1 == X*exp(-delta*h)*normcdf(d1) - K1*exp(-r*h)*normcdf(d1 - sigma*sqrt(h)) + h*(delta*X*exp(-delta*h)*normcdf(d2) - exp(-r*h)*r*K1*normcdf(d2-sigma*sqrt(h)));
Y(n) = double(solve(eqn, X));

% loop
t = linspace(0,T,n);
summation = 0;
summ = zeros(n-1,1);
for i=1:(n-1)
    j = n-i;
    syms X
    d1 = (log(X/K2) + (r - delta + 0.5*sigma^2)*(T-t(j)))/(sigma*sqrt(T-t(j)));
    d2 = (log(X/Y(j+1)) + (r - delta + 0.5*sigma^2)*h)/(sigma*sqrt(h));
    pi = h*(delta*exp(-delta*h)*X*normcdf(d2) - exp(-r*h)*r*K1*normcdf(d2-sigma*sqrt(h)));
    summation = summation + pi;

    
    eqn = X - K1 == X*exp(-delta*(T-t(j)))*normcdf(d1) - K1*exp(-r*(T-t(j)))*normcdf(d1 - sigma*sqrt(T-t(j))) + summation;
    Y(j) = double(solve(eqn, X));

    pi = h*(delta*exp(-delta*h)*Y(j)*normcdf((log(Y(j)/Y(j+1)) + (r - delta + 0.5*sigma^2)*h)/(sigma*sqrt(h))) - exp(-r*h)*r*K1*normcdf((log(Y(j)/Y(j+1)) + (r - delta + 0.5*sigma^2)*h)/(sigma*sqrt(h))-sigma*sqrt(h)));
    summ(i) = pi;
   
end

plot(t,Y)
xlabel('t')
ylabel('B(t)')
title('Boundary')


%% Option Prices
	d1 = (log(S_t/K2) + (r - delta + 0.5*sigma^2)*(T-t(1)))/(sigma*sqrt(T-t(1)));
    d2 = d1-sigma*sqrt(T-t(1));
    C = S_t*exp(-delta*(T-t(1)))*normcdf(d1)-K1*exp(-r*(T-t(1)))*normcdf(d1-sigma*sqrt(T-t(1))) + sum(summ);
