function [signi, Rsigni, Tsigni] = SigCalcu(varargin)

[rain1, traffic1, Wxy1] = GetData('MINNEAPOLIS_WT1.csv');
[rain2, traffic2, Wxy2] = GetData('MINNEAPOLIS_WT2.csv');
[rain3, traffic3, Wxy3] = GetData('MINNEAPOLIS_WT3.csv');
[rain4, traffic4, Wxy4] = GetData('MINNEAPOLIS_WT4.csv');
[rain5, traffic5, Wxy5] = GetData('Rain_MNPLS_Crystal_WT1.csv');
[rain6, traffic6, Wxy6] = GetData('Rain_MNPLS_Crystal_WT2.csv');
[rain7, traffic7, Wxy7] = GetData('STP st. paul_ with Traffic.csv');

signifi= round(size (Wxy1, 2) * 0.9);

for s = 1 : size (Wxy1, 1)    
    for t = 1 : size (Wxy1, 2) 
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

end

