% General Version--- Pixelated.
% Code to generate Radon data using measure of line segments of intersection
% of the broken ray with a pixel.

function g = rad_data_pixelated()

clear all;
% Discretizing beta and t

[M1,N,theta,R,t_in] = parameters;

t = linspace(t_in,R,M1);
step = t(2)-t(1);

beta = linspace(0,2*pi,N);
step_beta = beta(2)-beta(1);


% Coordinates of the square
x1 = -0.1;
x2 = 0.8;
y1 = -0.1;
y2 = 0.1;

% Generating pixel matrix
M = 151;
for i = 1:M
    for j = 1:M
        x(i) = -1+2*(i-1)/(M-1); % (x(i),y(j))---> Center of the pixel.
        y(j) = -1+2*(j-1)/(M-1);
        if(x1 <= x(i) && x2 >= x(i) && y1 <= y(j) && y2 >= y(j))
           a(i,j) = 1;
        else
           a(i,j) = 0;
        end
    end
end

% Plotting the phantom.
figure(1)
colormap(flipud(gray));
surfc(x,y,a','EdgeColor','none');
view(0,90);


% Length of each pixel
h = 2/(M-1);

% Initializing the matrix of the Radon data.
g = zeros(M1,N);

% Generating the Radon data
for k = 1:M1 % Fixing t.
    for l = 1:N % Fixing beta
        fprintf('k = %d, l = %d \n',k,l);
        %Running through each pixel
        for i = 1:M
            for j = 1:M
                g(k,l) = g(k,l) + a(i,j)*pix_meas(x(i),y(j),h,theta,beta(l),t(k));
            end
        end
    end
end

% Writing the Radon data to a file.
dlmwrite('Radon_data_square.txt',g);

figure(2)
surf(beta,t,g);

xlabel('beta');
ylabel('t');
str = sprintf('Radon data for square centerd');
title(str);
view (0,90);
