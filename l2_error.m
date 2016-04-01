function val = l2_error(a,rfun,t,beta)

[M,N,theta,R,t_in] = parameters;

% Finding the radius of the stability disk
rad_stab = R*sin(theta);

err = zeros(M,N);
func_norm = zeros(M,N);
for i = 1:M
    for j = 1:N
        x = t(i)*cos(beta(j));
        y = t(i)*sin(beta(j));
        if((x^2+y^2) < (rad_stab-0.001)^2 && (x^2+y^2) >=0.001)
            err(i,j) = a(i,j)-rfun(i,j);
            func_norm(i,j) = a(i,j);
        end
    end
end
val = norm(err,2)/norm(func_norm,2);