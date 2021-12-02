%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

%% get the path 
currentFile = mfilename( 'fullpath' );
[path,~,~] = fileparts( currentFile );
path = strcat(path,"/EQ_High/");
if ~exist(path, 'dir')
   mkdir(path)
end

%% initialise parameters
nb_variable = 17;
xinit = [192.633343733407e-003, 192.792039966707e-003, 88.6955903317254e-009, 4.87672060835196e-012, 347.414969848884e-009, 0.00000000000000e+000];

%% forward
folder = "start";
MaxStepsize=1e-4;
MaxNumPoints_forward =200000;
MaxNumPoints_backward=0;  

Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% backword begin
folder = "cont_1";
xinit = [192.659455940815e-003,192.792565578740e-003,88.3928352306562e-009,4.69895412417912e-012,347.390582747485e-009,0.00000000000000e+000];
MaxStepsize=1e-5;
MaxNumPoints_forward =-1;
MaxNumPoints_backward=41000;  

Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% backword follow
folder="cont_2";
file="cont_1/external_input_E_E_b.mat";
number= 10;
MaxStepsize=1e-8;
MaxNumPoints_backward=20000; 
Equilibrium_Point_cont(path,folder,nb_variable,file,number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)


%% concatenation
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

path_shift =[struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',true,'shift',0);
             struct('path',strcat(path,'/cont_1/external_input_E_E_b.mat'),'flip',false,'shift',0);
             struct('path',strcat(path,'/cont_2/external_input_E_E_b.mat'),'flip',false,'shift',10)];
[x,v,f,h,s] = concatenate_result_1_dim(path_shift);
if ~exist(path+"/figure/", 'dir')
   mkdir(path+"/figure/")
end
figs=printing(x,f,v,s,nb_variable);
savefig(figs,path+"/figure/"+name_variable(nb_variable)+'.fig')
close(figs)
