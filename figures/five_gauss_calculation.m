function [Bz]=five_gauss_calculation(gap1,gap2,gap3,gap4,width1,width2,width3,width4)
        
% Constants

%wire size (0.5mmx0.8mm), operating current: 180A
xxJ = 125740471.666;

    % Loop through angles from 0 to pi/2
x=2.8;
y=0.41;
                    %1번
                    [Brr1, Bzz1] = SolB(0.176,0.176+width1, gap1, gap1+0.022, xxJ, x, y);
                    %-1번
                    [Brr11, Bzz11] = SolB(0.176,0.176+width1,-gap1, -(gap1+0.022), xxJ, x, y);
                    %2번
                    [Brr2, Bzz2] = SolB(0.176,0.176+width2,gap1+0.022+gap2,gap1+0.022+gap2+0.025, xxJ, x, y);
                    %-2번
                    [Brr22, Bzz22] = SolB(0.176,0.176+width2, -(gap1+0.022+gap2), -(gap1+0.022+gap2+0.025), xxJ, x, y);
                    [Brr3, Bzz3] = SolB(0.176,0.176+width3,gap1+0.022+gap2+0.025+gap3,gap1+0.022+gap2+0.025+gap3+0.023, xxJ, x, y);
                    [Brr33, Bzz33] = SolB(0.176,0.176+width3, -(gap1+0.022+gap2+0.025+gap3),-(gap1+0.022+gap2+0.025+gap3+0.023), xxJ, x, y);
                    [Brr4, Bzz4] = SolB(0.176,0.176+width4, gap1+0.022+gap2+0.025+gap3+0.023+gap4, gap1+0.022+gap2+0.025+gap3+0.023+gap4+0.036, xxJ, x, y);
                    [Brr44, Bzz44] = SolB(0.176,0.176+width4, -(gap1+0.022+gap2+0.025+gap3+0.023+gap4), -(gap1+0.022+gap2+0.025+gap3+0.023+gap4+0.036), xxJ, x, y);
                    % Calculate total magnetic field in the z-direction
                   
                    Bz = (abs(Bzz1) + abs(Bzz11) + abs(Bzz2) + abs(Bzz22)-abs(Bzz3)-abs(Bzz33)+abs(Bzz4)+abs(Bzz44))*10000;
                    %TotalBzz = Bzz1 + Bzz2 -Bzz3 +Bzz4;
                    %for x=2:0.1:3.5
                        %for y=2:0.1:3.5
                            %if TotalBzz>5
                                
                            %end
                     %   end
                    %end


%[Bz]=five_gauss_calculation(0.024091,0.066244,0.010073,0.024409,0.010490,0.021678,0.022064,0.026702)

%x=0;
%y=3.67;
%Bz =5.0033

%x=2.89;
%y=0;
%Bz = 5.0033

%x=1.8;
%y=0.9642;
%Bz=5.0010;

%x=1.69;
%y=2.22;
%Bz=5.0150

%x=1;
%y=3.36;
%Bz=5.0280

%x=2;
%y=0.96;
%Bz = 5.0254

%x=2.5;
%y=0.775;
%Bz=5.0060

%x=2.2;
%y=0.92;
%Bz = 5.0336

