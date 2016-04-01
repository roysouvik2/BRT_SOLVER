% Driver code to invert a broken ray transform 
clear all;

% Percentage of white Gaussian noise
per = 0;
% Evaluating the Radon data.
[g,a] = rad_data_exact(per);    
%g = rad_data_pixelated();

% Preprocessing step.
start_time_pp = cputime;
% Evaluating the inverse of the Radon matrix
inv_B = matrix_inverse;
preprocessing_time = cputime-start_time_pp;

% Inversion step.
start_time = cputime;
% Evaluating the fourier transform of the Radon Data.
%gdis1 = fourier_transform(g);

gdis1 = fourier_transform(g);

% Inverting the Radon transform
[rfun, t, beta] = inversion(gdis1,inv_B);

inversion_time = cputime-start_time;

%Computational Times.
fprintf('The time taken for the preprocessing step is %.2f\n',preprocessing_time);
fprintf('The time taken for the inversion step is %.2f\n',inversion_time);

% Measuring the discrete relative L^2 error inside the stability disk.

err = l2_error(a,rfun,t,beta);

% Percentage of relative error

fprintf('The relative error is %.2f %% \n', err*100);

