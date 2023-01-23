%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function Equilibrium_Point_cont(path,folder,nb_variable,file,number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,TestTolerance, FunTolerance, VarTolerance, InitStepsize, ap_previous)
    previous = load(path+"/"+file);
    xout = previous(1).x;
    element = size(xout,2);
    xinit = xout(1:5,element-number);
    value = xout(6,element-number);
    if (exist("TestTolerance") ~= 1)
        TestTolerance=1e-7; 
    end
    if (exist("FunTolerance") ~= 1)
        FunTolerance=1e-6; 
    end
    if (exist("VarTolerance") ~= 1)
        VarTolerance=1e-6; 
    end
    if (exist("InitStepsize") ~= 1)
        InitStepsize=1e-7; 
    end
    if (exist("ap_previous") ~= 1)
        ap_previous=nb_variable; 
    end

    Equilibrium_Point(path,folder,nb_variable,xinit,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,Increment,value,TestTolerance, FunTolerance, VarTolerance, InitStepsize, ap_previous)
end