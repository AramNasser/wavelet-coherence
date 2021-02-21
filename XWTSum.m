function [avg, Wxy] = XWTSum(x,y,varargin)

% ------validate and reformat timeseries.
[x,dt]=formatts(x);
[y,dty]=formatts(y);
if dt~=dty
    error('timestep must be equal between time series')
end
t=(max(x(1,1),y(1,1)):dt:min(x(end,1),y(end,1)))'; %common time period
if length(t)<4
    error('The two time series must overlap.')
end
n=length(t);
%----------default arguments for the wavelet transform-----------
Args=struct('Pad',1,...      % pad the time series with zeroes (recommended)
    'Dj',1/12, ...    % this will do 12 sub-octaves per octave
    'S0',2*dt,...    % this says start at a scale of 2 years
    'J1',[],...
    'Mother','Morlet', ...
    'MaxScale',[],...   %a more simple way to specify J1
    'MakeFigure',(nargout==0),...
    'AR1','auto',...
    'ArrowDensity',[30 30],...
    'ArrowSize',1,...
    'ArrowHeadSize',1);
Args=parseArgs(varargin,Args,{'BlackandWhite'});
if isempty(Args.J1)
    if isempty(Args.MaxScale)
        Args.MaxScale=(n*.17)*2*dt; %auto maxscale
    end
    Args.J1=round(log2(Args.MaxScale/Args.S0)/Args.Dj);
end


if strcmpi(Args.AR1,'auto')
    Args.AR1=[ar1nv(x(:,2)) ar1nv(y(:,2))];
    if any(isnan(Args.AR1))
        error('Automatic AR1 estimation failed. Specify them manually (use the arcov or arburg estimators).')
    end
end

%-----------:::::::::::::--------- ANALYZE ----------::::::::::::------------
[X,period,scale] = wavelet(x(:,2),dt,Args.Pad,Args.Dj,Args.S0,Args.J1,Args.Mother);%#ok
[Y,period,scale] = wavelet(y(:,2),dt,Args.Pad,Args.Dj,Args.S0,Args.J1,Args.Mother);


% --Cross
Wxy=X.*conj(Y);

WxySum = zeros (size (Wxy, 1),1);

TimePoints = size (power, 2);
for s = 1 : size (Wxy, 1)    
    % Calculate the average power of every scale
    WxySum(s) = abs((sum(Wxy(s, :))./TimePoints));
end
 
avg = WxySum;
