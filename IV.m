% Author: Steven Wang    Date:20161116
% XOM option chain data as of 20161116


%% Import data from spreadsheet
% T1
clear all
% Script for importing data from the following spreadsheet:
%
%    Workbook: L:\Backup\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx
%    Worksheet: Sheet1

[~, ~, raw0_0] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','A23:A43');
[~, ~, raw0_1] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','C23:D43');
[~, ~, raw0_2] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','H23:H43');
[~, ~, raw0_3] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','J23:K43');
raw = [raw0_0,raw0_1,raw0_2,raw0_3];

data = reshape([raw{:}],size(raw));

Strike1 = data(:,1);
Bid1 = data(:,2);
Ask1 = data(:,3);
Strike2 = data(:,4);
Bid2 = data(:,5);
Ask2 = data(:,6);


clearvars data raw raw0_0 raw0_1 raw0_2 raw0_3;

%% Import data from spreadsheet
% T2
clear all
% Script for importing data from the following spreadsheet:
%
%    Workbook: D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx
%    Worksheet: Sheet1

[~, ~, raw0_0] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','A134:A144');
[~, ~, raw0_1] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','C134:D144');
[~, ~, raw0_2] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','H134:H144');
[~, ~, raw0_3] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','J134:K144');
raw = [raw0_0,raw0_1,raw0_2,raw0_3];

data = reshape([raw{:}],size(raw));

Strike1 = data(:,1);
Bid1 = data(:,2);
Ask1 = data(:,3);
Strike2 = data(:,4);
Bid2 = data(:,5);
Ask2 = data(:,6);

clearvars data raw raw0_0 raw0_1 raw0_2 raw0_3;

%% Import data from spreadsheet
% T3
clear all
% Script for importing data from the following spreadsheet:
%
%    Workbook: D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx
%    Worksheet: Sheet1

[~, ~, raw0_0] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','A188:A200');
[~, ~, raw0_1] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','C188:D200');
[~, ~, raw0_2] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','H188:H200');
[~, ~, raw0_3] = xlsread('D:\Onedrive\Dropbox\AcademyIII\MF770\Project\xom_option_chain_20161116.xlsx','Sheet1','J188:K200');
raw = [raw0_0,raw0_1,raw0_2,raw0_3];

data = reshape([raw{:}],size(raw));

Strike1 = data(:,1);
Bid1 = data(:,2);
Ask1 = data(:,3);
Strike2 = data(:,4);
Bid2 = data(:,5);
Ask2 = data(:,6);

clearvars data raw raw0_0 raw0_1 raw0_2 raw0_3;

%% Initialization
call_mid_price = 0.5*(Ask1 + Bid1);
put_mid_price = 0.5*(Ask2 + Bid2);
K=Strike1;
T=2/365;
delta=0.035;
% r=0.0035;
% r=0.00453;
 r=0.006845;
S_t = 85.75;
sigmas=zeros(length(Strike1),1);

%% Implied volatility

%Using put call parity we can calculate the implied forward price from the European call and put prices closest to at-the-money
F = K + exp(1)^(r*T)*(call_mid_price - put_mid_price);

for i=1:length(Strike1)
    syms sigma
    d_1 = (log(F(i)/K(i))+0.5*sigma^2*T)/(sigma*sqrt(T));
    d_2 = d_1 - sigma*sqrt(T);
    eqn = call_mid_price(i) == exp(1)^(-r*T)*(F(i)*normcdf(d_1) - K(i)*normcdf(d_2));
    sigmas(i) = solve(eqn, sigma);


end

% for i=1:length(Strike)
%     syms sigma
%     d_1 = (log(S_t/K(i))+(r-delta+0.5*sigma^2)*T)/(sigma*sqrt(T));
%     d_2 = d_1 - sigma*sqrt(T);
%     eqn = call_mid_price(i) == exp(1)^(-delta*T)*S_t*normcdf(d_1) - exp(1)^(-r*T)*K(i)*normcdf(d_2);
%     sigmas(i) = solve(eqn, sigma)
% end

%% Plot
plot(K,sigmas)
xlabel('Strikes')
ylabel('sigma')
% title('Implied Volatility of XOM for T1=2days')
% title('Implied Volatility of XOM for T2=152days')
 title('Implied Volatility of XOM for T3=429days')