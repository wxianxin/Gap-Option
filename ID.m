% Author: Steven Wang    Date:20161120
% XOM option chain data as of 20161116

%% Import data from spreadsheet
% T2
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

%% Initialization
call_mid_price = 0.5*(Ask1 + Bid1);
put_mid_price = 0.5*(Ask2 + Bid2);
K=Strike1;
T=2/365;
delta=0.035;
r=0.005;
S_t = 85.75;
sigmas=zeros(21,1);

%% Implied Distribution
derivative = @(f,x,i) (f(i+1) - f(i))/(x(i+1) - x(i));
first_derivatives = zeros(length(Strike1)-1,1);
second_derivatives = zeros(length(Strike1)-2,1);

for i = 1:length(Strike1)-1
    first_derivatives(i,1) = derivative(call_mid_price,K,i);
end

for i = 1:length(Strike1)-2
    second_derivatives(i) = (first_derivatives(i+1) - first_derivatives(i))/((K(i+1)-K(i))^2);
end


%% Plot
plot(K(1:length(Strike1)-2),second_derivatives)
xlabel('Strikes')
ylabel('sigma')
title('Implied Distribution of XOM based on option prices')

