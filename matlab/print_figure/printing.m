%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function figs=printing(varargin)
    if nargin == 9
        figs=printing_1(varargin{:},10^-50);
    elseif nargin == 10
        figs=printing_1(varargin{:});
    elseif nargin == 11
        figs=printing_2(varargin{:});
    elseif nargin == 5
        figs=printing_one(varargin{:},10^-50);
    elseif nargin == 6
        figs=printing_one(varargin{:});
    elseif nargin == 7
        figs=printing_one_2(varargin{:});
    end
end

function conf_fig()
%% 
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
end

function figs=printing_1(x1,f1,v1,s1,x2,f2,v2,s2,nb_variable,tolerance)
    global name_variable
    conf_fig()
    
    %%%%% Simplest figure
    figs(1)=figure('Name','v_e vs v_i','NumberTitle','off');
    cpl(x1,v1,s1,[1 2]);
    cpl(x2,v2,s2,[1 2]);
    title('v_e vs v_i')
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    figs(end+1)=figure('Name','p vs v_e','NumberTitle','off');
    cpl(x1,v1,s1,[6 1]);
    cpl(x2,v2,s2,[6 1]);
    title('p vs v_e')
    xlabel(name_variable(nb_variable))
    ylabel('v_e in kHz')
    figs(end+1)=figure('Name','p vs v_i','NumberTitle','off');
    cpl(x1,v1,s1,[6 2]);
    cpl(x2,v2,s2,[6 2]);
    title('p vs v_i')
    xlabel(name_variable(nb_variable))
    ylabel('v_i in kHz')
       
    
%     %%%%%%%% Plot eigenvalue 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     for i =1:5
%         figs(3+i*4-3)=figure('Name','eig '+string(i),'NumberTitle','off');
%         cpl([real(f1);imag(f1)],[v1;v1],s1,[i i+7]);
%         cpl([real(f2);imag(f2)],[v2;v2],s2,[i i+7]);
%         title('eig '+string(i))
%         xlabel('Real')
%         ylabel('Imaginar')
%         figs(3+i*4-2)=figure('Name','real eig '+string(i),'NumberTitle','off');
%         cpl([real(f1);x1],[x1;x1],s1,[i 11]);
%         cpl([real(f2);x2],[x2;x2],s2,[i 11]);
%         title('p vs real eig '+string(i))
%         xlabel(name_variable(nb_variable))
%         ylabel('Real')
%         figs(3+i*4-1)=figure('Name','imag eig '+string(i),'NumberTitle','off');
%         cpl([imag(f1);x1],[x1;x1],s1,[i 11]);
%         cpl([imag(f2);x2],[x2;x2],s2,[i 11]);
%         title('p vs Imaginar eig '+string(i))
%         xlabel(name_variable(nb_variable))
%         ylabel('Imaginar')
%         figs(3+i*4)=figure('Name','imag eig '+string(i)+'and p','NumberTitle','off');
%         cpl([real(f1);imag(f1);x1],[v1;v1;v1],s1,[i i+7 16]);
%         cpl([real(f2);imag(f2);x2],[v2;v2;v2],s2,[i i+7 16]);
%         title('eig '+string(i)+' and p')
%         xlabel('real')
%         ylabel('Imaginar')
%         zlabel(name_variable(nb_variable))
%     end

    %% stability figures
    figs(end+1)=figure('Name','v_e vs v_i','NumberTitle','off');
    print_stability(x1, f1, s1, 1,2,tolerance)
    print_stability(x2, f2, s2, 1,2,tolerance)
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    figs(end+1)=figure('Name','v_e vs p','NumberTitle','off');
    print_stability(x1, f1, s1, 1,6,tolerance)
    print_stability(x2, f2, s2, 1,6,tolerance)
    xlabel('v_e in KHz')
    ylabel(name_variable(nb_variable))
    figs(end+1)=figure('Name','p vs v_i','NumberTitle','off');
    print_stability(x1, f1, s1, 2,6,tolerance)
    print_stability(x2, f2, s2, 2,6,tolerance)
    xlabel('v_i in KHz')
    ylabel(name_variable(nb_variable))
end

function figs=printing_2(x1,f1,v1,s1,x2,f2,v2,s2,first_parameter,nb_variable,tolerance)
    global name_variable
    figs=printing(x1,f1,v1,s1,x2,f2,v2,s2,first_parameter,tolerance);

    figs(end+1)=figure('Name','p2 vs v_e','NumberTitle','off');
    cpl(x1,v1,s1,[7 1]);
    cpl(x2,v2,s2,[7 1]);
    title('p2 vs v_e')
    xlabel(name_variable(nb_variable))
    ylabel('v_e in kHz')
    figs(end+1)=figure('Name','p2 vs v_i','NumberTitle','off');
    cpl(x1,v1,s1,[7 2]);
    cpl(x2,v2,s2,[7 2]);
    title('p2 vs v_i')
    xlabel(name_variable(nb_variable))
    ylabel('v_i in kHz')
    figs(end+1)=figure('Name','p1 vs p2','NumberTitle','off');
    cpl(x1,v1,s1,[6 7]);
    cpl(x2,v2,s2,[6 7]);
    title('p1 vs p2')
    xlabel(name_variable(first_parameter))
    ylabel(name_variable(nb_variable))
    %% stability figures
    figs(end+1)=figure('Name','v_e vs p2','NumberTitle','off');
    print_stability(x1, f1, s1, 1,7,tolerance)
    print_stability(x2, f2, s2, 1,7,tolerance)
    xlabel('v_e in KHz')
    ylabel(name_variable(nb_variable))
    figs(end+1)=figure('Name','p2 vs v_i','NumberTitle','off');
    print_stability(x1, f1, s1, 2,7,tolerance)
    print_stability(x2, f2, s2, 2,7,tolerance)
    xlabel('v_i in KHz')
    ylabel(name_variable(nb_variable))
    figs(end+1)=figure('Name','p vs p2','NumberTitle','off');
    print_stability(x1, f1, s1, 6,7,tolerance)
    print_stability(x2, f2, s2, 6,7,tolerance)
    xlabel(name_variable(first_parameter))
    ylabel(name_variable(nb_variable))
end
    
function figs=printing_one(x,f,v,s,nb_variable,tolerance)
    global name_variable
    conf_fig()
    
    %%%%% Simplest figure
    figs(1)=figure('Name','v_e vs v_i','NumberTitle','off');
    cpl(x,v,s,[1 2]);
    title('v_e vs v_i')
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    figs(end+1)=figure('Name','p vs v_e','NumberTitle','off');
    cpl(x,v,s,[6 1]);
    title('p vs v_e')
    xlabel(name_variable(nb_variable))
    ylabel('v_e in kHz')
    figs(end+1)=figure('Name','p vs v_i','NumberTitle','off');
    cpl(x,v,s,[6 2]);
    title('p vs v_i')
    xlabel(name_variable(nb_variable))
    ylabel('v_i in kHz')
       
    
%     %%%%%%%% Plot eigenvalue 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     for i =1:5
%         figs(3+i*4-3)=figure('Name','eig '+string(i),'NumberTitle','off');
%         cpl([real(f);imag(f)],[v;v],s,[i i+7]);
%         title('eig '+string(i))
%         xlabel('Real')
%         ylabel('Imaginar')
%         figs(3+i*4-2)=figure('Name','real eig '+string(i),'NumberTitle','off');
%         cpl([real(f);x],[x;x],s,[i 11]);
%         title('p vs real eig '+string(i))
%         xlabel(name_variable(nb_variable))
%         ylabel('Real')
%         figs(3+i*4-1)=figure('Name','imag eig '+string(i),'NumberTitle','off');
%         cpl([imag(f);x],[x;x],s,[i 11]);
%         title('p vs Imaginar eig '+string(i))
%         xlabel(name_variable(nb_variable))
%         ylabel('Imaginar')
%         figs(3+i*4)=figure('Name','imag eig '+string(i)+'and p','NumberTitle','off');
%         cpl([real(f);imag(f);x],[v;v;v],s,[i i+7 16]);
%         title('eig '+string(i)+' and p')
%         xlabel('real')
%         ylabel('Imaginar')
%         zlabel(name_variable(nb_variable))
%     end

    %% stability figures
    figs(end+1)=figure('Name','v_e vs v_i','NumberTitle','off');
    print_stability(x, f, s, 1,2,tolerance)
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    figs(end+1)=figure('Name','v_e vs p','NumberTitle','off');
    print_stability(x, f, s, 1,6,tolerance)
    xlabel('v_e in KHz')
    ylabel(name_variable(nb_variable))
    figs(end+1)=figure('Name','p vs v_i','NumberTitle','off');
    print_stability(x, f, s, 2,6,tolerance)
    xlabel('v_i in KHz')
    ylabel(name_variable(nb_variable))
end

function figs=printing_one_2(x,f,v,s,first_parameter,nb_variable,tolerance)
    global name_variable
    figs=printing_one(x,f,v,s,first_parameter,tolerance);

    figs(end+1)=figure('Name','p2 vs v_e','NumberTitle','off');
    cpl(x,v,s,[7 1]);
    title('p2 vs v_e')
    xlabel(name_variable(nb_variable))
    ylabel('v_e in kHz')
    figs(end+1)=figure('Name','p2 vs v_i','NumberTitle','off');
    cpl(x,v,s,[7 2]);
    title('p2 vs v_i')
    xlabel(name_variable(nb_variable))
    ylabel('v_i in kHz')
    figs(end+1)=figure('Name','p1 vs p2','NumberTitle','off');
    cpl(x,v,s,[6 7]);
    title('p1 vs p2')
    xlabel(name_variable(first_parameter))
    ylabel(name_variable(nb_variable))
    %% stability figures
    figs(end+1)=figure('Name','v_e vs p2','NumberTitle','off');
    print_stability(x, f, s, 1,7,tolerance)
    xlabel('v_e in KHz')
    ylabel(name_variable(nb_variable))
    figs(end+1)=figure('Name','p2 vs v_i','NumberTitle','off');
    print_stability(x, f, s, 2,7,tolerance)
    xlabel('v_i in KHz')
    ylabel(name_variable(nb_variable))
    figs(end+1)=figure('Name','p vs p2','NumberTitle','off');
    print_stability(x, f, s,6,7,tolerance)
    xlabel(name_variable(first_parameter))
    ylabel(name_variable(nb_variable))
end