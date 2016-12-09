% Author: Steven Wang    Date:20161116
% XOM option chain data as of 20161116

%%
% Initialization
clear all

S0=85.75;
St=85.75;
K1=80;
K2=85;
T=0.5;
delta=0.035;
r=0.005;
sigma=0.6;
N=10000;
Delta=T/N;

%%
%BS pricing formula

d_1 = (log((St*exp(1)^(-delta*T))/(K2*exp(1)^(-r*T))) + 0.5*sigma^2*T)/(sigma*sqrt(T));
d_2 = d_1 - sigma*sqrt(T);
GapCall = St*exp(1)^(-delta*T)*normcdf(d_1) - K1*exp(1)^(-r*T)*normcdf(d_2);
GapPut = K1*exp(1)^(-r*T)*normcdf(-d_2) - St*exp(1)^(-delta*T)*normcdf(-d_1);

%%
%Monte Carlo of BS
GapCall_MC_prices = zeros(N,1);
GapPut_MC_prices = zeros(N,1);

for c = 1:10*N
    St = S0;
    for n = 1:N
        dS_t = (r-delta)*St*Delta + sigma*St*randn*sqrt(Delta);
        St = St + dS_t;
    end
    if (St > K2) && (St > K1)
        GapCall_MC_prices(c,1) = St - K1;
    end
end

GapCall_MC = exp(1)^(-r*T)*mean(GapCall_MC_prices)



