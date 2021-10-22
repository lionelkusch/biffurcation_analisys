function Hopf_Limit_Circle(path,folder,file,nb_variable,nb_H,MaxStepsize,MinStepsize,MaxNumPoints_forward)
    global name_variable
    file = matfile(path+"/"+file);
    x = file.x;
    s = file.s(nb_H,:);
    if ~strcmp(s.label,'H ')
        return;
    end
    [UserInfo,pvec,syshandle] = start_analyse(path,folder,nb_variable);

    xinit=x(1:6,s.index);
    pvec(nb_variable)=x(end,s.index);
    ap=nb_variable; % Denote 'active' parameter for continuation

    %%%%% Initialize continuation %%%%%
    [x0,v0]=init_H_LC(syshandle, xinit, pvec', ap,MaxStepsize,30,4); %Initialize equilibrium
    
    %%%%% Initialize Matcont options %%%%%
    opt=contset;
    opt=contset(opt,'MaxNumPoints',MaxNumPoints_forward); %Set numeber of continuation steps
    opt=contset(opt,'MaxStepsize',MaxStepsize);  %Set max step size
    opt=contset(opt,'MinStepsize',MinStepsize);%Set min step size
    opt=contset(opt,'Singularities',1);  %Monitor singularities
    opt=contset(opt,'Eigenvalues',1);    %Output eigenvalues 
    opt=contset(opt,'InitStepsize',MaxStepsize/10.0); %Set Initial stepsize
    opt=contset(opt,'Userfunctions',1);%Set userfunction is used
    opt=contset(opt,'UserfunctionsInfo',UserInfo); %define info of user function
%     opt=contset(opt,'Backward',1);  %Compute backward
    %%%%% Continuation %%%%%
    [x1,v1,s1,h1,f1]=cont(@limitcycle,x0,v0,opt); %Equilibrium continuation 

    save(path+"/"+folder+"/"+name_variable(nb_variable)+'_precision.mat','x1','v1','s1','h1','f1')
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
    plotcycle(x1,v1,s1,[size(x1,1) 1 2]);
    title('v_e vs v_i')
    xlabel('parameter')
    ylabel('v_e in KHz')
    zlabel('v_i in kHz')
    f(2)=figure('Name','v_e vs v_i 2 ','NumberTitle','off');
    plotcycle(x1,v1,s1,[1 2]);
    title('v_e vs v_i')
    ylabel('v_e in KHz')
    zlabel('v_i in kHz')
    %% save figures
    savefig(f,path+"/"+folder+"/"+name_variable(nb_variable)+'_precision.fig')
    close(f)
