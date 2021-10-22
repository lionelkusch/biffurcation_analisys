%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "

nb_variable = 17;
path = "/home/kusch/Documents/project/Zerlaut/compare_zerlaut/parameter_analyse/analyse_dynamic/";

% %% start continue LC
% folder = "Limit_Circle";
% xinit = [3.45432999849642e-003, 9.39513581484787e-003, 16.5141387100010e-006,35.2176982561329e-006,81.8757983637968e-006,0.00000000000000e+000];
% MaxStepsize=1e-3;
% MinStepSize=1e-6;
% MaxNumPoints_forward =20000;
% MaxNumPoints_backward=-1;  
% tolerance_init = 1e-4;
% TestTolerance = 1e-6;
% Limit_Circle(path,folder,nb_variable,xinit,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,tolerance,TestTolerance)

%% continu analise
folder = "Limit_Circle_2";
file="Limit_Circle/external_input_E_E_f.mat";
MaxStepsize=1e-3;
MinStepSize=1e-6;
MaxNumPoints_forward =20000;
MaxNumPoints_backward=-1;  
TestTolerance = 1e-6;
Limit_Circle_cont(path,folder,nb_variable,file,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,TestTolerance)