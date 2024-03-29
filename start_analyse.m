%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function  [UserInfo,pvec,syshandle,RHShandle]=start_analyse(path,folder,nb_variable)
    if ~exist(path+""+folder, 'dir')
           mkdir(path+""+folder)
    end
    global name_variable
    name_variable=[
        "g_L",'E_L_e','E_L_i','C_m','E_e',...
        'E_i','Q_e','Q_i','tau_e','tau_i',...
        'tau_w_e','b_e','N_tot', 'p_connect','g',...
        'T','external_input_E_E','external_input_E_I','P_e_0','P_e_1',...
        'P_e_2','P_e_3','P_e_4','P_e_5','P_e_6',...
        'P_e_7','P_e_8','P_e_9','P_i_0','P_i_1',...
        'P_i_2','P_i_3','P_i_4','P_i_5','P_i_6',...
        'P_i_7','P_i_8','P_i_9',...
        ]; % Initialize parameter vector
    init()
    fprintf(string(nb_variable)+" nb_variable : "+name_variable(nb_variable)+"\n")
    %%%%% Set system %%%%%
    syshandle=@Zerlaut_adap;  %Specify system file

    %%
    %%%%% ODE Integration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%% Define a few intermediate functions for ODE integration %%%%%
    SubFunHandles=feval(syshandle);  %Get function handles from system file
    RHShandle=SubFunHandles{2};      %Get function handle for ODE

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%Initialisation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load(path+"parameter.mat","parameter");
    g_L=parameter.g_L;
    E_L_e=parameter.E_L_e;
    E_L_i=parameter.E_L_i;
    C_m=parameter.C_m;
    E_e=parameter.E_ex;
    E_i=parameter.E_in; 
    Q_e=parameter.Q_e;
    Q_i=parameter.Q_i;
    tau_e=parameter.tau_syn_ex;
    tau_i=parameter.tau_syn_in;
    tau_w_e=parameter.tau_w_e;
    b_e=parameter.b_e;
    N_tot=parameter.N_tot;
    p_connect=parameter.p_connect;
    g=parameter.g;
    T=parameter.T;
    external_input_E_E=parameter.external_input_E_E;
    external_input_E_I=parameter.external_input_E_I;
    P_e_0=parameter.P_e_0;
    P_e_1=parameter.P_e_1;
    P_e_2=parameter.P_e_2;
    P_e_3=parameter.P_e_3;
    P_e_4=parameter.P_e_4;
    P_e_5=parameter.P_e_5;
    P_e_6=parameter.P_e_6;
    P_e_7=parameter.P_e_7;
    P_e_8=parameter.P_e_8;
    P_e_9=parameter.P_e_9;
    P_i_0=parameter.P_i_0;
    P_i_1=parameter.P_i_1;
    P_i_2=parameter.P_i_2;
    P_i_3=parameter.P_i_3;
    P_i_4=parameter.P_i_4;
    P_i_5=parameter.P_i_5;
    P_i_6=parameter.P_i_6;
    P_i_7=parameter.P_i_7;
    P_i_8=parameter.P_i_8;
    P_i_9=parameter.P_i_9;

    cond_variable = [
        "Boundary_up_g_L","Boundary_low_g_L",...
        "Boundary_up_E_L_e",'Boundary_low_E_L_e',...
        "Boundary_up_E_L_i",'Boundary_low_E_L_i',...
        'Boundary_up_C_m','Boundary_low_C_m',...
        'Boundary_up_E_e','Boundary_low_E_e',...
        'Boundary_up_E_i','Boundary_low_E_i',...
        'Boundary_up_Q_e','Boundary_low_Q_e',...
        'Boundary_up_Q_i','Boundary_low_Q_i',...
        'Boundary_up_tau_e','Boundary_low_tau_e',...
        'Boundary_up_tau_i','Boundary_low_tau_i',...
        'Boundary_up_tau_w_e','Boundary_low_tau_w_e',...
        'Boundary_up_b_e','Boundary_low_b_e',...
        'Boundary_up_N_tot','Boundary_low_N_tot',...
        'Boundary_up_p_connect','Boundary_low_p_connect',...
        'Boundary_up_g','Boundary_low_g',...
        'Boundary_up_T','Boundary_low_T',...
        'Boundary_up_external_input_E_E','Boundary_low_external_input_E_E',...
        'Boundary_up_external_input_E_I','Boundary_low_external_input_E_I',...
        'Boundary_up_P_e_0','Boundary_low_P_e_0',...
        'Boundary_up_P_e_1','Boundary_low_P_e_1',...
        'Boundary_up_P_e_2','Boundary_low_P_e_2',...
        'Boundary_up_P_e_3','Boundary_low_P_e_3',...
        'Boundary_up_P_e_4','Boundary_low_P_e_4',...
        'Boundary_up_P_e_5','Boundary_low_P_e_5',...
        'Boundary_up_P_e_6','Boundary_low_P_e_6',...
        'Boundary_up_P_e_7','Boundary_low_P_e_7',...
        'Boundary_up_P_e_8','Boundary_low_P_e_8',...
        'Boundary_up_P_e_9','Boundary_low_P_e_9',...
        'Boundary_up_P_i_0','Boundary_low_P_i_0',...
        'Boundary_up_P_i_1','Boundary_low_P_i_1',...
        'Boundary_up_P_i_2','Boundary_low_P_i_2',...
        'Boundary_up_P_i_3','Boundary_low_P_i_3',...
        'Boundary_up_P_i_4','Boundary_low_P_i_4',...
        'Boundary_up_P_i_5','Boundary_low_P_i_5',...
        'Boundary_up_P_i_6','Boundary_low_P_i_6',...
        'Boundary_up_P_i_7','Boundary_low_P_i_7',...
        'Boundary_up_P_i_8','Boundary_low_P_i_8',...
        'Boundary_up_P_i_9','Boundary_low_P_i_9',];

    % user function for boundary condition
    UserInfo = [
        struct('name', 'Boundary_up_v_e' ,'label', 'BV', 'state', 1.0),...
        struct('name', 'Boundary_low_v_i' ,'label', 'BV', 'state', 1.0),...
        struct('name', 'Boundary_up_v_e' ,'label', 'BV', 'state', 1.0),...
        struct('name', 'Boundary_low_v_i' ,'label', 'BV', 'state', 1.0),...
        struct('name', 'Boundary_up_w_e' ,'label', 'BV', 'state', 1.0),...
        struct('name', 'Boundary_low_w_e' ,'label', 'BV', 'state', 1.0),...
        ];
    for i = 1:2:length(cond_variable)
     UserInfo = [UserInfo,  struct('name',  cond_variable(i),'label', 'B', 'state', int8( nb_variable == fix(i/2+1))),...
        struct('name', cond_variable(i+1) ,'label', 'B', 'state',int8( nb_variable == fix(i/2+1))),...
        ];
    end

    %%
    %%%%% Continuation from equilibrium %%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%% Set initial condition as the endpoint of integration.  Use
    %%%%%% to bootstrap the continuation.
    pvec=[
        g_L,E_L_e,E_L_i,C_m,E_e,...
        E_i,Q_e,Q_i,tau_e,tau_i,...
        tau_w_e,b_e,N_tot,p_connect,g,...
        T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,...
        P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,...
        P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,...
        P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,...
        P_i_7,P_i_8,P_i_9
        ];
end
