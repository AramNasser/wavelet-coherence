function signif = Mod_Global_Sig(power)

% The average power of every scale
powerAvg = zeros (size (power, 1),1);

% The 95% significant level of every scale
signi = zeros (size (power, 1),1);

% Loop over the scales
for s = 1 : size (power, 1)
    
    % Calculate the average power of every scale
    powerAvg (s) = (sum(power(s, :))/size (power, 2));
    
    % Sort the powers ascendingly
    powerSig = sort(power(s, :));
    
    b = round (size (power, 2) * 0.80);
    
    % The 90% significant value: 
    a = powerSig (b);
    
    % if the 90% significant value is larger that the average power  
    if powerAvg (s)< a
        % assign it as the significant final value
        signi (s) = a;
    else 
        % Otherwise, the average power is the significant final value
        signi (s) = powerAvg (s);
    end
end

signif = signi;


