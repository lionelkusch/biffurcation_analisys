%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

%% get the path 
currentFile = mfilename( 'fullpath' );
[path,~,~] = fileparts( currentFile );
path = strcat(path,"/EQ_Low/");
if ~exist(path, 'dir')
   mkdir(path)
end

%% initialise parameters
nb_variable = 17;
xinit = [0.0,0.0,0.0,0.0,0.0,0.0];

%% forward
folder = "start";
MaxStepsize=1e-6;
MaxNumPoints_forward =200000;
MaxNumPoints_backward=20000;  

Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% forward precision for first LP
folder = "zoom_beginning";
MaxStepsize=1e-8;
MaxNumPoints_forward =40000;
MaxNumPoints_backward=-1;  

Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% forward precision for first LP
folder="zoom_LP";
file="zoom_beginning/external_input_E_E_f.mat";
number= 10000;
MaxStepsize=1e-8;
MaxNumPoints_forward=2000;
MaxNumPoints_backward=-1;  
TestTolerance = 1e-10;
Equilibrium_Point_cont(path,folder,nb_variable,file,number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,TestTolerance)

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
path_shift =[
            struct('path',strcat(path,'/start/external_input_E_E_b.mat'),'flip',true,'shift',0);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',0);
             ];
[x,v,f,h,s] = concatenate_result_1_dim(path_shift);
if ~exist(path+"/figure/", 'dir')
   mkdir(path+"/figure/")
end
figs=printing(x,f,v,s,nb_variable);
savefig(figs,path+"/figure/"+name_variable(nb_variable)+'.fig')
close(figs)
