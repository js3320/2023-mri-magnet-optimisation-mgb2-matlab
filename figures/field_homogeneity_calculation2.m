function [ppm]=field_homogeneity_calculation2(a1,a2,b11,b12,b21,b22)
        
%자석 2개로 쪼개기
%b11-b12가 1번 자석, b21-b22가 2번 자석

% Constants
Bzmin = 1000000;
Bzmax = 0;
xxJ = 161000000;
distance = 0.225;
    % Loop through angles from 0 to pi/2
    for angle = 0:0.1:(pi/2)
        x = distance * cos(angle);
        y = distance * sin(angle);
        
        %원점에서 가까운 자석
        [Brr1, Bzz1] = SolB(a1, a2, b11, b12, xxJ, x, y);
        %위 자석을 x-axis 기준 뒤집은 위치에 있는 자석
        [Brr11, Bzz11] = SolB(a1, a2, -b11, -b12, xxJ, x, y);
        %원점 멀리있는 자석
        [Brr2, Bzz2] = SolB(a1, a2, b21, b22, xxJ, x, y);
        %위자석을 x-axis 기준 뒤집은 위치에 있는 자석
        [Brr22, Bzz22] = SolB(a1, a2, -b21, -b22, xxJ, x, y);

        % Calculate total magnetic field in the z-direction
        TotalBzz = Bzz1 + abs(Bzz11) + Bzz2 + abs(Bzz22);

        % Update minimum and maximum magnetic field values
        if Bzmin > TotalBzz
            Bzmin = TotalBzz;
        end
        if Bzmax < TotalBzz
            Bzmax = TotalBzz;
        end

        % Calculate ppm field homogeneity
        ppm = ((Bzmax - Bzmin) / (Bzmax + Bzmin)) * 10^6;
    end % for angle=0:0.1:(pi/2)
    disp("Bzmax = "+Bzmax)
end

%[ppm]=field_homogeneity_calculation2(0.48181818181,0.51818181817,0.1,0.25)