function res = plotcycle_modify(x,s,e,increment)
%
% res = plotcycle(x,v,s,e)
%
% This function plots the cycles x. e is an array which defines 
% which coordinates of the differential equation should be used.
% This must be two or three dimensional.
%
global lds

watchon;
%%%%%%% Default parameter for the figure
set(groot,'defaultAxesFontSize',25)
set(groot,'defaultTextFontSize',25)
set(groot,'defaultLineLineWidth',2)
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')
x0=10;
y0=10;
width=1550;
height=1400;
set(groot,'defaultFigureUnits','points')
set(groot,'defaultFigurePosition',[x0,y0,width,height])


if length(e)==2
    
    p=plot(x(e(1),1),x(e(2),1),'-',x(e(1),1),x(e(2),1),'*');
    hold on;
    xmin = min(min(x((0:lds.tps-1)*lds.nphase+1,:)));
    xmax = max(max(x((0:lds.tps-1)*lds.nphase+1,:)));
    ymin = min(min(x((0:lds.tps-1)*lds.nphase+2,:)));
    ymax = max(max(x((0:lds.tps-1)*lds.nphase+2,:)));
    axis([xmin xmax ymin ymax]);
 %   xlabel('x(1)');
 %   ylabel('x(2)');
 %   pause(0.1);
    for j=1:increment:size(x,2)
        plot(x((0:lds.tps-1)*lds.nphase+1,j),x((0:lds.tps-1)*lds.nphase+2,j),'b.-');
    end
    for j=[s.index]
        plot(x((0:lds.tps-1)*lds.nphase+1,j),x((0:lds.tps-1)*lds.nphase+2,j),'r-');
    end
  %  for j=1:size(x,1)/lds.nphase
  %      plot(x((j-1)*lds.nphase+1,:),x((j-1)*lds.nphase+2,:),':');
  %  end
    hold off;
else
    p=plot3(x(e(1),1),x(e(2),1),x(e(3),1),'-');
    hold on;
    xmin = min(x(e(1),:));
    xmax = max(x(e(1),:));
    ymin = min(min(x((0:lds.tps-1)*lds.nphase+e(2),:)));
    ymax = max(max(x((0:lds.tps-1)*lds.nphase+e(2),:)));
    zmin = min(min(x((0:lds.tps-1)*lds.nphase+e(3),:)));
    zmax = max(max(x((0:lds.tps-1)*lds.nphase+e(3),:)));
    axis([xmin xmax ymin ymax zmin zmax]);
    for j=1:increment:size(x,2)
        plot3(x(e(1),j)*ones(lds.tps,1),x((0:lds.tps-1)*lds.nphase+e(2),j),x((0:lds.tps-1)*lds.nphase+e(3),j),'b.-');
    end
    for j=[s.index]
        plot3(x(e(1),j)*ones(lds.tps,1),x((0:lds.tps-1)*lds.nphase+e(2),j),x((0:lds.tps-1)*lds.nphase+e(3),j),'r.-');
    end
 %   for j=1:size(x,1)/lds.nphase
 %       plot3(x(e(1),:),x((j-1)*lds.nphase+e(2),:),x((j-1)*lds.nphase+e(3),:),':');
 %   end
    hold off;
end
res = p;
watchoff;
