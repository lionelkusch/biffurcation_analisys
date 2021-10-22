function Limit_Point(path,folder,file,nb_variable,nb_variable_2,nb_LP,MaxStepsize,MinStepsize,MaxNumPoints_forward,MaxNumPoints_backward,value)
    
    global name_variable
    if (exist("value") ~= 1)
        file = matfile(path+"/"+file);
        x = file.x;
        s = file.s(nb_LP,:);
        if ~strcmp(s.label,'LP')
            return;
        end
        [UserInfo,pvec,syshandle] = start_analyse(path,folder,nb_variable);

        xinit=x(1:6,s.index);
        pvec(nb_variable)=x(end,s.index);
        ap=[nb_variable,nb_variable_2]; % Denote 'active' parameter for continuation
        
        %%%%% Initialize continuation %%%%%
        [x0,v0]=init_LP_LP(syshandle, xinit, pvec', ap); %Initialize equilibrium
    else
        xinit=value{1};
        pvec(nb_variable)=value{2};
        pvec(nb_variable_2)=value{3};
        ap=[nb_variable,nb_variable_2];
        [x0,v0]=init_LP_LP(syshandle, xinit, pvec', ap); %Initialize equilibrium ???
    end

    
    %%%%% Initialize Matcont options %%%%%
    opt=contset;
    opt=contset(opt,'MaxNumPoints',MaxNumPoints_forward); %Set numeber of continuation steps
    opt=contset(opt,'MaxStepsize',MaxStepsize);  %Set max step size
    opt=contset(opt,'MinStepsize',MinStepsize);%Set min step size
    opt=contset(opt,'Singularities',1);  %Monitor singularities
    opt=contset(opt,'Eigenvalues',1);    %Output eigenvalues 
    opt=contset(opt,'InitStepsize',MaxStepsize/10.0); %Set Initial stepsize
    opt=contset(opt,'Userfunctions',1);%Set userfunction is used
    opt=contset(opt,'UserfunctionsInfo',UserInfo); %define info of user function
    
    %%
    %%%%% Continuation %%%%%
    if(MaxNumPoints_forward > 0)
        [x1,v1,s1,h1,f1]=cont(@limitpoint,x0,v0,opt); %Equilibrium continuation
        x=x1;v=v1;f=f1;h=h1;s=s1;
        save(path+"/"+folder+"/"+name_variable(nb_variable)+'_f.mat','x','v','s','h','f')
    end
    %%
    %%%%% Backward continuation %%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%% Set initial condition as the endpoint of integration.  Use
    %%%%%% to bootstrap the continuation.
    if(MaxNumPoints_backward > 0)
        opt=contset(opt,'MaxNumPoints',MaxNumPoints_backward);
        opt=contset(opt,'Backward',1);
        %%%%% Continuation %%%%%
        %Compute backward
        [x2,v2,s2,h2,f2]=cont(@limitpoint,x0,v0,opt);
        x=x2;v=v2;f=f2;h=h2;s=s2;
        save(path+"/"+folder+"/"+name_variable(nb_variable)+'_b.mat','x','v','s','h','f')
     else
         x2 = x1(:,1);
         v2 = v1(:,1);
         f2 = f1(:,1);
         h2 = h1(:,1);
         s2 = struct('index',[1;1],'label',['00';'99'],'data',[struct('v',[]);struct('v',[])],'msg',char('This is the first point of the curve','This is the last point on the curve'));
    end
   
    if MaxNumPoints_forward < 0
         x1 = x2(:,1);
         v1 = v2(:,1);
         f1 = f2(:,1);
         h1 = h2(:,1);
         s1 = struct('index',[1;1],'label',['00';'99'],'data',[struct('v',[]);struct('v',[])],'msg',char('This is the first point of the curve','This is the last point on the curve'));
    end


    f=printing(x1,f1,v1,s1,x2,f2,v2,s2,nb_variable,nb_variable_2);
    %% save figures
    savefig(f,path+"/"+folder+"/"+name_variable(nb_variable)+'_precision.fig')
    close(f)
