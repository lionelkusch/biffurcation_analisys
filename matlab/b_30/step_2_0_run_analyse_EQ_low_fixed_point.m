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
xinit = [0.0,0.0,0.0,0.0,0.0,0.0];

 %% forward
 folder = "start";
 MaxStepsize=1e-4;
 MaxNumPoints_forward =100600;
 MaxNumPoints_backward=2000000;
 Increment=1e-6;
 TestTolerance=1e-6;
 Equilibrium_Point(path,strcat(directory,folder),nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance)

 % LP_H low
 folder="LP_H_low";
 file="start/external_input_E_E_f.mat";
 number= 100600-35;
 MaxStepsize=1e-7;
 MaxNumPoints_forward=2000;
 MaxNumPoints_backward=-1;
 Increment=5e-8;
 TestTolerance=1e-6;
 FunTolerance=1e-8;
 VarTolerance=1e-8;
 InitStepsize=1e-9;
 Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)

 % H middle
 folder="H_middle";
 file="start/external_input_E_E_f.mat";
 number= 100600-465;
 MaxStepsize=1e-7;
 MaxNumPoints_forward=-1;
 MaxNumPoints_backward=357;
 Increment=1e-6;
 TestTolerance=3.7e-04;
 FunTolerance=1e-6;
 VarTolerance=1e-7;
 InitStepsize=1e-9;
 Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)


 % H middle 2
 folder="H_middle_2";
 file="start/external_input_E_E_f.mat";
 number= 100600-4370;
 MaxStepsize=1e-8;
 MaxNumPoints_forward=10;
 MaxNumPoints_backward=-1;
 Increment=1e-7;
 TestTolerance=1e1;
 FunTolerance=1e-4;
 VarTolerance=1e-8;
 InitStepsize=1e-9;
 Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)

 % LP middle
 folder="LP_middle_2";
 file="start/external_input_E_E_f.mat";
 number= 100600-5025;
 MaxStepsize=1e-7;
 MaxNumPoints_forward=40;
 MaxNumPoints_backward=-1;
 Increment=1e-7;
 TestTolerance=1e-4;
 FunTolerance=1e-8;
 VarTolerance=1e-8;
 InitStepsize=1e-9;
 Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)

 % H high
 folder="H_high";
 file="start/external_input_E_E_f.mat";
 number= 100600-28766;
 MaxStepsize=1e-8;
 MaxNumPoints_forward=-1;
 MaxNumPoints_backward=10;
 Increment=1e-8;
 TestTolerance=1e1;
 FunTolerance=1e-8;
 VarTolerance=1e-8;
 InitStepsize=1e-9;
 Equilibrium_Point_cont(path,strcat(directory,folder),nb_variable,strcat(directory,file),number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize)


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

 path_shift =[
              struct('path',strcat(path,'/start/external_input_E_E_b.mat'),'flip',false,'shift',0);
              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',0);
              struct('path',strcat(path,'/LP_H_low/external_input_E_E_f.mat'),'flip',false,'shift',100600-35);
              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-38);
 %              struct('path',strcat(path,'/LP_middle/external_input_E_E_f.mat'),'flip',false,'shift',100600-465);
 %              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-220);
              struct('path',strcat(path,'/H_middle/external_input_E_E_b.mat'),'flip',true,'shift',102599-2463);
              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-465);
              struct('path',strcat(path,'/H_middle_2/external_input_E_E_f.mat'),'flip',false,'shift',102957-6727);
              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-4370);
              struct('path',strcat(path,'/LP_middle_2/external_input_E_E_f.mat'),'flip',false,'shift',102968-7393);
              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-5026);
 %              struct('path',strcat(path,'/LP_high/external_input_E_E_f.mat'),'flip',false,'shift',100600-28372);
 %              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-28363);
              struct('path',strcat(path,'/H_high/external_input_E_E_b.mat'),'flip',false,'shift',103008-31174);
              struct('path',strcat(path,'/start/external_input_E_E_f.mat'),'flip',false,'shift',-28766);
     ];
 [x,v,f,h,s] = concatenate_result_1_dim(path_shift);
 save(path+"/EQ_Low.mat",'x','v','s','h','f')
 if ~exist(path+"/figure/", 'dir')
    mkdir(path+"/figure/")
 end
 figs=printing(x,f,v,s,nb_variable);
 savefig(figs,path+"/figure/"+name_variable(nb_variable)+'.fig')
 close(figs)