nx=100; ny=100;
x = linspace(0,0.08,nx);
y = linspace(0,0.08,ny);
f = zeros(nx,ny);
% populate f with ppm values if the homogeneity function is available
figure; hold on;
contour(x,y,f','LineWidth',2);
colorbar;
title('Homogeneity (ppm)');
xlabel('x (m)'); ylabel('y (m)');
saveas(gcf, fullfile('figures','ppm_plot.png'));
