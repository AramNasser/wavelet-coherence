function varargout = xwtFinal(x,y,avg, varargin)
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

% ad=mean(Args.ArrowDensity);
% Args.ArrowSize=Args.ArrowSize*30*.03/ad;
% Args.ArrowHeadSize=Args.ArrowHeadSize*Args.ArrowSize*220;


if strcmpi(Args.AR1,'auto')
    Args.AR1=[ar1nv(x(:,2)) ar1nv(y(:,2))];
    if any(isnan(Args.AR1))
        error('Automatic AR1 estimation failed. Specify them manually (use the arcov or arburg estimators).')
    end
end

%nx=size(x,1);
sigmax=std(x(:,2));

%ny=size(y,1);
sigmay=std(y(:,2));

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

% --Cross
Wxy=X.*conj(Y);
% Wxy = abs (Wxy(1:end-2, :));

sig95 = (avg)'*(ones(1,n)); 
sig95 =  abs(Wxy)./ sig95;

if ~strcmpi(Args.Mother,'morlet')
    sig95(:)=nan;
end

% period = period(1:end-2);
if Args.MakeFigure
    Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));

    H=imagesc(t,log2(period),log2(abs(Wxy/(sigmax*sigmay))));%#ok
    %logpow=log2(abs(Wxy/(sigmax*sigmay)));
    %[c,H]=contourf(t,log2(period),logpow,[min(logpow(:)):.25:max(logpow(:))]);
    %set(H,'linestyle','none')

    clim=get(gca,'clim'); %center color limits around log2(1)=0
    clim=[-1 1]*max(clim(2),3);
    set(gca,'clim',clim)

    HCB=colorbar;
    set(HCB,'ytick',-7:7);
    barylbls=rats(2.^(get(HCB,'ytick')'));
    barylbls([1 end],:)=' ';
    barylbls(:,all(barylbls==' ',1))=[];
    set(HCB,'yticklabel',barylbls);

    set(gca,'YLim',log2([min(period),max(period)]), ...
        'YDir','reverse', ...
        'YTick',log2(Yticks(:)), ...
        'YTickLabel',num2str(Yticks'), ...
        'layer','top')
    %xlabel('Time')
    ylabel('Period')
    hold on

%     aWxy=angle(Wxy);

%     phs_dt=round(length(t)/Args.ArrowDensity(1)); tidx=max(floor(phs_dt/2),1):phs_dt:length(t);
%     phs_dp=round(length(period)/Args.ArrowDensity(2)); pidx=max(floor(phs_dp/2),1):phs_dp:length(period);
%     phaseplot(t(tidx),log2(period(pidx)),aWxy(pidx,tidx),Args.ArrowSize,Args.ArrowHeadSize);

    if strcmpi(Args.Mother,'morlet')
        [c,h] = contour(t,log2(period),sig95,[1 1],'k');%#ok
        set(h,'linewidth',2)
    else
        warning('XWT:sigLevelNotValid','XWT Significance level calculation is only valid for morlet wavelet.')
        %TODO: alternatively load from same file as wtc (needs to be coded!)
    end
    tt=[t([1 1])-dt*.5;t;t([end end])+dt*.5];
    hcoi=fill(tt,log2([period([end 1]) coi period([1 end])]),'w');
    set(hcoi,'alphadatamapping','direct','facealpha',.5)
    hold off
end

varargout={Wxy,period,scale,coi,sig95};
varargout=varargout(1:nargout);
