
%% Load the data
% First we load the two time series into the matrices d1 and d2.
seriesname={'Traffic' 'Rain'};

T = readtable('MINNEAPOLIS_WT1.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
rain1 = wtOnly(Rain);
traffic1 = wtOnly(Traffic);
Wxy1 = XWTSum(Rain, Traffic);


T = readtable('MINNEAPOLIS_WT2.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
rain2 = wtOnly(Rain);
traffic2 = wtOnly(Traffic);
Wxy2 = XWTSum(Rain, Traffic);

T = readtable('MINNEAPOLIS_WT3.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
rain3 = wtOnly(Rain);
traffic3 = wtOnly(Traffic);
Wxy3 = XWTSum(Rain, Traffic);

T = readtable('MINNEAPOLIS_WT4.csv');
rain4 = wtOnly(Rain);
traffic4 = wtOnly(Traffic);
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
Wxy4 = XWTSum(Rain, Traffic);

T = readtable('Rain_MNPLS_Crystal_WT1.csv');
rain5 = wtOnly(Rain);
traffic5 = wtOnly(Traffic);
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
Wxy5 = XWTSum(Rain, Traffic);

T = readtable('Rain_MNPLS_Crystal_WT2.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
rain6 = wtOnly(Rain);
traffic6 = wtOnly(Traffic);
Wxy6 = XWTSum(Rain, Traffic);

T = readtable('STP st. paul_ with Traffic.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
rain7 = wtOnly(Rain);
traffic7 = wtOnly(Traffic);
Wxy7 = XWTSum(Rain, Traffic);

signifi= round(size (xwtavg, 2) * 0.9);

for s = 1 : size (Wxy7, 1)    
    for t = 1 : size (Wxy7, 2) 
        xwtavg(s, t) = (Wxy1(s, t) + Wxy2(s, t) + Wxy3(s, t) + Wxy4(s, t) + Wxy5(s, t) + Wxy6(s, t) + Wxy7(s, t));  
        RCwtavg(s, t) = (rain1(s, t) + rain2(s, t) + rain3(s, t) + rain4(s, t) + rain5(s, t) + rain6(s, t) + rain7(s, t));  
        TCwtavg(s, t) = (traffic1(s, t) + traffic2(s, t) + traffic3(s, t) + traffic4(s, t) + traffic5(s, t) + traffic6(s, t) + traffic7(s, t));  
    end

%   Cross wavelet signigicance
    xwtavg (s, :) = sort (xwtavg(s,:));
    signi (s) = (xwtavg(s, signifi))./7;
    
%   Rain signigicance
    RCwtavg (s, :) = sort (RCwtavg(s,:));
    Rsigni (s) = (RCwtavg(s, signifi))./7;
    
%   Traffic signigicance
    TCwtavg (s, :) = sort (TCwtavg(s,:));
    Tsigni (s) = (TCwtavg(s, signifi))./7;
end

T = readtable('MINNEAPOLIS_WT1.csv');
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
xwtFinal (Rain, Traffic, signi);

figure
wtFinal (Rain, Rsigni);

figure
wtFinal (Traffic, Tsigni);



