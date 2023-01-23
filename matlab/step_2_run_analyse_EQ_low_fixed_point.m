%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

%% get the path 
currentFile = mfilename( 'fullpath' );
[path,~,~] = fileparts( currentFile );
path = strcat(path,'/');
directory = "/EQ_Low/";
if ~exist(strcat(path,directory), 'dir')
   mkdir(path)
end

%% initialise parameters
nb_variable = 17;
xinit = [0.0,0.0,0.0,0.0,0.0];

% %% forward
% folder = "start";
% MaxStepsize=1e-5;
% MaxNumPoints_forward =61400;
% MaxNumPoints_backward=2000000;  
% Increment=1e-6;
% TestTolerance=1e-6;
% Equilibrium_Point(path,strcat(directory,folder),nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance)
% 
% %% LP low
% folder="LP_low";
% file="start/external_input_E_E_f.mat";
% number= 61400-47;
% MaxStepsize=1e-8;
% MaxNumPoints_forward=20;
% MaxNumPoints_backward=-1; 
% Increment=1e-7;
% TestTolerance=1e-6;
% Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance)
%
% %% LP middle
% folder="LP_middle";
% file="start/external_input_E_E_f.mat";
% number= 61400-839;
% MaxStepsize=1e-8;
% MaxNumPoints_forward=200;
% MaxNumPoints_backward=-1; 
% Increment=1e-7;
% TestTolerance=1e-6;
% Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance)
% 
% %% H middle
% folder="H_middle";
% file="start/external_input_E_E_f.mat";
% number= 61400-1929;
% MaxStepsize=1e-8;
% MaxNumPoints_forward=400;
% MaxNumPoints_backward=-1; 
% Increment=1e-7;
% TestTolerance=1e-6;
% Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance)
% 
% %% H high
% folder="H_high";
% file="start/external_input_E_E_f.mat";
% number= 61400-19759;
% MaxStepsize=1e-7;
% MaxNumPoints_forward=400;
% MaxNumPoints_backward=-1; 
% Increment=1e-9;
% TestTolerance=5e-2;
% FunTolerance=1e-5; 
% VarTolerance=1e-5; 
% InitStepsize=1e-8; 
% Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)
% 
% %% LP high
% folder="LP_high";
% file="start/external_input_E_E_f.mat";
% number= 61400-19939;
% MaxStepsize=1e-5;
% MaxNumPoints_forward=400;
% MaxNumPoints_backward=-1; 
% Increment=1e-6;
% TestTolerance=2e-6;
% FunTolerance=1e-4; 
% VarTolerance=1e-4; 
% InitStepsize=1e-8; 
% Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)

% %% LP high 2
% folder="LP_high_2";
% file="start/external_input_E_E_f.mat";
% number= 61400-39059;
% MaxStepsize=1e-7;
% MaxNumPoints_forward=1000;
% MaxNumPoints_backward=-1; 
% Increment=1e-7;
% TestTolerance=1e-6;
% FunTolerance=1e-5; 
% VarTolerance=1e-5; middle
% InitStepsize=1e-8; 
% Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)
%
% 
%% concatenation
path = strcat(path,directory);
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

% % remove some detection for better precision
% S=load(strcat(path,'/start/external_input_E_E_f.mat'),'-mat',"x","v","f","h","s");
% x=S.x;
% v=S.v;
% f=S.f;
% h=S.h;
% s=S.s;
% s_tmp(1) = s(1);
% s_tmp(2) = s(4);
% s_tmp(3) = s(5);
% s = s_tmp;
% save(strcat(path,'/start/external_input_E_E_f.mat'),'x','v','s','h','f');


path_shift =[
            struct('path',strcat(path,'/start/external_input_E_E_b.mat'),'flip',true,'shift',0);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',0);
            struct('path',strcat(path,'/LP_low/external_input_E_E_f.mat'),'flip',false,'shift',61400-47);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-49);
            struct('path',strcat(path,'/LP_middle/external_input_E_E_f.mat'),'flip',false,'shift',61400-839);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-841);
            struct('path',strcat(path,'/H_middle/external_input_E_E_f.mat'),'flip',false,'shift',61400-1929);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-1933);
            struct('path',strcat(path,'/H_high/external_input_E_E_f.mat'),'flip',false,'shift',61400-19759);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-19760);
            struct('path',strcat(path,'/LP_high/external_input_E_E_f.mat'),'flip',false,'shift',61400-19939);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-20314);
            struct('path',strcat(path,'/LP_high_2/external_input_E_E_f.mat'),'flip',false,'shift',61400-39059);
            struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-39069);
             ];
[x,v,f,h,s] = concatenate_result_1_dim(path_shift);

save(path+"/EQ_low.mat",'x','v','s','h','f');

if ~exist(path+"/figure/", 'dir')
   mkdir(path+"/figure/")
end
figs=printing(x,f,v,s,nb_variable);
savefig(figs,path+"/figure/"+name_variable(nb_variable)+'.fig')
close(figs)
