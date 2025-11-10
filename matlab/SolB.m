function [Brr,Bzz]=SolB(aa1,aa2,bb1,bb2,xxJ,rr,zz)
nGS=16;
[x,w] = lgwt(nGS,-1,1);
if ((rr<=aa1)||(rr>=aa2))
    ncase=1;
else
    ncase=2;
end
if (ncase==1)
    Br=0.0; Bz=0.0;
    for i=1:nGS
        for j=1:nGS
            aa = 0.5*(aa2-aa1)*x(i)+0.5*(aa2+aa1);
            bb = 0.5*(bb2-bb1)*x(j)+0.5*(bb2+bb1);
            R = sqrt((rr-aa)^2 + (zz-bb)^2);
            Br = Br + (zz-bb)/(R^3)*aa;
            Bz = Bz + (rr-aa)/(R^3)*aa;
        end
    end
    Brr = 0.5*(aa2-aa1)*0.5*(bb2-bb1)*xxJ*Br;
    Bzz = 0.5*(aa2-aa1)*0.5*(bb2-bb1)*xxJ*Bz;
else
    Br=0.0; Bz=0.0;
    for i=1:nGS
        for j=1:nGS
            aa = 0.5*(rr-aa1)*x(i)+0.5*(rr+aa1);
            bb = 0.5*(bb2-bb1)*x(j)+0.5*(bb2+bb1);
            R = sqrt((rr-aa)^2 + (zz-bb)^2);
            Br = Br + (zz-bb)/(R^3)*aa;
            Bz = Bz + (rr-aa)/(R^3)*aa;
        end
    end
    Brr = 0.5*(rr-aa1)*0.5*(bb2-bb1)*xxJ*Br;
    Bzz = 0.5*(rr-aa1)*0.5*(bb2-bb1)*xxJ*Bz;
    Br2=0.0; Bz2=0.0;
    for i=1:nGS
        for j=1:nGS
            aa = 0.5*(aa2-rr)*x(i)+0.5*(aa2+rr);
            bb = 0.5*(bb2-bb1)*x(j)+0.5*(bb2+bb1);
            R = sqrt((rr-aa)^2 + (zz-bb)^2);
            Br2 = Br2 + (zz-bb)/(R^3)*aa;
            Bz2 = Bz2 + (rr-aa)/(R^3)*aa;
        end
    end
    Brr = Brr + 0.5*(aa2-rr)*0.5*(bb2-bb1)*xxJ*Br2;
    Bzz = Bzz + 0.5*(aa2-rr)*0.5*(bb2-bb1)*xxJ*Bz2;
end
end
