%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
path = "/home/kusch/Documents/project/Zerlaut/compare_zerlaut/parameter_analyse/analyse_dynamic/";
nb_variable = 17;
nb_variable_2 = 12;

%% LP high
folder = "LP_high";
file = "EQ_High_2/external_input_E_E_b.mat";
nb_LP = 8;
MaxStepsize=1e-4;
MaxNumPoints_forward =20000;
MaxNumPoints_backward=20000;  
MinStepsize = 1e-20;

Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward)


%% LP middle
folder = "LPmiddle";
file = "EQ_High_2/external_input_E_E_b.mat";
nb_LP = 14;
MaxStepsize=1e-4;
MaxNumPoints_forward =20000;
MaxNumPoints_backward=20000;  
MinStepsize = 1e-20;

Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

% %% LP low
% folder = "LP_low";
% file = "EQ_low_precision_2/external_input_E_E_f.mat";
% nb_LP = 2;
% MaxStepsize=1e-3;
% MaxNumPoints_forward =20000;
% MaxNumPoints_backward=20000;  
% MinStepsize = 1e-20;
% 
% Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward)
