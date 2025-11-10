 function [ppm]=field_homogeneity_optimization(a1,a2,b11,b22)
%자석 2개로 쪼개기
%b1,b2 사이에 지점, b11, b22 b11점을 계속 옮기면서 균일도가 가장 낮은 지점을 찾기


Bzmin = 1000000;
Bzmax = 0;
xxJ = 161000000;
distance=0.225;
minppm=1000000000000000;
optb21=0;
optgap=0;
optBz=0;
%new
%b12=b21-gap;
%(a1,a2,b11, b21-gap), (a1,a2,b21,b22) <-- 두 자석의 좌표들

for b21=b11+0.0001:0.01:b22 %0.01 --> 0.05
    for gap=0.0001:0.005:(b22-b11)/5 %0.005 --> 0.01
        for angle=0:0.01:(pi/2) %0.01 --> 0.1
            x = distance*cos(angle);
            y = distance*sin(angle);
            b12=b21-gap;
            %원점에서 가까운 자석
            [Brr1,Bzz1]=SolB(a1,a2,b11,b12,xxJ,x,y);
            %위 자석을 x-axis 기준 뒤집은 위치에 있는 자석
            [Brr11,Bzz11]=SolB(a1,a2,-b11,-b12,xxJ,x,y);
            %원점 멀리있는 자석
            [Brr2,Bzz2]=SolB(a1,a2,b21,b22,xxJ,x,y);
            %위자석을 x-axis 기준 뒤집은 위치에 있는 자석
            [Brr22,Bzz22]=SolB(a1,a2,-b21,-b22,xxJ,x,y);
            TotalBzz=Bzz1+abs(Bzz11)+Bzz2+abs(Bzz22);
            if Bzmin>TotalBzz
                Bzmin=TotalBzz;
            end
            if Bzmax<TotalBzz
                Bzmax=TotalBzz;
            end
            ppm=((Bzmax-Bzmin)/(Bzmax+Bzmin))*10^6;
            

            %if ppm <100 && Bzmin>1.5
                %disp("b12 is "+b12+". b21 is "+b21)
                %disp("ppm is" +ppm)
            %end
        end %for angle=0:0.01:(pi/2)
        if minppm>ppm && ppm~=0 && Bzmax>1
                minppm=ppm;
                optb21=b21;
                optgap=gap;
                optBz=Bzmax;
        end
    end %gap=0:0.005:b2-b1
end %b21=0:0.01:b22
disp("minimum when gap is "+optgap+" and b21 is "+optb21)
disp("min ppm is "+minppm)
disp("max Bz here is " +optBz)
%[ppm]=field_homogeneity_optimization(0.48181818181,0.51818181817,0.1,0.25)
