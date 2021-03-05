
function [Rain, Traffic] = DataPreparation(rain, traffic)

rain = rain (1:2195);
traffic = traffic (1:2195);

% Get normalized traffic data
traffic = normalize(traffic);
M_traffic_Diff = [];

days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= days_in_week+1:length(traffic)
    value = traffic(i) - traffic(i - days_in_week);
    M_traffic_Diff = [M_traffic_Diff; value];
end
Traffic = M_traffic_Diff;

% Get rain data
Rain = rain(1:(length(Traffic)));
% Rain = normalize(Rain);
% histogram(Rain)

end