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
seriesname={'Traffic' 'windSpeed'};

T = readtable('0All.csv');

[Traffic, temperature, windSpeed, rain, visibility] = DataPreparation(T);

%% Continuous wavelet transform (CWT)
% The CWT expands the time series into time
% frequency space.

figure('color',[1 1 1])
tlim=[min(Traffic(1,1),rain(1,1)) max(Traffic(end,1),rain(end,1))];
subplot(2,1,1);
wt(Traffic);
title(seriesname{1});
set(gca,'xlim',tlim);
subplot(2,1,2)
wt(rain)
title(seriesname{2})
set(gca,'xlim',tlim)


%% Cross wavelet transform (XWT)
% The XWT finds regions in time frequency space where
% the time series show high common power.

figure('color',[1 1 1])
xwt(d1,d2)
title(['XWT: ' seriesname{1} '-' seriesname{2} ] )

%% Wavelet coherence (WTC)
% The WTC finds regions in time frequency space where the two
% time series co-vary (but does not necessarily have high power).


figure('color',[1 1 1])
wtc(d1,d2)
title(['WTC: ' seriesname{1} '-' seriesname{2} ] )



