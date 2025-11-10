function [ppm]=field_homogeneity_calculation(a1,a2,b1,b2)
%function [Brr,Bzz]=SolB(aa1,aa2,bb1,bb2,xxJ,rr,zz)
%a1a2b1b2를 이 function에 넣으면 Bz가 max인 지점과 min인 지점을 반복문을 통해서 알아낸
%다음 그 둘을 사용해서 균일도 ppm을 계산해줌

Bzmin = 1000000;
Bzmax = 0;
xxJ = 161000000;
miny = 0;
minx = 0;
maxx=0;
maxy=0;
distance=0.225;

for angle=0:0.01:(pi/2)
    x = distance*cos(angle);
    y = distance*sin(angle);
    [Brr,Bzz]=SolB(a1,a2,b1,b2,xxJ,x,y);
    [Brr1,Bzz2]=SolB(a1,a2,-b1,-b2,xxJ,x,y);
    if Bzmin>Bzz+abs(Bzz2)    
        Bzmin=Bzz+abs(Bzz2);
        minx=x;
        miny=y;
    end
    if Bzmax<Bzz+abs(Bzz2)
        Bzmax=Bzz+abs(Bzz2);
        maxx=x;
        maxy=y;
    end
    %disp(x)
end

ppm=((Bzmax-Bzmin)/(Bzmax+Bzmin))*10^6;

disp("Bzmin is "+Bzmin)
disp("Bzmax is "+Bzmax)
disp("max coordinate is ("+maxx+", "+maxy+")")
disp("min coordinate is ("+minx+", "+miny+")")



%[ppm]=field_homogeneity_calculation(0.48181818181,0.51818181817,0.1,0.7)