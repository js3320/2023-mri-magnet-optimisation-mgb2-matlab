
clear; close all;

nx=150;
ny=150;
x = linspace(0,0.35,nx);
y = linspace(0,0.35,ny);
f = zeros(nx,ny);
%g = zeros(nx,ny);
tickValues = 0:0.05:0.35;
tickLabels = {'0', '0.05', '0.1', '0.15', '0.2', '0.25', '0.3','0.35'};

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
    xxJ = 126000000;
    gap1 = 0.024091;
    gap2 = 0.066244;
    gap3 = 0.010073;
    gap4 = 0.024409;
    width1 = 0.01049;
    width2 = 0.021678;
    width3 = 0.022064;
    width4 = 0.026702;
    height1 = 0.022;
    height2 = 0.025;
    height3 = 0.023;
    height4 = 0.036;
                    [Brr1, Bzz1] = SolB(0.176,0.176+width1, gap1, gap1+height1, xxJ, x(1), x(2));
                    %-1번
                    [Brr11, Bzz11] = SolB(0.176,0.176+width1,-gap1, -(gap1+height1), xxJ, x(1), x(2));
                    %2번
                    [Brr2, Bzz2] = SolB(0.176,0.176+width2,gap1+height1+gap2,gap1+height1+gap2+height2, xxJ, x(1), x(2));
                    %-2번
                    [Brr22, Bzz22] = SolB(0.176,0.176+width2, -(gap1+height1+gap2), -(gap1+height1+gap2+height2), xxJ, x(1), x(2));
                    [Brr3, Bzz3] = SolB(0.176,0.176+width3,gap1+height1+gap2+gap3,gap1+height1+gap2+gap3+height3, xxJ, x(1), x(2));
                    [Brr33, Bzz33] = SolB(0.176,0.176+width3, -(gap1+height1+gap2+gap3),-(gap1+height1+gap2+gap3+height3), xxJ, x(1), x(2));
                    [Brr4, Bzz4] = SolB(0.176,0.176+width4, gap1+height1+gap2+gap3+height3+gap4, gap1+height1+gap2+gap3+height3+gap4+height4, xxJ, x(1), x(2));
                    [Brr44, Bzz44] = SolB(0.176,0.176+width4, -(gap1+height1+gap2+gap3+height3+gap4+height4), -(gap1+height1+gap2+gap3+height3+gap4+height4), xxJ, x(1), x(2));
                    % Calculate total magnetic field in the z-direction
                    % Calculate total magnetic field in the z-direction
                   
                    TotalBzz = Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22)-Bzz3-abs(Bzz33)+Bzz4+abs(Bzz44);
                    f = TotalBzz;
end