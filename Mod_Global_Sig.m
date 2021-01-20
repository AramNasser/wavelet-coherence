function signif = Mod_Global_Sig(variance, power)

scale = size (power, 1);
scale_Gpower = zeros (scale,1);
j = 0;
for s = 1:scale
    for t = 1:  size (power, 2)
        if power (s, t) ==0
            j = j+1;
        end
    end
    
    k = find (power(s, :));
    scale_size = length (k);
    scale_Gpower (s) = (sum(power(s, :))/scale_size);
    
    if j~=0
        j=0;
    end
end

signif = scale_Gpower;
% for s = 1:scale
%     for t = 1:time
%         if power(s, t) ~=0
%             P_scale(s) = P_scale(s) +  power(s, t); 
%         end        
%     end
%     
%     n = n+1;
% %     ave
% end

