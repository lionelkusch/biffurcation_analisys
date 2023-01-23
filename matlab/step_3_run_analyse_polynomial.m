%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

%% get the path 
currentFile = mfilename( 'fullpath' );
[path,~,~] = fileparts( currentFile );
path = strcat(path,'/');
directory = "/Polynomial/";
if ~exist(strcat(path,directory), 'dir')
   mkdir(path)
end

%% initialise parameters
nb_variable = 19;
nb_variable_previous = 17;
xinit = [0.0,0.0,0.0,0.0,0.0];

for i = 0:1:9
    %% LP middle
    folder="P_e_"+int2str(i);
    file="../EQ_Low/start/external_input_E_E_f.mat";
    number= 61441-5411;
    MaxStepsize=1e-6;
    MaxNumPoints_forward=100000;
    MaxNumPoints_backward=100000; 
    Increment=1e-7;
    TestTolerance=1e-7;
    FunTolerance=1e-6; 
    VarTolerance=1e-6; 
    InitStepsize=1e-7; 
    Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable+i,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize, nb_variable_previous)
end
nb_variable = 29;
for i = 0:1:9
    %% LP middle
    folder="P_i_"+int2str(i);
    file="../EQ_Low/start/external_input_E_E_f.mat";
    number= 61441-5411;
    MaxStepsize=1e-6;
    MaxNumPoints_forward=100000;
    MaxNumPoints_backward=100000; 
    Increment=1e-7;
    TestTolerance=1e-7;
    FunTolerance=1e-6; 
    VarTolerance=1e-6; 
    InitStepsize=1e-7; 
    Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable+i,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize, nb_variable_previous)
end
% 
% %% concatenation
% path = strcat(path,directory);
% global name_variable
% name_variable=[
%     "g_L",'E_L_e','E_L_i','C_m','E_e',...
%     'E_i','Q_e','Q_i','tau_e','tau_i',...
%     'tau_w_e','b_e','N_tot', 'p_connect','g',...
%     'T','external_input_E_E','external_input_E_I','P_e_0','P_e_1',...
%     'P_e_2','P_e_3','P_e_4','P_e_5','P_e_6',...
%     'P_e_7','P_e_8','P_e_9','P_i_0','P_i_1',...
%     'P_i_2','P_i_3','P_i_4','P_i_5','P_i_6',...
%     'P_i_7','P_i_8','P_i_9',...
%     ]; % Initialize parameter vector
% path_shift =[
%             struct('path',strcat(path,'/start/external_input_E_E_b.mat'),'flip',true,'shift',0);
%             struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',0);
%              ];
% [x,v,f,h,s] = concatenate_result_1_dim(path_shift);
% save(path+"/EQ_low.mat",'x','v','s','h','f')
% 
% if ~exist(path+"/figure/", 'dir')
%    mkdir(path+"/figure/")
% end
% figs=printing(x,f,v,s,nb_variable);
% savefig(figs,path+"/figure/"+name_variable(nb_variable)+'.fig')
% close(figs)
