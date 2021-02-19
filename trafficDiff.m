function M_traffic_Diff = trafficDiff(traffic)

% Get normalized traffic data
traffic = normalize(traffic);

Traffic = [];
days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24

for i= days_in_week+1:length(traffic)
    value = traffic(i) - traffic(i - days_in_week);
    Traffic = [Traffic; value];
end

M_traffic_Diff = Traffic;


end
