%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
path = "/home/kusch/Documents/project/Zerlaut/compare_zerlaut/parameter_analyse/analyse_dynamic/";
nb_variable = 17;
%% H low 
% step too small
% folder = "H_LC_low";
% file = "EQ_High_2/external_input_E_E_b.mat";
% nb_H = 10;
% MaxStepsize=1e-10;
% MaxNumPoints_forward =200;
% MaxNumPoints_backward=0;  
% MinStepsize = 1e-20;
% 
% Hopf_Limit_Circle(path,folder,file,nb_variable,nb_H,MaxStepsize,MinStepsize,MaxNumPoints_forward)

%% H middle
folder = "H_LC_middle";
file = "EQ_High_2/external_input_E_E_b.mat";
nb_H = 11;
MaxStepsize=1e-8;
MaxNumPoints_forward =2000;
MinStepsize = 1e-50;

Hopf_Limit_Circle(path,folder,file,nb_variable,nb_H,MaxStepsize,MinStepsize,MaxNumPoints_forward)

%% H high
% No circle for this point => go in negative values
% folder = "H_LC_high";
% file = "EQ_High_2/external_input_E_E_b.mat";
% nb_H = 15;
% MaxStepsize=1e-6;
% MaxNumPoints_forward =0;
% MinStepsize = 1e-20;
% 
% Hopf_Limit_Circle(path,folder,file,nb_variable,nb_H,MaxStepsize,MinStepsize,MaxNumPoints_forward)