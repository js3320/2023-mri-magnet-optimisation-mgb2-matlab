function [f]=five_gauss_calculation()
xxJ = 125740471.666;
nx=100; ny=100;
x = linspace(-0.5,0.5,nx);
y = linspace(-1,1,ny);
f = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        rr = x(i); zz = y(j);
        [~,Bzz1]=SolB(0.176,0.187,0.022,0.044,xxJ,rr,zz);
        [~,Bzz11]=SolB(0.176,0.187,-0.022,-0.044,xxJ,rr,zz);
        [~,Bzz2]=SolB(0.176,0.196,0.064,0.064+0.0237,xxJ,rr,zz);
        [~,Bzz22]=SolB(0.176,0.196,-0.064,-(0.064+0.0237),xxJ,rr,zz);
        [~,Bzz3]=SolB(0.176,0.197,0.064+0.0237+0.02,0.064+0.0237+0.02+0.0173,xxJ,rr,zz);
        [~,Bzz33]=SolB(0.176,0.197,-(0.064+0.0237+0.02),-(0.064+0.0237+0.02+0.0173),xxJ,rr,zz);
        [~,Bzz4]=SolB(0.176,0.206,0.064+0.0237+0.02+0.0173+0.02,0.064+0.0237+0.02+0.0173+0.02+0.0234,xxJ,rr,zz);
        [~,Bzz44]=SolB(0.176,0.206,-(0.064+0.0237+0.02+0.0173+0.02),-(0.064+0.0237+0.02+0.0173+0.02+0.0234),xxJ,rr,zz);
        Bz = Bzz1+Bzz11+Bzz2+Bzz22+Bzz3+Bzz33+Bzz4+Bzz44;
        f(i,j) = Bz*1e4;
    end
end
figure; hold on;
contour(x,y,f',40,'Linewidth',1.5);
colorbar;
title('5 Gauss line');
xlabel('r (m)'); ylabel('z (m)');
saveas(gcf, fullfile('figures','five_gauss_line.png'));
end
