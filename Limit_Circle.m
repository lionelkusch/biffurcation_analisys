%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function Limit_Circle(path,folder,nb_variable,xinit,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,tolerance_init,TestTolerance,value)
    global name_variable
    [UserInfo,pvec,syshandle,RHShandle] = start_analyse(path,folder,nb_variable);
    ap=nb_variable; % Denote 'active' parameter for continuation
    
    if (exist("value") ~= 1)
        %%%%% Set ODE integrator options %%%%%
        options=odeset;
        options=odeset(options,'MaxStep',1e-2);  %Set max step size
        options=odeset(options,'InitialStep',1e-5); %Set Initial stepsize
        options=odeset(options,'RelTol',1e-6);
        [g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9] = feval(@(x) x{:}, num2cell(pvec));
        RHS_no_param=@(t,x)RHShandle(t,x,g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9);
        [tout,xout]=ode45(RHS_no_param,[0,30],xinit',options);
        %%%%% Initialize continuation %%%%%
        [x0,v0]=initOrbLC(syshandle, tout, xout, pvec, ap, 30, 4, tolerance_init); %Initialize equilibrium
    else
        pvec(ap)=value{1};
        [x0,v0]=init_LC_LC(syshandle, xinit, value{2}, value{3}, pvec, ap, 30, 4);
    end
    
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
    opt=contset(opt,'TestTolerance',TestTolerance); %test tolerance of the test

    
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
    if MaxNumPoints_forward > 0
        print_limit_cycle(path+"/"+folder+"/f_"+name_variable(nb_variable),x1,v1,h1,s1,name_variable(nb_variable),100)
        print_test_limit_cycle(path+"/"+folder+"/f_"+name_variable(nb_variable),h1)
    end
    if MaxNumPoints_backward > 0
        print_limit_cycle(path+"/"+folder+"/b_"+name_variable(nb_variable),x2,v2,h2,s2,name_variable(nb_variable),100)
        print_test_limit_cycle(path+"/"+folder+"/f_"+name_variable(nb_variable),h2)
    end
end