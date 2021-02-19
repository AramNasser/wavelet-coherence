
%% Load the data
% First we load the two time series into the matrices d1 and d2.
seriesname={'Traffic' 'Rain'};

T = readtable('MINNEAPOLIS.csv');

[rain1, traffic1, traffic2, traffic3, traffic4] = TestDataPreparation(T);

sum1 = XWTSum(rain1, traffic1);
sum2 = XWTSum(rain1, traffic2);

% sum = zeros(102, 1);
% for i = 1 : 4
%     %% Cross wavelet transform (XWT)
%     [Rain, Traffic] = DataPreparation(T{:, 1}, T{:, i+1});
%     sum = sum + XWTSum(Rain, Traffic);
% end


% sum = DataPreparation(T{:,1}, T{:,2});

% sum = zeros(102, 1);
% for i = 1 : 4
%     %% Cross wavelet transform (XWT)
%     [Rain, Traffic] = DataPreparation(T{:, 1}, T{:, i+1});
%     sum = sum + XWTSum(Rain, Traffic);
% end

T = readtable('Rain_MNPLS_Crystal_WithTraffic.csv');

for i=1 : 2
    %% Cross wavelet transform (XWT)
    [Rain, Traffic] = DataPreparation(T{:,1}, T{:,i+1});
    sum = sum + XWTSum(Rain, Traffic);
end

T = readtable('STP st. paul_ with Traffic.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
sum = sum + XWTSum(Rain, Traffic);

average = sum / size (Traffic);
