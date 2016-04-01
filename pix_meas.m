% Determining the measure of the broken ray in a square pixel.
function val = pix_meas(a,b,h,theta,beta,t)

% Notations:

% ABCD represents the square pixel.

% (x1,y2) D  ________ C (x2,y2)
%           |        |
%           |   .    |
%           |  (a,b) |
% (x1,y1) A |________|B (x2,y1)
%           <-------->   
%               h

% AD is the bottom horizontal side.
% BC is the right verical side.
% CD is the top horizontal side.
% DA is the left vertical side.
% (a,b) - coordinates of the center of the square.
% h - length of the side of the square.

%                   / (R cos(beta), R sin(beta))
%                  /
%                 / 
%(tcos(beta),--> /) theta
% tsin(beta)) / /\)
%         t  / /  \  
%           / /beta\
%          / /)_____\ 
%            O   

% theta - angle of scattering.
% beta - angle of incidence of the broken ray.
% t - distance travelled by the broken ray is R-t before it breaks.

x1 = a-h/2.0;
x2 = a+h/2.0;
y1 = b-h/2.0;
y2 = b+h/2.0;

% Scattering point
xs = t*cos(beta);
ys = t*sin(beta);

R = 1.0;

% Changing the pixel and the ray to reference pixel and ray in the first
% quadrant.

% Case 1: Scattering point within the pixel.
if(x1 <= xs && xs <= x2 && y1 <= ys && ys <= y2)
    %fprintf('Scattering point (%.2f,%.2f) within the pixel\n',xs,ys)
    [a,b,beta] = transform(a,b,beta);
    val = intersect_broken_lines(a,b,h,t,beta,theta);
else
    
    % Case 2: The scattering point is not within the pixel.
    %fprintf('Scattering point (%.2f,%.2f) not within the pixel\n',xs,ys);
    [a1,b1,beta1] = transform(a,b,beta);
    [xs,ys,beta1] = transform(xs,ys,beta);
    if(a1 >= 0 && b1 >= 0)
        val = intersect_first(a1,b1,h,beta1,t);
        % If there is no intersection of the first line with the pixel but
        % both of them are in the same quadrant, then check for the
        % intersection of the pixel with the second line.
        if(val == 0)
            %fprintf('Checking for intersection with second line\n');
            val = intersect_second(a1,b1,h,t,beta1,theta,ys);
        end
    else
        
         val = intersect_second(a1,b1,h,t,beta1,theta,ys);
        
        
    end
end

