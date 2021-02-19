function varargout=xwt(x,y,varargin)

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

[X,period,scale,coix] = wavelet(x(:,2),dt,Args.Pad,Args.Dj,Args.S0,Args.J1,Args.Mother);%#ok
[Y,period,scale,coiy] = wavelet(y(:,2),dt,Args.Pad,Args.Dj,Args.S0,Args.J1,Args.Mother);

% truncate X,Y to common time interval (this is first done here so that the coi is minimized)
dte=dt*.01; %to cricumvent round off errors with fractional timesteps
idx=find((x(:,1)>=(t(1)-dte))&(x(:,1)<=(t(end)+dte)));
X=X(:,idx);
coix=coix(idx);

idx=find((y(:,1)>=(t(1)-dte))&(y(:,1)<=(t(end)+dte)));
Y=Y(:,idx);
coiy=coiy(idx);

coi=min(coix,coiy);

% -------- Cross
Wxy=X.*conj(Y);

% varargout={Wxy,period,scale,coi,sig95};
varargout={Wxy,period,scale,coi};
varargout=varargout(1:nargout);
