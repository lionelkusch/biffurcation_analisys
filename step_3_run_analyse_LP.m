%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

%% get the path 
currentFile = mfilename( 'fullpath' );
[path,~,~] = fileparts( currentFile );
path = strcat(path,"/LP/");
if ~exist(path, 'dir')
   mkdir(path)
end

%% initialise parameters
nb_variable = 17;
nb_variable_2 = 12;
 
%% LP high
folder = "high";
file = "EQ_High/cont_1/external_input_E_E_b.mat";
nb_LP = 8;
MaxStepsize=1e-4;
MaxNumPoints_forward =200000;
MaxNumPoints_backward=200000;  
MinStepsize = 1e-20;
Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward)


%% LP middle
folder = "middle";
file = "EQ_High_/cont_1/external_input_E_E_b.mat";
nb_LP = 14;
MaxStepsize=1e-4;
MaxNumPoints_forward =200000;
MaxNumPoints_backward=200000;  
MinStepsize = 1e-20;
Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% LP low
folder = "low";
file = "EQ_low/zoom_LP/external_input_E_E_f.mat";
nb_LP = 2;
MaxStepsize=1e-3;
MaxNumPoints_forward =200000;
MaxNumPoints_backward=200000;  
MinStepsize = 1e-20;
Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward)
