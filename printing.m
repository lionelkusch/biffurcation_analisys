function f=printing(varargin)
    if nargin == 9
        f=printing_1(varargin{:});
    elseif nargin == 10
        f=printing_2(varargin{:});
    end
end     

function f=printing_1(x1,f1,v1,s1,x2,f2,v2,s2,nb_variable)
    global name_variable
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
    
    
    %%%%% Simplest figure
    f(1)=figure('Name','v_e vs v_i','NumberTitle','off');
    cpl(x1,v1,s1,[1 2]);
    cpl(x2,v2,s2,[1 2]);
    title('v_e vs v_i')
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    f(end+1)=figure('Name','p vs v_e','NumberTitle','off');
    cpl(x1,v1,s1,[7 1]);
    cpl(x2,v2,s2,[7 1]);
    title('p vs v_e')
    xlabel(name_variable(nb_variable))
    ylabel('v_e in kHz')
    f(end+1)=figure('Name','p vs v_i','NumberTitle','off');
    cpl(x1,v1,s1,[7 2]);
    cpl(x2,v2,s2,[7 2]);
    title('p vs v_i')
    xlabel(name_variable(nb_variable))
    ylabel('v_i in kHz')
       
    
%     %%%%%%%% Plot eigenvalue 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     for i =1:5
%         f(3+i*4-3)=figure('Name','eig '+string(i),'NumberTitle','off');
%         cpl([real(f1);imag(f1)],[v1;v1],s1,[i i+7]);
%         cpl([real(f2);imag(f2)],[v2;v2],s2,[i i+7]);
%         title('eig '+string(i))
%         xlabel('Real')
%         ylabel('Imaginar')
%         f(3+i*4-2)=figure('Name','real eig '+string(i),'NumberTitle','off');
%         cpl([real(f1);x1],[x1;x1],s1,[i 11]);
%         cpl([real(f2);x2],[x2;x2],s2,[i 11]);
%         title('p vs real eig '+string(i))
%         xlabel(name_variable(nb_variable))
%         ylabel('Real')
%         f(3+i*4-1)=figure('Name','imag eig '+string(i),'NumberTitle','off');
%         cpl([imag(f1);x1],[x1;x1],s1,[i 11]);
%         cpl([imag(f2);x2],[x2;x2],s2,[i 11]);
%         title('p vs Imaginar eig '+string(i))
%         xlabel(name_variable(nb_variable))
%         ylabel('Imaginar')
%         f(3+i*4)=figure('Name','imag eig '+string(i)+'and p','NumberTitle','off');
%         cpl([real(f1);imag(f1);x1],[v1;v1;v1],s1,[i i+7 16]);
%         cpl([real(f2);imag(f2);x2],[v2;v2;v2],s2,[i i+7 16]);
%         title('eig '+string(i)+' and p')
%         xlabel('real')
%         ylabel('Imaginar')
%         zlabel(name_variable(nb_variable))
%     end

    %% save figures
    f(end+1)=figure('Name','v_e vs v_i','NumberTitle','off');
    print_stability(x1, f1, s1, x2, f2, s2, 1,2)
    f(end+1)=figure('Name','v_e vs p','NumberTitle','off');
    print_stability(x1, f1, s1, x2, f2, s2, 1,7)
    f(end+1)=figure('Name','p vs v_i','NumberTitle','off');
    print_stability(x1, f1, s1, x2, f2, s2, 2,7)
end

function f=printing_2(x1,f1,v1,s1,x2,f2,v2,s2,nb_variable,first_parameter)
        global name_variable
        f=printing(x1,f1,v1,s1,x2,f2,v2,s2,first_parameter);
        
        f(end+1)=figure('Name','p2 vs v_e','NumberTitle','off');
        cpl(x1,v1,s1,[8 1]);
        cpl(x2,v2,s2,[8 1]);
        title('p vs v_e')
        xlabel(name_variable(nb_variable))
        ylabel('v_e in kHz')
        f(end+1)=figure('Name','p2 vs v_i','NumberTitle','off');
        cpl(x1,v1,s1,[8 2]);
        cpl(x2,v2,s2,[8 2]);
        title('p vs v_i')
        xlabel(name_variable(nb_variable))
        ylabel('v_i in kHz')
        f(end+1)=figure('Name','p1 vs p2','NumberTitle','off');
        cpl(x1,v1,s1,[7 8]);
        cpl(x2,v2,s2,[7 8]);
        title('p vs v_i')
        xlabel(name_variable(nb_variable))
        ylabel('v_i in kHz')
        f(end+1)=figure('Name','v_e vs p2','NumberTitle','off');
        print_stability(x1, f1, s1, x2, f2, s2, 1,8)
        f(end+1)=figure('Name','p2 vs v_i','NumberTitle','off');
        print_stability(x1, f1, s1, x2, f2, s2, 2,8)
        f(end+1)=figure('Name','p vs p2','NumberTitle','off');
        print_stability(x1, f1, s1, x2, f2, s2, 7,8)
    end
    

