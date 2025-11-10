function [ppm]=extremity_calculation1(gap1,gap2,gap3,gap4)
Bzmin = 1000000;
Bzmax = 0;
xxJ = 377221414.999;
distance = 0.08;
width1=0.187;
width2=0.196;
width3=0.197;
width4=0.206;
for angle = 0:0.05:(pi/2)
    x = distance * cos(angle);
    y = distance * sin(angle);
    [~, Bzz1] = SolB(0.176,width1, gap1, gap1+0.022, xxJ, x, y);
    [~, Bzz11] = SolB(0.176,width1,-gap1, -(gap1+0.022), xxJ, x, y);
    [~, Bzz2] = SolB(0.176,width2,gap1+0.022+gap2, gap1+0.022+gap2+0.0237, xxJ, x, y);
    [~, Bzz22] = SolB(0.176,width2, -(gap1+0.022+gap2), -(gap1+0.022+gap2+0.0237), xxJ, x, y);
    [~, Bzz3] = SolB(0.176,width3,gap1+0.022+gap2+0.0237+gap3, gap1+0.022+gap2+0.0237+gap3+0.0173, xxJ, x, y);
    [~, Bzz33] = SolB(0.176,width3, -(gap1+0.022+gap2+0.0237+gap3), -(gap1+0.022+gap2+0.0237+gap3+0.0173), xxJ, x, y);
    [~, Bzz4] = SolB(0.176,width4,gap1+0.022+gap2+0.0237+gap3+0.0173+gap4, gap1+0.022+gap2+0.0237+gap3+0.0173+gap4+0.0234, xxJ, x, y);
    [~, Bzz44] = SolB(0.176,width4, -(gap1+0.022+gap2+0.0237+gap3+0.0173+gap4), -(gap1+0.022+gap2+0.0237+gap3+0.0173+gap4+0.0234), xxJ, x, y);
    Bzz = Bzz1 + Bzz11 + Bzz2 + Bzz22 + Bzz3 + Bzz33 + Bzz4 + Bzz44;
    if Bzz > Bzmax
        Bzmax = Bzz;
    end
    if Bzz < Bzmin
        Bzmin = Bzz;
    end
end
ppm = (Bzmax - Bzmin)/(Bzmax+Bzmin)*1e6;
end
