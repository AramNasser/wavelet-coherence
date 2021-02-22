function [rain, traffic, Wxy] = GetData(FileName)

T = readtable(FileName);
[Rain, Traffic] = DataPreparation(T{:,1}, T{:,2});
rain = wtOnly(Rain);
traffic = wtOnly(Traffic);
Wxy = xwtOnly(Rain, Traffic);


end