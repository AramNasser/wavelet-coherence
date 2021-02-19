%% Demo of the cross wavelet and wavelet coherence toolbox 
% This example illustrates how simple it is to do
% continuous wavelet transform (CWT), Cross wavelet transform (XWT)
% and Wavelet Coherence (WTC) plots of your own data.
%
% The time series we will be analyzing are the winter
% Arctic Oscillation index (AO) and
% the maximum sea ice extent in the Baltic (BMI).
%


%% Load the data
% First we load the two time series into the matrices d1 and d2.
seriesname={'Traffic' 'Rain'};

T = readtable('MINNEAPOLIS_WithTraffic.csv');

[rain, traffic1, traffic2, traffic3, traffic4] = DataPreparation(T);


sum1  = xwt(rain,T{:, 2});

sum2  = xwt(rain,traffic2);

sum3  = xwt(rain,traffic3);
