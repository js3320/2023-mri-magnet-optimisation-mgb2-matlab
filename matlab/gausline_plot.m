nx=100; ny=100;
x = linspace(-0.5,0.5,nx);
y = linspace(-1,1,ny);
f = zeros(nx,ny);
% fill this using SolB like other scripts if needed
figure; hold on;
contour(x,y,f',40,'Linewidth',1.5);
colorbar;
title('5 Gauss line');
xlabel('r (m)'); ylabel('z (m)');
saveas(gcf, fullfile('figures','gausline_plot.png'));
