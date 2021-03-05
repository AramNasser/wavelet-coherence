
%% Load the data
% First we load the two time series into the matrices d1 and d2.
seriesname={'Traffic' 'Rain'};

% [signi, Rsigni, Tsigni] = SigCalcu();
signi = SigCalcu();

T = readtable('MINNEAPOLIS_WT4.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
xwtFinal (Rain, Traffic, signi);
% 
% figure
% wtFinal (Rain, Rsigni);

% figure
% wtFinal (Traffic, Tsigni);



