% function [Traffic,Weather]=DataPreparation(T)
function [Traffic, temperature, windSpeed, rain, visibility]=DataPreparation(T)

traffic = T{:,1};
traffic = normalize(traffic);

M_traffic_Diff = [];
days_in_week = 168; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= days_in_week+1:length(traffic)
    value = traffic(i) - traffic(i - days_in_week);
    M_traffic_Diff = [M_traffic_Diff; value];
end
Traffic = M_traffic_Diff;
% figure()
% plot(traffic)

temperature = T{:,2};
M_temperature_Diff = [];
hours_in_day = 24; %days_in_week = 168; % 7 days:  168 = 7 * 24
for i= hours_in_day + 1: length(temperature)
    value = temperature(i) - temperature(i - hours_in_day);
    M_temperature_Diff = [M_temperature_Diff; value];
end
temperature = M_temperature_Diff;
temperature = temperature(1:(length(temperature)-168 + 24));
temperature = normalize(temperature);
% figure()
% plot(temperature)

windSpeed = T{:,3};
windSpeed = windSpeed(1:(length(windSpeed)-168));
windSpeed = normalize(windSpeed);
% figure()
% plot(windSpeed)

rain = T{:,4};
rain = rain(1:(length(rain)-168));
rain = normalize(rain);
% figure()
% plot(rain)

visibility = T{:,5};
visibility = visibility(1:(length(visibility)-168));
visibility = normalize(visibility);
% figure()
% plot(visibility)

% Weather = temperature;
end
