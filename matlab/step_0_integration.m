%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
clear all

global cds sys
format longEng

%%%%% Set continuation pause environment variables %%%%%
%%
sys.gui.pausespecial=0;   %Pause at special points 
sys.gui.pausenever=1;     %Pause never 
sys.gui.pauseeachpoint=0; %Pause at each point

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
[g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9] = load_parameters("./parameter.mat");
% xinit = [0.01,0.02,0.0,0.0,0.0,0.0]; % test
% xinit = [19.4041576608706e-003    32.9354748545804e-003    264.006454674855e-006    442.571316134613e-006    760.407885970590e-006]; % limit circle
% xinit = [192.630813486639e-003    192.791963261722e-003    88.7249213177669e-009   -476.385615694353e-015    347.418529152461e-009];
xinit = [6.77033765687267e-003    15.6056355721208e-003    211.562411594201e-009    292.622649231016e-009    1.39871396988592e-006];
RHS_no_param=@(t,x)RHShandle(t,x,g_L,E_L_e,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,tau_w_e,b_e,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9); 

%%%%% Set ODE integrator options %%%%%
options=odeset;
options=odeset(options,'MaxStep',1e-2);  %Set max step size
options=odeset(options,'InitialStep',1e-5); %Set Initial stepsize
options=odeset(options,'RelTol',1e-6);


% %%%%%% Integrate until a steady state is found. %%%%%
[tout xout]=ode45(RHS_no_param,[0,500],xinit,options);
figure()
plot(tout,xout,'-k','linewidth',2)
xout(end,:)





