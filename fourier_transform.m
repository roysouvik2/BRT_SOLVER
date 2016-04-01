% Determining the discrete fourier transform of Radon data.
function gdis1  = fourier_transform(g)

[M,N,theta,R,t_in] = parameters;

t = linspace(t_in,R,M);
beta = linspace(0,2*pi,N);

% Initializing the matrix of the Fourier transform to zero.
gdis1 = zeros(M,N);

j = 1;
while(j <= M) % Calculating the discrete fourier transform for each rho.
    gdis1(j,:) = fft(g(j,:));
    j = j+1;
end

% Writing the Fourier transform data to a file.
dlmwrite('fourier_transform_data.txt',gdis1)


% Plotting the Fourier transform for some frequencies.
Narr = linspace(0, (N+1)/2-1, N); % Half of the frequency domain.

% step_j = [1 40 80 120];
% j = 1;
% while(j <= 4)
%     subplot(2,2,j)
%     semilogy(Narr(1:(N+1)/2), abs(gdis1(step_j(j),1:(N+1)/2)));
%     hold off;
%     xlabel('N');
%     ylabel('FT');
%     title(sprintf('t = %.2f',t(step_j(j))));
%     j = j+1;
%     axis tight;
% end
