nx=150; ny=150;
x = linspace(-0.5,0.5,nx);
y = linspace(-1,1,ny);
f = zeros(nx,ny);
% fill with SolB() calls as in other scripts
figure; hold on;
contour(x,y,f',50,'LineWidth',1.5);
colorbar;
title('Magnetic flux density distribution');
xlabel('r (m)'); ylabel('z (m)');
saveas(gcf, fullfile('figures','fieldlines_prev_paper.png'));
