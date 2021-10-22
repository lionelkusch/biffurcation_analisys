function Limit_Circle(path,folder,nb_variable,xinit,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,tolerance)
    global name_variable
    [UserInfo,pvec,syshandle,RHShandle] = start_analyse(path,folder,nb_variable);
    ap=nb_variable; % Denote 'active' parameter for continuation
    
    %%%%% Set ODE integrator options %%%%%
    options=odeset;
    options=odeset(options,'MaxStep',1e-2);  %Set max step size
    options=odeset(options,'InitialStep',1e-5); %Set Initial stepsize
    options=odeset(options,'RelTol',1e-6);
    [g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9] = feval(@(x) x{:}, num2cell(pvec));
    RHS_no_param=@(t,x)RHShandle(t,x,g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9);
    [tout,xout]=ode45(RHS_no_param,[0,30],xinit',options);
    
    %%%%% Initialize Matcont options %%%%%
    opt=contset;
    opt=contset(opt,'MaxNumPoints',MaxNumPoints_forward); %Set number of continuation steps
    opt=contset(opt,'MaxStepsize',MaxStepsize);  %Set max step size
    opt=contset(opt,'MinStepsize',MinStepSize);%Set min step size
    opt=contset(opt,'Singularities',1);  %Monitor singularities
    opt=contset(opt,'Eigenvalues',1);    %Output eigenvalues 
    opt=contset(opt,'InitStepsize',MaxStepsize/10.0); %Set Initial stepsize
    opt=contset(opt,'Increment',1e-7); %Set initial increment this only for low 
    opt=contset(opt,'Userfunctions',1);%Set userfunction is used
    opt=contset(opt,'UserfunctionsInfo',UserInfo); %define info of user function
    %%%%% Initialize continuation %%%%%
    [x0,v0]=initOrbLC(syshandle, tout, xout, pvec, ap, 30, 4, tolerance); %Initialize equilibrium
    
    %%%%% Continuation %%%%%
    if MaxNumPoints_forward > 0
            [x1,v1,s1,h1,f1]=cont(@limitcycle,x0,v0,opt); %Equilibrium continuation
            x=x1;v=v1;f=f1;h=h1;s=s1;
            save(path+"/"+folder+"/"+name_variable(nb_variable)+'_f.mat','x','v','s','h','f')
    end
    %%
    %%%%% Backward continuation %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%% Set initial condition as the endpoint of integration.  Use
    %%%%%% to bootstrap the continuation.
     if MaxNumPoints_backward > 0
        opt=contset(opt,'MaxNumPoints',MaxNumPoints_backward);
        opt=contset(opt,'Backward',1);  %Compute backward
        %%%%% Continuation %%%%%
        [x2,v2,s2,h2,f2]=cont(@limitcycle,x0,v0,opt);    
        x=x2;v=v2;f=f2;h=h2;s=s2;
        save(path+"/"+folder+"/"+name_variable(nb_variable)+'_b.mat','x','v','s','h','f')
     end


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
    fig(1)=figure('Name','v_e vs v_i','NumberTitle','off');
    plotcycle(x,v,s,[size(x,1) 1 2],100);
    title('v_e vs v_i vs parameter')
    xlabel('parameter')
    ylabel('v_e in KHz')
    zlabel('v_i in kHz')
    fig(2)=figure('Name','v_e vs v_i 2 ','NumberTitle','off');
    plotcycle(x,v,s,[1 2],100);
    title('v_e vs v_i')
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    
    savefig(fig,path+"/"+folder+"/"+name_variable(nb_variable)+'.fig')
    close(fig)
end