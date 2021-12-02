%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

%% get the path 
currentFile = mfilename( 'fullpath' );
[path,~,~] = fileparts( currentFile );
path = strcat(path,"/Limit_Circle/");
if ~exist(path, 'dir')
   mkdir(path)
end

%% initialise parameters
nb_variable = 17;

% %% start continue LC
% folder = "start";
% xinit = [3.45432999849642e-003, 9.39513581484787e-003, 16.5141387100010e-006,35.2176982561329e-006,81.8757983637968e-006,0.00000000000000e+000];
% MaxStepsize=1e-3;
% MinStepSize=1e-6;
% MaxNumPoints_forward =20000;
% MaxNumPoints_backward=-1;  
% tolerance_init = 1e-4;
% TestTolerance = 1e-5;
% Limit_Circle(path,folder,nb_variable,xinit,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,tolerance_init,TestTolerance)

% %% continu analise
% folder = "cont_1";
% file="Limit_Circle/external_input_E_E_f.mat";
% MaxStepsize=1e-3;
% MinStepSize=1e-6;
% MaxNumPoints_forward =20000;
% MaxNumPoints_backward=-1;  
% TestTolerance = 1e-10;
% Limit_Circle_cont(path,folder,nb_variable,file,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,TestTolerance)

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
path_shift =[
    struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',0);
    struct('path',strcat(path,'/cont_1/external_input_E_E_f.mat'),'flip',false,'shift',20000);
             ];
[x,v,f,h,s] = concatenate_result_1_dim(path_shift);


global lds
lds.tps = (s(1).data.ntst*s(1).data.ncol+1);
lds.nphase = round((size(x,1)-2)/(s(1).data.ntst*s(1).data.ncol+1));
if ~exist(path+"/figure/", 'dir')
   mkdir(path+"/figure/")
end
print_limit_cycle(path+"/figure/f_"+name_variable(nb_variable),x,v,h,s,name_variable(nb_variable),100)
print_test_limit_cycle(path+"/figure/f_"+name_variable(nb_variable),h)