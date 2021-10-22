function print_period_parameter(name,x1,v1,s1)
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

    %%%%% Simplest figure
    f(1)=figure('Name',name,'NumberTitle','off');
    cpl(x1,v1,s1,[size(x1,1), size(x1,1)-1])
    title('v_e vs v_i')
    ylabel('period in ms')
    xlabel("parameter "+name)
end
