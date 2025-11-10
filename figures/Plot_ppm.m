clear; close all;
nx=100;
ny=100;
x = linspace(0,0.12,nx);
y = linspace(0,0.12,ny);
f=zeros(nx,ny);

tickValues = 0:0.02:0.12;
tickLabels = {'0', '0.02', '0.04', '0.06', '0.08', '0.10', '0.12'};

for i = 1:nx
    for j=1:ny
        f(i,j)=obj([x(i),y(j)]);
        g(i,j)=con([x(i),y(j)]);
    end
end

figure; hold on;
contour(x,y,f',10, 'LineWidth', 2);
contour(x,y,f', 'LineWidth', 2);
contour(x,y,g',50,'LineColor', 'k','LineStyle','--','LineWidth', 0.2);
colorbar;
xlabel('Radial direction (m)');
ylabel('Axial direction (m)');
xticks(tickValues);
yticks(tickValues);
xticklabels(tickLabels);
yticklabels(tickLabels);
set(gca, 'FontSize', 20);  % Set font size for tick labels
distance = 0.08;
function [ppm]=obj(x)
    xxJ = 125740471.666;
    gap1=0.024091;
    gap2=0.066244;
    gap3=0.010073;
    gap4=0.024409;
    width1=0.010490;
    width2=0.021678;
    width3=0.022064;
    width4=0.026702;
                    [Brr1, Bzz1] = SolB(0.176,0.176+width1, gap1, gap1+0.022, xxJ, x(1), x(2));
                    %-1번
                    [Brr11, Bzz11] = SolB(0.176,0.176+width1,-gap1, -(gap1+0.022), xxJ, x(1), x(2));
                    %2번
                    [Brr2, Bzz2] = SolB(0.176,0.176+width2,gap1+0.022+gap2,gap1+0.022+gap2+0.025, xxJ, x(1), x(2));
                    %-2번
                    [Brr22, Bzz22] = SolB(0.176,0.176+width2, -(gap1+0.022+gap2), -(gap1+0.022+gap2+0.025), xxJ, x(1), x(2));
                    [Brr3, Bzz3] = SolB(0.176,0.176+width3,gap1+0.022+gap2+0.025+gap3,gap1+0.022+gap2+0.025+gap3+0.023, xxJ, x(1), x(2));
                    [Brr33, Bzz33] = SolB(0.176,0.176+width3, -(gap1+0.022+gap2+0.025+gap3),-(gap1+0.022+gap2+0.025+gap3+0.023), xxJ, x(1), x(2));
                    [Brr4, Bzz4] = SolB(0.176,0.176+width4, gap1+0.022+gap2+0.025+gap3+0.023+gap4, gap1+0.022+gap2+0.025+gap3+0.023+gap4+0.036, xxJ, x(1), x(2));
                    [Brr44, Bzz44] = SolB(0.176,0.176+width4, -(gap1+0.022+gap2+0.025+gap3+0.023+gap4), -(gap1+0.022+gap2+0.025+gap3+0.023+gap4+0.036), xxJ, x(1), x(2));
                    % Calculate total magnetic field in the z-direction
                    TotalBzz = Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22)-Bzz3-abs(Bzz33)+Bzz4+abs(Bzz44);
                    ppm = (abs(TotalBzz-0.5) / (2*(TotalBzz + 0.5))) * 10^6;
                    if ppm > 10
                        ppm = 0;
                    end
                    endn
function g=con(x)
% x^2 + y^2 = 0.08^2
    circle_equation=x(1).^2+x(2).^2;
    g= circle_equation <=0.08^2;
end

%[ppm]=extremity_homogeneity_calculation(0.02,0.07,0.013,0.02)
%in paper: [ppm]=extremity_homogeneity_calculation(0.02,0.056,0.013,0.02)
%0.01, 0.01, 0.01, 0.01