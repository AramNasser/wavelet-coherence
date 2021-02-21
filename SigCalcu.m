function sig = SigCalcu(data,s, varargin)


signifi= round(size (data, 2) * 0.9);

    
dataAvg (s, :) = sort (data(s,:));

%     
    signi (s) = dataAvg(s, signifi);

%     
    signi(s) = signi (s)./7;

    
end

