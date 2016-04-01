% Solving the Integral equation.
function inv_B = matrix_inverse()

[M,N,theta,R,t_in] = parameters;

% Discretizations.
t = linspace(t_in,R,M);
beta = linspace(0,2*pi,N);

step = t(2)-t(1);

% Inversion procedure for first half of the frequency modes.
for num  = 1:(N+1)/2
    num
    
    % Computing the matrix A .
    A = zeros(M,M);
    for i = 1:M
        i;
        % Determine the value of l.
        l = search_list(i,t,theta);
        for j = l:i
            j;
            if(i == l || i == M)
                coeff = 0.5*step;
            else
                coeff = step;
            end
            psi = asin(t(i)/t(j)*sin(theta))+theta;
            A(i,j) = coeff*K1(t(i)/t(j),theta,num,psi);
        end
        for j = i+1:M
            if(i == l || i == M)
                coeff = 0.5*step;
            else
                coeff = step;
            end
            psi = asin(t(i)/t(j)*sin(theta))+theta;
            A(i,j) = coeff*(1+K2(t(i)/t(j),theta,num,psi));
        end
    end
    cond(A);
    % SVD of the matrix A.
    [U, S, V] = svd(A);
    S1 = zeros(M,M);
    
    % Truncated SVD of A.
    for i = 1:M
        diag_svd(i) = S(i,i);
        if(i <= M/2)
            S1(i,i) = 1/S(i,i);
        else
            S1(i,i) = 0;
        end
    end
    
    % Pseudoinverse of A.
    inv_B(:,:,num) = V*S1*U';
end
