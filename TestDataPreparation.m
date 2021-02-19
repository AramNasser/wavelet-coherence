
function [rain1, traffic1, traffic2, traffic3, traffic4] =TestDataPreparation(T)

traffic1 = trafficDiff(T{:,2});
traffic2 = trafficDiff(T{:,3});
traffic3 = trafficDiff(T{:,4});
traffic4 = trafficDiff(T{:,5});

rain1 = T{:,1};
% Get rain data
rain1 = rain1(1:(length(traffic1)));
rain1 = normalize(rain1);

end
