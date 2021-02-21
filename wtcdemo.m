
%% Load the data
% First we load the two time series into the matrices d1 and d2.
seriesname={'Traffic' 'Rain'};

T = readtable('MINNEAPOLIS_WT1.csv');
% [avg1, Wxy1] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});

T = readtable('MINNEAPOLIS_WT2.csv');
% [avg2, Wxy2] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});

T = readtable('MINNEAPOLIS_WT3.csv');
% [avg3, Wxy3] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});

T = readtable('MINNEAPOLIS_WT4.csv');
% [avg4, Wxy4] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});

T = readtable('Rain_MNPLS_Crystal_WT1.csv');
% [avg5, Wxy5] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});

T = readtable('Rain_MNPLS_Crystal_WT2.csv');
% [avg6, Wxy6] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});

T = readtable('STP st. paul_ with Traffic.csv');
% [avg7, Wxy7] = XWTavg(T{:,1}, T{:,2});
xwt(T{:,1}, T{:,2});
