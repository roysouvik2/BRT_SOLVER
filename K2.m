function val = K2(t,theta,n,psi)

num1 = 1+t*cos(psi)+t^2*sin(psi)*sin(theta)/sqrt(1-t^2*(sin(theta))^2);
den1 = sqrt(1+t^2+2*t*cos(psi));


val = (-1)^(n-1)*exp(-1j*(n-1)*psi)*num1/den1;
      