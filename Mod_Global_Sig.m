function signif = Mod_Global_Sig(power)

% The average power of every scale
powerAvg = 0;

% The 95% significant level of every scale
signi = zeros (size (power, 1),1);

powers = zeros (size(power));

zeroValues = 0;

Values = 0;
% Loop over the scales
for s = 1 : size (power, 1)    
    % Calculate the average power of every scale
    powerAvg  = (sum(power(s, :))/size (power, 2));
    
    for t=1:size (power, 2)
        if power(s,t)> powerAvg
            powers(s, t) = power(s, t);
            Values = Values + 1;
        else 
            powers(s, t) = 0;
            zeroValues =  zeroValues +1;
        end
    end
    
    signifi= round(Values * 0.8);
    powers (s, :) = sort (powers(s,:));
    
    for tt=1:size (power, 2)
        if(powers(s,tt)~=0)
            signi(s) = powers(s, tt + signifi);
            break;
        end
    end
%     signi (s) = powers(s, end - signifi);
    
    Values = 0;
    zeroValues = 0;
end
    

signif = signi;


