function signif = Mod_Global_SigTest(power)


% The 95% significant level of every scale
signi = zeros (size (power, 1),1);

powers = zeros (size(power));

% Loop over the scales
for s = 1 : size (power, 1)    
    % Calculate the average power of every scale
    powerAvg  = (sum(power(s, :))/size (power, 2));
    
    signifi= round(size (power, 2) * 0.80);
    power (s, :) = sort (power(s,:));
    
    signi (s) = power(s, signifi);
%     for tt=1:size (power, 2)
%         if(powers(s,tt)>signifi)
%             signi(s) = powers(s, tt);        
%         else 
%             signi(s) = 0;     
%         end
%     end

end

% chi = power(32, :);
% histogram(chi)
%  
% 
% chi = power(16, :);
% histogram(chi)

signif = signi;


