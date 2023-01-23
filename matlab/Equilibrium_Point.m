%  Copyright 2021 Aix-Marseille Université
% "Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements; and to You under the Apache License, Version 2.0. "
function Equilibrium_Point(path,folder,nb_variable,xinit,MaxStepsize,MaxNumPoints_forward,MaxNumPoints_backward,increment,value,TestTolerance, FunTolerance, VarTolerance, InitStepsize, ap_previous)
    global name_variable
    [UserInfo,pvec,syshandle] = start_analyse(path,folder,nb_variable);
    
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
    %%%%% Continuation from equilibrium %%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%% Set initial condition as the endpoint of integration.  Use
    %%%%%% to bootstrap the continuation.
    ap=nb_variable; % Denote 'active' parameter for continuation
    if (exist("value") == 1)
        pvec(ap_previous)=value;
    end
    [x0,v0]=init_EP_EP(syshandle, xinit, pvec, ap); %Initialize equilibrium

    %%%%% Initialize Matcont options %%%%%
    opt=contset;
    opt=contset(opt,'MaxNumPoints',MaxNumPoints_forward); %Set number of continuation steps
    opt=contset(opt,'MaxStepsize',MaxStepsize);  %Set max step size
    opt=contset(opt,'MinStepsize',1e-16);%Set min step size
    opt=contset(opt,'Singularities',1);  %Monitor singularities
    opt=contset(opt,'Eigenvalues',1);    %Output eigenvalues 
    opt=contset(opt,'Increment',increment); %Set initial increment this only for low 
    opt=contset(opt,'TestTolerance',TestTolerance);
    opt=contset(opt,'Userfunctions',1);%Set userfunction is used
    opt=contset(opt,'UserfunctionsInfo',UserInfo); %define info of user function

    opt=contset(opt,'MaxCorrIters',100);  % maximum number of iteration for correction
    opt=contset(opt,'MaxNewtonIters',100);  % maximum number of iteration for newton algorithm before switching to Newton-Chords in the corrector iterations
    opt=contset(opt,'MaxTestIters',100);  % maximum number of iteration to locate a zero of a testfunction
    opt=contset(opt,'MoorePenrose', 0); 
    opt=contset(opt,'FunTolerance', FunTolerance);
    opt=contset(opt,'VarTolerance', VarTolerance);
    opt=contset(opt,'InitStepsize',InitStepsize); %Set Initial stepsize
    opt=contset(opt,'Adapt', 0);

    %%%%% Continuation %%%%%
    if MaxNumPoints_forward > 0
            [x1,v1,s1,h1,f1]=cont(@equilibrium,x0,v0,opt); %Equilibrium continuation
            x=x1;v=v1;f=f1;h=h1;s=s1;
            save(path+"/"+folder+"/"+name_variable(nb_variable)+'_f.mat','x','v','s','h','f')
    end
    %%
    %%%%% Backward continuation %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%% Set initial condition as the endpoint of integration.  Use
    %%%%%% to bootstrap the continuation.
     if MaxNumPoints_backward > 0
        opt=contset(opt,'MaxNumPoints',MaxNumPoints_backward);
        opt=contset(opt,'Backward',1);  %Compute backward
        %%%%% Continuation %%%%%
        [x2,v2,s2,h2,f2]=cont(@equilibrium,x0,v0,opt);    
        x=x2;v=v2;f=f2;h=h2;s=s2;
        save(path+"/"+folder+"/"+name_variable(nb_variable)+'_b.mat','x','v','s','h','f')
     else
         x2 = x1(:,1);
         v2 = v1(:,1);
         f2 = f1(:,1);
         h2 = h1(:,1);
         s2 = struct('index',[1;1],'label',['00';'99'],'data',[struct('v',[]);struct('v',[])],'msg',char('This is the first point of the curve','This is the last point on the curve'));
     end

    if MaxNumPoints_forward <= 0
         x1 = x2(:,1);
         v1 = v2(:,1);
         f1 = f2(:,1);
         h1 = h2(:,1);
         s1 = struct('index',[1;1],'label',['00';'99'],'data',[struct('v',[]);struct('v',[])],'msg',char('This is the first point of the curve','This is the last point on the curve'));
    end
    
    f=printing(x1,f1,v1,s1,x2,f2,v2,s2,nb_variable);
    %% save figures
    savefig(f,path+"/"+folder+"/"+name_variable(nb_variable)+'_precision.fig')
    close(f)
    
end

