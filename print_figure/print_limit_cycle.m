function print_limit_cycle(path_fig,x1,v1,h1,s1,name,increment)
    filepath = fileparts(mfilename('fullpath'));
    load(strcat(filepath,'/myprinttemplate.mat'));

    print_period_parameter(strcat("period of LC for ",name),x1,v1,s1);    
    setprinttemplate(gcf,template);

    saveas(gcf,path_fig+'_period.fig');
    close('all')
    
    figure('Name','v_e vs v_i','NumberTitle','off');
    plotcycle_modify(x1,s1,[1 2],increment);
    setprinttemplate(gcf,template);
    title('v_e vs v_i')
    xlabel('v_e in KHz')
    ylabel('v_i in kHz')
    saveas(gcf,path_fig+'_2.fig');
    close('all')
    
    figure('Name','v_e vs v_i vs parameter','NumberTitle','off');
    plotcycle_modify(x1,s1,[size(x1,1) 1 2],increment);
    setprinttemplate(gcf,template);
    title('v_e vs v_i vs parameter')
    xlabel(name)
    ylabel('v_e in KHz')
    zlabel('v_i in kHz')
    saveas(gcf,path_fig+'_3.fig');
    close('all')

    figure('Name','Stable v_e vs v_i vs parameter','NumberTitle','off');
    plotcycle_modify_stability(x1,h1,s1,[size(x1,1) 1 2],increment);
    setprinttemplate(gcf,template);
    title('v_e vs v_i vs parameter')
    xlabel(name)
    ylabel('v_e in KHz')
    zlabel('v_i in kHz')
    saveas(gcf,path_fig+'_3_stable.fig');
    close('all')
end