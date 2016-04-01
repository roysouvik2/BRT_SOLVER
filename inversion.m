% Solving the Integral equation.
function [rfun,t,beta] = inversion(gdis1,inv_B)

% Renaming the input fourier transform data.
Gn = gdis1;


[M,N,theta,R,t_in] = parameters;

% Discretizations.
t = linspace(t_in,R,M);
beta = linspace(0,2*pi,N);

step = t(2)-t(1);

% Inversion procedure for first half of the frequency modes.
for num  = 1:(N+1)/2
    num
    
    
    % Right hand side of the matrix equation consisting of the fourier
    % data.
    g = Gn(:,num);
    for j = 1:M
        gm(j) = g(j);
    end
    
    % Inverting the matrix A to find the solution.
    invf(:,num) = inv_B(:,:,num)*gm';
    
    clear gm;
    
end
invf(:,1)

% Determining the values for the second half of the frequencies using
% conjugacy.
for j = 1:M
    for num = (N+1)/2+1:N
        invf(j,num) = conj(invf(j,N-num+2));
    end
end

% Computing the inverse Fourier transform.
j = 1;
while(j <= M)
    rfun1(j,:) = ifft(invf(j,:));
    j = j+1;
end

for i = 1:M
    for j = 1:N
        rfun(i,j) = rfun1(i,N-j+1);
    end
end
% Plotting the solution.
[TH R] = meshgrid(beta, t);
[X,Y,FIN] = pol2cart(TH,R,rfun);

% for i = 1:M
%     for j = 1:N
%         final(i,j) = FIN(i,N-j+1);
%     end
% end

figure(4)
colormap(flipud(gray));

surf(X,Y,FIN,'EdgeColor','none')
view(0,90);

