function LE=getLegendre(n,m,theta)
X = cos(theta);
A = legendre(n,X);
if n == 0
    LE = A;
else
    LE = A(m+1);
end
