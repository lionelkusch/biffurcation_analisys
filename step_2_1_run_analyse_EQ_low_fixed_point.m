%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
path = "/home/kusch/Documents/project/Zerlaut/compare_zerlaut/parameter_analyse/analyse_dynamic/";
nb_variable = 17;
xinit = [192.633343733407e-003, 192.792039966707e-003, 88.6955903317254e-009, 4.87672060835196e-012, 347.414969848884e-009, 0.00000000000000e+000];
% %% forward
% folder = "EQ_High";
% MaxStepsize=1e-2;
% MaxNumPoints_forward =20000;
% MaxNumPoints_backward=0;  
% 
% Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

% %% backword begin
% folder = "EQ_High_2";
% xinit = [192.659455940815e-003,192.792565578740e-003,88.3928352306562e-009,4.69895412417912e-012,347.390582747485e-009,0.00000000000000e+000];
% MaxStepsize=1e-5;
% MaxNumPoints_forward =-1;
% MaxNumPoints_backward=41000;  
% 
% Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% backword follow
folder="EQ_High_3";
file="EQ_High_2/external_input_E_E_b.mat";
number= 10;
MaxStepsize=1e-8;
MaxNumPoints_backward=20000; 
Equilibrium_Point_cont(path,folder,nb_variable,file,number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

