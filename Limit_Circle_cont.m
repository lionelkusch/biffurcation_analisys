function Limit_Circle_cont(path,folder,nb_variable,file,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,tolerance)
    previous = load(path+"/"+file);
    xinit = previous(1).x;
    [x_init_1, x_init_2] = size(xinit);
    [total,one] = size(previous(1).s);
    value = {xinit(x_init_1,x_init_2);previous(1).v;previous(1).s(total)};
    Limit_Circle(path,folder,nb_variable,xinit,MaxStepsize,MinStepSize,MaxNumPoints_forward,MaxNumPoints_backward,tolerance,value)
end