%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
%% concatenate_result_1_dim
% concatenate result from multiple continuation biffurcation
%% Inputs:
% path_shift : array of struct 
%   the structure is composed of:
%        'path'  : path of the result
%        'shift' : boolean if the array need to be shift or not
%        'shift' : the number of element to drop from the previous result
%% Output
% x,v,f,h,s => concatenation of all the results

function [x,v,f,h,s]=concatenate_result_1_dim(path_shift)
[x,v,f,h,s]=load_file(path_shift(1).path);
if (path_shift(1).flip)
    [x,v,f,h,s] = flip_res(x,v,f,h,s);
end
for i = 2:numel(path_shift)
    [x_1,v_1,f_1,h_1,s_1]=load_file(path_shift(i).path);
    if (path_shift(i).flip)
       [x_1,v_1,f_1,h_1,s_1] = flip_res(x_1,v_1,f_1,h_1,s_1);
    end
    [x,v,f,h,s]=concatenate(x,v,f,h,s,x_1,v_1,f_1,h_1,s_1,path_shift(i).shift);
end

s_tmp = s;
s_tmp(2:end+1) =s;
s_tmp(1)=s_1(1);
s_tmp(end+1)=s_1(end);
s = s_tmp;


function [x,v,f,h,s]=load_file(path)
%% loafile
% Input: path of the file
% Output : the different variable from the file/ output of one run

S=load(path,'-mat',"x","v","f","h","s");
x=S.x;
v=S.v;
f=S.f;
h=S.h;
s=S.s;

function [x,v,f,h,s]=flip_res(x_1,v_1,f_1,h_1,s_1)
%% flip_res
% flip the result 
% Input: a result fo one run
% Output: result flip

x=flip(x_1,2);
v=flip(v_1,2);
f=flip(f_1,2);
h=flip(h_1,2);

s_1(1).label = '99';
s_1(end).label = '00';
%change order
for i=1:numel(s_1)
    s_1(i).index = s_1(numel(s_1)).index-s_1(i).index+1;
end
T = struct2table(s_1);
sortedT = sortrows(T, 'index');
s = table2struct(sortedT);

function [x,v,f,h,s]=concatenate(x_0,v_0,f_0,h_0,s_0,x_1,v_1,f_1,h_1,s_1,shift)
%% concatenate 2 results
% Input : 2 results and the shift (result not used at this end of first input)
% Output : concatenation of the two results
if shift < 0
    x=[x_0,x_1(:,-shift:end)];
    f=[f_0,f_1(:,-shift:end)];
    v=[v_0,v_1(:,-shift:end)];
    h=[h_0,h_1(:,-shift:end)];
    s= s_0;
    [dim_0_x_0, dim_1_x_0] = size(x_0);
    index_concatenate = dim_1_x_0 + shift;
    index_add = numel(s)+1;
    for i=1:numel(s_1)
        if ((s_1(i).index > -shift) && (~ (strcmp(s_1(i).label,'00') || strcmp(s_1(i).label,'99'))))
            s(index_add) = s_1(i);
            s(index_add).index = index_concatenate + s(index_add).index;
            index_add=1+index_add;
        end
    end
elseif shift >= 0
    x=[x_0(:,1:end-shift),x_1];
    f=[f_0(:,1:end-shift),f_1];
    v=[v_0(:,1:end-shift),v_1];
    h=[h_0(:,1:end-shift),h_1];
    index_s = 1;
    [dim_h_0_1, dim_h_0_2] = size(h_0);
    while (s_0(index_s).index < dim_h_0_2-shift)
        index_s = 1 + index_s;
    end
    s= s_0(1:index_s);
    index_s_0 = dim_h_0_2-shift;
    index_s = numel(s);
    s(end)=[];
    for i=1:numel(s_1)
        if (~ (strcmp(s_1(i).label,'00') || strcmp(s_1(i).label,'99')))
            s(index_s) = s_1(i);
            s(index_s).index = index_s_0 + s(index_s).index;
            index_s = index_s + 1;
        end
    end
end