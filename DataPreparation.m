% function [Traffic,Weather]=DataPreparation(T)
function [rain, Traffic1, Traffic2, Traffic3, Traffic4]=DataPreparation(T)

traffic1 = T{:,2};
traffic1 = normalize(traffic1);
M_traffic_Diff = [];
days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= days_in_week+1:length(traffic1)
    value = traffic1(i) - traffic1(i - days_in_week);
    M_traffic_Diff = [M_traffic_Diff; value];
end
Traffic1 = M_traffic_Diff;


traffic2 = T{:,3};
traffic2 = normalize(traffic2);
M_traffic_Diff = [];
days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= days_in_week+1:length(traffic2)
    value = traffic2(i) - traffic2(i - days_in_week);
    M_traffic_Diff = [M_traffic_Diff; value];
end
Traffic2 = M_traffic_Diff;


traffic3 = T{:,4};
traffic3 = normalize(traffic3);
M_traffic_Diff = [];
days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= days_in_week+1:length(traffic3)
    value = traffic3(i) - traffic3(i - days_in_week);
    M_traffic_Diff = [M_traffic_Diff; value];
end
Traffic3 = M_traffic_Diff;

traffic4 = T{:,5};
traffic4 = normalize(traffic4);
M_traffic_Diff = [];
days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= days_in_week+1:length(traffic4)
    value = traffic4(i) - traffic4(i - days_in_week);
    M_traffic_Diff = [M_traffic_Diff; value];
end
Traffic4 = M_traffic_Diff;


rain = T{:,1};
rain = rain(1:(length(Traffic4)-168));
rain = normalize(rain);

end
