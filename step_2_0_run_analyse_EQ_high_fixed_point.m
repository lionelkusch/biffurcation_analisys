path = "/home/kusch/Documents/project/Zerlaut/compare_zerlaut/parameter_analyse/analyse_dynamic/";
nb_variable = 17;
xinit = [0.0,0.0,0.0,0.0,0.0,0.0];
% %% forward
% folder = "EQ_low";
% MaxStepsize=1e-6;
% MaxNumPoints_forward =200000;
% MaxNumPoints_backward=20000;  
% 
% Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

% %% forward precision for first LP
% folder = "EQ_low_precision";
% MaxStepsize=1e-8;
% MaxNumPoints_forward =40000;
% MaxNumPoints_backward=-1;  
% 
% Equilibrium_Point(path,folder,nb_variable,xinit',MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)

%% forward precision for first LP
folder="EQ_low_precision_2";
file="EQ_low_precision/external_input_E_E_f.mat";
number= 10000;
MaxStepsize=1e-8;
MaxNumPoints_forward=2000;
MaxNumPoints_backward=-1;  
TestTolerance = 1e-10;
Equilibrium_Point_cont(path,folder,nb_variable,file,number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,TestTolerance)

