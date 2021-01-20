function signif = Mod_Global_Sig(power)

% The average power of every scale
powerAvg = zeros (size (power, 1),1);

% The 95% significant level of every scale
signi = zeros (size (power, 1),1);

% Loop over the scales
for s = 1 : size (power, 1)
    
    % Calculate the average power of every scale
    powerAvg (s) = (sum(power(s, :))/size (power, 2));
    
    powerSig = sort(power(s, :));
    
    a = powerSig (end - 100);
    if powerAvg (s)< a
        signi (s) = a;
    else 
        signi (s) = powerAvg (s);
    end
end

signif = signi;


