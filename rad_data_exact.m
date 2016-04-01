% Code to generate Radon data using exact measure of line segments of intersection
% of the broken ray with a disk.

function [g,a] = rad_data_exact(per)

% Discretizing beta and t


[M1,N,theta,R,t_in] = parameters;

t = linspace(t_in,R,M1);
step = t(2)-t(1);

beta = linspace(0,2*pi,N);
step_beta = beta(2)-beta(1);


% Center of the disk.
a1 = 0.2;
a2 = 0.2;
% Radius of the disk
rad_disk = 0.15;

for j = 1:M1
    for l = 1:N
        % Defining the phantom in polar coordinates.
        x2 = t(j)*cos(beta(l));
        y2 = t(j)*sin(beta(l));
        if(((x2-a1)^2+ (y2-a2)^2) < rad_disk^2)
            a(j,l) = 1.0;
        else
            a(j,l) = 0.0;
        end


    end
end
% Plotting the phantom in cartesian coordinates.
[TH,RA] = meshgrid(beta, t);
[X,Y,F] = pol2cart(TH,RA,a);

figure(1)
colormap(flipud(gray));
surfc(X,Y,F,'EdgeColor','none');
view(0,90);

% Initializing the matrix of the Radon data.
g = zeros(M1,N);

% Generating the Radon data
for k = 1:M1 % Fixing t.
    for l = 1:N % Fixing beta
        fprintf('k = %d, l = %d \n',k,l);
        g(k,l) = g(k,l) + ray_disk_int(a1,a2,rad_disk,theta,beta(l),t(k));
    end
    g(k,:) = g(k,:) + per/100*randn(1,N);
end

% Writing the Radon data to a file.
dlmwrite('Radon_data_disk',g);

% Plotting the Radon data in polar coordinates.
figure(2)
surf(beta,t,g);

xlabel('beta');
ylabel('t');
str = sprintf('Radon data for circle centerd at (%.2f,%.2f)',a1,a2);
title(str);
view (0,90);
