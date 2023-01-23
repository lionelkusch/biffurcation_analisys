%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
%%
%%%%% Plotting script.  x=continuation info  f=eigenvalues %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function print_stability(xeqcurve,minevaleq,s,axis_x,axis_y,tolerance)
    L=length(xeqcurve(1,:));

    curveind=1;
    real_min = real(minevaleq(:,1));
    real_min(abs(real_min)<tolerance ) = 0;
    evalstart=floor(sum(heaviside(real_min)));
%     evalstart=floor(sum(heaviside(real(minevaleq(:,1)))));
    datamateq=zeros(4,L);

    for i=1:L
        real_min = real(minevaleq(:,i));
        real_min(abs(real_min)<tolerance ) = 0;
        evalind=floor(sum(heaviside(real_min)));
%         evalind=floor(sum(heaviside(real(minevaleq(:,i)))));
        if evalstart~=evalind
            curveind=curveind+1;
            evalstart=evalind;
        end
        datamateq(1,i)=xeqcurve(axis_x,i); % This is the parameter that is varied.
        datamateq(2,i)=xeqcurve(axis_y,i); % This is the dependent axis of the bifurcation plot.  The one you wish to plot
        datamateq(3,i)=evalind;
        datamateq(4,i)=curveind;  
    end

    curveindeq=curveind;
    curveeq={};
    for i=1:curveindeq
        index=find(datamateq(4,:)==i);
        curveeq{i}=datamateq(1:3,index);
    end

    for i=1:curveindeq
        stability=curveeq{i}(3,1);
        if stability==0 
            plotsty='';
            plotcolor='k';
        else
            plotsty='--';
            c=['b','g','m','c','y','r'];
            plotcolor=c(mod(stability,6));
        end

        plotstr=strcat(plotcolor,plotsty);

        plot(curveeq{i}(1,:),curveeq{i}(2,:),plotstr,'Linewidth',4)
        hold on
    end

    xindex=cat(1,s.index);
    xindex=xindex(2:end-1);
    line(xeqcurve(axis_x,xindex),xeqcurve(axis_y,xindex),'linestyle','none', 'marker', 'x','color','r','Linewidth',2);
    d=axis;
    if size(s,1)~=2
        skew = 0.03*[d(2)-d(1) d(4)-d(3)];
        s(1).label=''; s(end).label=''; 
        text( xeqcurve(axis_x,xindex)+skew(1),xeqcurve(axis_y,xindex)+skew(2), {s(2:end-1).label},'Linewidth',4);
    end
end