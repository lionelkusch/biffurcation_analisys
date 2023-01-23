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

