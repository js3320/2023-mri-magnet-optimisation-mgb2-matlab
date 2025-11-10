function [Brr,Bzz]=SolB(aa1,aa2,bb1,bb2,xxJ,rr,zz)
%	double precision aa1,aa2,bb1,bb2,xxJ,rr, zz	
%	double precision a(nGS),xb(2),xJs(2),x(8),w(8)
nGS=16;
[x,w] = lgwt(nGS,-1,1);
%{
	x(1)=-.960289856497536D0;
	x(2)=-.796666477413627D0;
	x(3)=-.525532409916329D0;
	x(4)=-.183434642495650D0;
	x(5)=.183434642495650D0;
	x(6)=.525532409916329D0;
	x(7)=.796666477413627D0;
	x(8)=.960289856497536D0;

	w(1)=0.101228536290376D0;
	w(2)=0.222381034453374D0;
	w(3)=0.313706645877887D0;
	w(4)=0.362683783378362D0;
	w(5)=0.362683783378362D0;
	w(6)=0.313706645877887D0;
	w(7)=0.222381034453374D0;
	w(8)=0.101228536290376D0;   
	%}

	if ((rr<=aa1)|(rr>=aa2)) 
        ncase=1;  %no subsection is required.
    else
        ncase=2;	 %subsection is required.
    end

	if (ncase==1)
        Br=0.0d0;
        Bz=0.0d0;
        
        xJs(1)=xxJ;
        xJs(2)=-xxJ;
        
        a22=aa2;
        a11=aa1;
        xb(1)=bb1;
        xb(2)=bb2;
        
        r=rr;
        z=zz;

 for i=1:nGS
     for kI=1:2 %! Two Point Current sources in a single ideal solenoid
        
        h=xb(kI);
        a(i)=0.5d0*(a11+a22)+0.5d0*(a22-a11)*x(i);
        xk=sqrt(4.0d0*a(i)*r/((r+a(i))^2.0d0+(z-h)^2.0));

%%	call EllipticINT(xk**2,a(i),r)	
%	subroutine EllipticINT(xk,aa,rrr)
    xk=xk^2;
    aa=a(i);
    rrr=r;
	a0=1.0d0;
	b0=sqrt(1.0d0-xk);	
	s0=xk;
	sG=0.5d0*(a0-b0)^2.0d0; % Garrett's S which is different from that of MATLAB Ellipke
	cSQ=4.0d0*aa*rrr/(aa+rrr)^2.0d0;
	cPSQ=((aa-rrr)^2.0d0)/((aa+rrr)^2.0d0);	
	zeta0=0;
	eps0=cSQ/cPSQ;
	delta0=cPSQ/b0;
	ii=0;
	ERref=1.0d-10;
	ResER=1.0d0;
	mm=1;

while ((ResER>=ERref)|(abs(1.0d0-delta0)>=ERref)) 
	a1=(a0+b0)/2.0d0;
	b1=sqrt(a0*b0);
	c1=(a0-b0)/2.0d0;
	delta1=b1*(2.0d0+delta0+1.0d0/delta0)/(4.0d0*a1);
	eps1=(delta0*eps0+zeta0)/(1+delta0);
	zeta1=0.5d0*(eps0+zeta0);
	ii=ii+1;
	s0=s0+(2.0d0^ii)*(c1^2.0d0);
	sG=sG+(2.0d0^(ii-1))*(a1-b1)^2.0d0;
	a0=a1;
	b0=b1;
	delta0=delta1;
	eps0=eps1;
	zeta0=zeta1;
	ResER=(2.0d0^ii)*(c1^2.0d0);
end   
	sINF=sG; 
	alphaINF=a0;
	betaINF=b0;
	epsINF=eps0;
	zetaINF=zeta0;
	deltaINF=delta0;
	xKfirst=pi/(2.0d0*a1);
	xEsecond=xKfirst*(1.0d0-s0/2.0d0);

%%  Br calculation
	temp=pi*1.0d-7*sqrt((a(i)+r)^2+(z-h)^2)*sINF;
 	if (r/a11<1.0d-6)
        Br=0.0d0;
    else
        Br=Br-0.5d0*(a22-a11)*w(i)*temp/(2.0d0*r*alphaINF)*xJs(kI);
    end

%%   Bz calculation
	temp1=pi*1.0d-7*(z-h);
	temp2=2.0d0*a(i)+(a(i)-r)*zetaINF;
	temp3=(r+a(i))*sqrt((a(i)+r)^2+(z-h)^2)*alphaINF;
	Bz=Bz+0.5d0*(a22-a11)*w(i)*temp1*temp2/temp3*xJs(kI);
     end % kI 
 end % nGS
 
%% ncase ==2 
    elseif (ncase==2) 
        Br=0.0d0;
        Bz=0.0d0;
        xJs(1)=xxJ;
        xJs(2)=-xxJ;
    for iSUB=1:2
	if (iSUB==1) 
        a22=rr;
        a11=aa1;
	elseif (iSUB==2)
        a22=aa2;
        a11=rr;
    end
	xb(1)=bb1;
	xb(2)=bb2;
	r=rr;
	z=zz;	
	for i=1:nGS
	for kI=1:2 % ! Two Point Current sources in a single ideal solenoid
 	h=xb(kI);
	a(i)=0.5d0*(a11+a22)+0.5d0*(a22-a11)*x(i);
	xk=sqrt(4.0d0*a(i)*r/((r+a(i))^2.0d0+(z-h)^2.0));	
%%	call EllipticINT(xk**2,a(i),r)	
%	subroutine EllipticINT(xk,aa,rrr)
    xk=xk^2;
    aa=a(i);
    rrr=r;
	a0=1.0d0;
	b0=sqrt(1.0d0-xk);	
	s0=xk;
	sG=0.5d0*(a0-b0)^2.0d0; % Garrett's S which is different from that of MATLAB Ellipke
	cSQ=4.0d0*aa*rrr/(aa+rrr)^2.0d0;
	cPSQ=((aa-rrr)^2.0d0)/((aa+rrr)^2.0d0);	
	zeta0=0;
	eps0=cSQ/cPSQ;
	delta0=cPSQ/b0;
	ii=0;
	ERref=1.0d-10;
	ResER=1.0d0;
	mm=1;

while ((ResER>=ERref)|(abs(1.0d0-delta0)>=ERref)) 
	a1=(a0+b0)/2.0d0;
	b1=sqrt(a0*b0);
	c1=(a0-b0)/2.0d0;
	delta1=b1*(2.0d0+delta0+1.0d0/delta0)/(4.0d0*a1);
	eps1=(delta0*eps0+zeta0)/(1+delta0);
	zeta1=0.5d0*(eps0+zeta0);
	ii=ii+1;
	s0=s0+(2.0d0^ii)*(c1^2.0d0);
	sG=sG+(2.0d0^(ii-1))*(a1-b1)^2.0d0;
	a0=a1;
	b0=b1;
	delta0=delta1;
	eps0=eps1;
	zeta0=zeta1;
	ResER=(2.0d0^ii)*(c1^2.0d0);
end   
	sINF=sG; 
	alphaINF=a0;
	betaINF=b0;
	epsINF=eps0;
	zetaINF=zeta0;
	deltaINF=delta0;
	xKfirst=pi/(2.0d0*a1);
	xEsecond=xKfirst*(1.0d0-s0/2.0d0);
%%    
	temp=pi*1.0d-7*sqrt((a(i)+r)^2+(z-h)^2)*sINF;
 	if (r/a11<1.0d-6) 
        Br=0.0d0;
    else
        Br=Br-0.5d0*(a22-a11)*w(i)*temp/(2.0d0*r*alphaINF)*xJs(kI);
    end

 	temp1=pi*1.0d-7*(z-h);
 	temp2=2.0d0*a(i)+(a(i)-r)*zetaINF;
	temp3=(r+a(i))*sqrt((a(i)+r)^2+(z-h)^2)*alphaINF;
	Bz=Bz+0.5d0*(a22-a11)*w(i)*temp1*temp2/temp3*xJs(kI);

    end % kI
    end % nGS
    end % iSUB --> for subdivision when a target point resides inside the coil section						
    end % ncase
    Brr=Br;
    Bzz=Bz;
    %disp(Bzz)
%function [Brr,Bzz]=SolB(aa1,aa2,bb1,bb2,xxJ,rr,zz)
%[Brr, Bzz] = SolB(0.176,0.176+0.024409,0.024091+0.022+0.066244+0.025+0.010073+0.023+0.024409,0.024091+0.022+0.066244+0.025+0.010073+0.023+0.024409+0.036,450000000,0.1760,0.2128);