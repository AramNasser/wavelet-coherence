
%% Load the data
% First we load the two time series into the matrices d1 and d2.
seriesname={'Traffic' 'Rain'};

[signi, Rsigni, Tsigni] = SigCalcu();

T = readtable('Rain_MNPLS_Crystal_WT2.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
xwtFinal (T{:,1}, T{:,2}, signi);
% 
% figure
% wtFinal (Rain, Rsigni);

% figure
% wtFinal (Traffic, Tsigni);



