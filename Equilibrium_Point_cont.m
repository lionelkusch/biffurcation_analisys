%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function Equilibrium_Point_cont(path,folder,nb_variable,file,number,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,TestTolerance)
    previous = load(path+"/"+file);
    xout = previous(1).x;
    element = size(xout,2);
    xinit = xout(1:6,element-number);
    value = xout(7,element-number);
    Equilibrium_Point(path,folder,nb_variable,xinit,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,value,TestTolerance)
end