%5 gaussline -->전에 썼던 Bz contour에서 Bz=5일 때만 plot해서 5 가오스 라인 구하기

clear; close all;

nx=50;
ny=50;
x = linspace(0,3,nx);
y = linspace(0,3,ny);
f = zeros(nx,ny);
%g = zeros(nx,ny);
tickValues = 0:1:5;
tickLabels = {'0', '1', '2', '3'};

for i=1:nx
    for j=1:ny
        f(i,j)=obj([x(i), y(j)]);
       % g(i,j)=obj([x(i), y(j)]);
    end
end
figure; hold on;
contour(x,y,f',40,'Linewidth',1.5);
colorbar;
xlabel('Radial direction (m)');
ylabel('Axial direction (m)');
xticks(tickValues);
yticks(tickValues);
xticklabels(tickLabels);
yticklabels(tickLabels);
set(gca, 'FontSize', 20);
function [f]=obj(x)
    xxJ = 128037463.766;
    height1=0.022;
    height2=0.020;
    height3=0.022;
    height4=0.018;
    gap1 = 0.024770;
    gap2 = 0.063190;
    gap3 = 0.010580;
    gap4 = 0.039988;
    width1 = 0.010044;
    width2 = 0.017932;
    width3 = 0.010764;
    width4 = 0.048180;

                    [Brr1, Bzz1] = SolB(0.176,0.176+width1, gap1, gap1+height1, xxJ, x(1), x(2));
                    %-1번
                    [Brr11, Bzz11] = SolB(0.176,0.176+width1,-gap1, -(gap1+height1), xxJ, x(1), x(2));
                    %2번
                    [Brr2, Bzz2] = SolB(0.176,0.176+width2,gap1+0.022+gap2,gap1+height1+gap2+height2, xxJ, x(1), x(2));
                    %-2번
                    [Brr22, Bzz22] = SolB(0.176,0.176+width2, -(gap1+0.022+gap2), -(gap1+height1+gap2+height2), xxJ, x(1), x(2));
                    [Brr3, Bzz3] = SolB(0.176,0.176+width3,gap3,gap3+height3, xxJ, x(1), x(2));
                    [Brr33, Bzz33] = SolB(0.176,0.176+width3, -(gap3),-(gap3+height3), xxJ, x(1), x(2));
                    [Brr4, Bzz4] = SolB(0.176,0.176+width4, gap1+height1+gap2+height2+gap4, gap1+height1+gap2+height2+gap4+height4, xxJ, x(1), x(2));
                    [Brr44, Bzz44] = SolB(0.176,0.176+width4, -(gap1+height1+gap2+height2+gap4), -(gap1+height1+gap2+height2+gap4+height4), xxJ, x(1), x(2));
                    % Calculate total magnetic field in the z-direction
                    % Calculate total magnetic field in the z-direction
                   
                    f = (Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22)-Bzz3-abs(Bzz33)+Bzz4+abs(Bzz44))*10000;
                    if f>4.9&&f<5.1
                        f = (Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22)-Bzz3-abs(Bzz33)+Bzz4+abs(Bzz44))*10000;
                    elseif f>-8.1&&f<-7.9
                        f = (Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22)-Bzz3-abs(Bzz33)+Bzz4+abs(Bzz44))*10000;
                    else
                        f=0;
                    end 
end
