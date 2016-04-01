function val = K1(t,theta,n,psi)

if(t == 1)
    val = 1;
else
    num1 = 1+t*cos(psi)+t^2*sin(psi)*sin(theta)/sqrt(1-t^2*(sin(theta))^2);
    den1 = sqrt(1+t^2+2*t*cos(psi));
    num2 = 1-t*cos(2*theta-psi)+t^2*sin(2*theta-psi)*sin(theta)/sqrt(1-t^2*(sin(theta))^2);
    den2 = sqrt(1+t^2-2*t*cos(2*theta-psi));
    
    val = (-1)^(n-1)*exp(-1j*(n-1)*psi)*num1/den1 ...
        - exp(-1j*(n-1)*(2*theta-psi))*num2/den2;
end
