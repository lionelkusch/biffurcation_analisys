function Limit_Point_cont(path,folder,number,file,nb_variable,nb_variable_2,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward)
    previous = load(path+"/"+file);
    xout = previous(1).x;
    element = size(xout,2);
    xinit = xout(1:6,element-number);
    value = {xinit;xout(7,element-number);xout(8,element-number)};
    Limit_Point(path,folder,"",nb_variable,nb_variable_2,0,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward,value)
end