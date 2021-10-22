%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
clear all

global cds sys
format longEng

%%%%% Set continuation pause environment variables %%%%%
%%
sys.gui.pausespecial=0;  %Pause at special points 
sys.gui.pausenever=1;    %Pause never 
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
% xinit = [0.1,0.0,0.0,0.0,0.0,0.0]; % test
xinit = [3.45432999849642e-003, 9.39513581484787e-003, 16.5141387100010e-006,35.2176982561329e-006,81.8757983637968e-006,0.00000000000000e+000]; % limit circle
% xinit = [192.633343733407e-003, 192.792039966707e-003, 88.6955903317254e-009, 4.87672060835196e-012, 347.414969848884e-009, 0.00000000000000e+000]; % high fix point
%%%%%% Define an anynomous function to pass to integrator %%%%%
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

% external_input_E_E=0.0e-3;
% external_input_I_E=0.0e-3;
% RHS_no_param_2=@(t,x)RHShandle(t,x,w_e,0.0,g_L,diff_E_L,E_L_i,C_m,E_e,E_i,Q_e,Q_i,tau_e,tau_i,N_tot,p_connect,g,T,external_input_E_E,external_input_E_I,external_input_I_E,external_input_I_I,P_e_0,P_e_1,P_e_2,P_e_3,P_e_4,P_e_5,P_e_6,P_e_7,P_e_8,P_e_9,P_i_0,P_i_1,P_i_2,P_i_3,P_i_4,P_i_5,P_i_6,P_i_7,P_i_8,P_i_9);
% [tout xout]=ode45(RHS_no_param_2,[0,500],xout(end,:),options);
% figure()
% plot(tout,xout,'-k','linewidth',2)
% xout(end,:)
% % axis([0 300 -1 1])





