function print_test_limit_cycle(path_fig,h)

[size_h, ~]=size(h);
%%%%%%% Default parameter for the figure
set(groot,'defaultAxesFontSize',25)
set(groot,'defaultTextFontSize',25)
set(groot,'defaultLineLineWidth',2)
set(groot,'defaultAxesXGrid','on')
set(groot,'defaultAxesYGrid','on')
x0=10;
y0=10;
width=1550;
height=1400;
set(groot,'defaultFigureUnits','points')
set(groot,'defaultFigurePosition',[x0,y0,width,height])

figure(1)
semilogy(1:20000,abs(h(size_h-6,:)),'r')
hold on 
semilogy(1:20000,abs(h(size_h-5,:)),'g')
semilogy(1:20000,abs(h(size_h-4,:)),'b')
semilogy(1:20000,abs(h(size_h-3,:)),'k')
hold off
figure(2)
semilogy(1:20000,abs(h(size_h-2,:)))
figure(3)
semilogy(1:20000,abs(h(size_h-1,:)))
figure(4)
semilogy(1:20000,abs(h(size_h,:)))
%% save figures
saveas(gcf,path_fig+'_test.fig');
close('all')
end