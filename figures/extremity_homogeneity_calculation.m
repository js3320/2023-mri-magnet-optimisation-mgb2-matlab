function [ppm]=extremity_calculation1(gap1,gap2,gap3,gap4)
        
%자석 4개로 나누기 1,2,3,4 번 자석이 있고, 1,2,3,4개의 gap 두깨는 논문 참고, gap을 돌려보기
% Constants
Bzmin = 1000000;
Bzmax = 0;
%wire size (0.5mmx0.8mm), operating current: 180A
xxJ = 377221414.999;

distance = 0.08;
width1=0.187;
width2=0.196;
width3=0.197;
width4=0.206;
    % Loop through angles from 0 to pi/2
                for angle = 0:0.05:(pi/2)
                    x = distance * cos(angle);
                    y = distance * sin(angle);
                    %1번
                    [Brr1, Bzz1] = SolB(0.176,width1, gap1, gap1+0.022, xxJ, x, y);
                    %-1번
                    [Brr11, Bzz11] = SolB(0.176,width1,-gap1, -(gap1+0.022), xxJ, x, y);
                    %2번
                    [Brr2, Bzz2] = SolB(0.176,width2,gap1+0.022+gap2,gap1+0.022+gap2+0.025, xxJ, x, y);
                    %-2번
                    [Brr22, Bzz22] = SolB(0.176,width2, -(gap1+0.022+gap2), -(gap1+0.022+gap2+0.025), xxJ, x, y);
                    [Brr3, Bzz3] = SolB(0.176,width3,gap1+0.022+gap2+0.025+gap3,gap1+0.022+gap2+0.025+gap3+0.023, xxJ, x, y);
                    [Brr33, Bzz33] = SolB(0.176,width3, -(gap1+0.022+gap2+0.025+gap3),-(gap1+0.022+gap2+0.025+gap3+0.023), xxJ, x, y);
                    [Brr4, Bzz4] = SolB(0.176,width4, gap1+0.022+gap2+0.025+gap3+0.023+gap4, gap1+0.022+gap2+0.025+gap3+0.023+gap4+0.036, xxJ, x, y);
                    [Brr44, Bzz44] = SolB(0.176,width4, -(gap1+0.022+gap2+0.025+gap3+0.023+gap4), -(gap1+0.022+gap2+0.025+gap3+0.023+gap4+0.036), xxJ, x, y);
                    % Calculate total magnetic field in the z-direction
                   
                    TotalBzz = Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22)-Bzz3-abs(Bzz33)+Bzz4+abs(Bzz44);
                    %TotalBzz = Bzz1 + Bzz2 -Bzz3 +Bzz4;
            
                    % Update minimum and maximum magnetic field values
                    if Bzmin > TotalBzz
                        Bzmin = TotalBzz;
                    end
                    if Bzmax < TotalBzz
                        Bzmax = TotalBzz;
                    end
            
                    % Calculate ppm field homogeneity
                    ppm = ((Bzmax - Bzmin) / (2*(Bzmax + Bzmin))) * 10^6;

                end % for angle=0:0.1:(pi/2)
                disp("Bzmax is "+Bzmax)
                disp("Bzmin is "+Bzmin)
%[ppm]=extremity_homogeneity_calculation(0.02,0.07,0.013,0.02)
%in paper: [ppm]=extremity_homogeneity_calculation(0.02,0.056,0.013,0.02)
%0.01, 0.01, 0.01, 0.01