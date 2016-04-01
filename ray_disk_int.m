% Determining the measure of the broken ray in a disk.
function val = ray_disk_int(a,b,r,theta,beta,t)

% Notations:

% (a,b) - coordinates of the center of the disk.
% r - radius of the disk.

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


% Scattering point
xs = t*cos(beta);
ys = t*sin(beta);
R = 1.0;


% Case 1: Scattering point within the disk.
if(0 <= ((xs-a)^2+(ys-b)^2) && ((xs-a)^2+(ys-b)^2) <= r^2)
    %fprintf('Scattering point (%.2f,%.2f) within the disk\n',xs,ys)
    % Changing the disk and the ray to reference disk and ray in the first
    % quadrant.
    [a,b,beta1] = transform(a,b,beta);
    [xs,ys,beta1] = transform(xs,ys,beta);
    % First point of intersection
    if( beta1 == pi/2)
        x1 = 0;
        y1 = b + sqrt(r^2-a^2);
    else
        x1 = ((a+b*tan(beta1))+sqrt((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2))/(sec(beta1)^2);
        y1 = tan(beta1)*x1;
    end
    % Second point of intersection
    
    if(abs(theta+beta1- pi/2) < 10^-13)
        x2 = xs;
        y2 = b - sqrt(r^2-(x2-a)^2);
    else
        
        z = ys-b-tan(theta+beta1)*xs;
        x2 = (a-tan(theta+beta1)*z - sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
        y2 = tan(theta+beta1)*(x2-xs)+ys;
        if ( y2 > ys) 
            x2 = (a-tan(theta+beta1)*z + sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
            y2 = tan(theta+beta1)*(x2-xs)+ys;
        end
    end
    val = sqrt((x1-xs)^2+(y1-ys)^2)+ sqrt((x2-xs)^2+(y2-ys)^2);
    %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
    %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
    
else
    
    % Case 2: The scattering point is not within the disk.
    %fprintf('Scattering point (%.2f,%.2f) not within the disk\n',xs,ys);
    [a,b,beta1] = transform(a,b,beta);
    [xs,ys,beta1] = transform(xs,ys,beta);
    
    % Checking for intersection with the first line. 
    if(beta1 == pi/2)% For first line
        if(r^2 >= a^2)
            
            x1 = 0;
            y1 = b + sqrt(r^2-a^2);
            x2 = 0;
            y2 = b - sqrt(r^2-a^2);
            if(y1 >= ys && y2 >= ys)
                val = sqrt((x1-x2)^2+(y1-y2)^2);
            else 
                z = ys-b-tan(theta+beta1)*xs;
                if(((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2))>=0)% For Second line
                    
                    x1 = (a-tan(theta+beta1)*z + sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                    y1 = tan(theta+beta1)*(x1-xs)+ys;
                    x2 = (a-tan(theta+beta1)*z - sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                    y2 = tan(theta+beta1)*(x2-xs)+ys;
                    if(y1 <= ys && y2 <= ys)
                        val = sqrt((x1-x2)^2+(y1-y2)^2);
                    else
                        val = 0;
                    end
                    %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
                    %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
                else
                    
                    val = 0;
                end
            end
        else
            z = ys-b-tan(theta+beta1)*xs;
            if(((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2))>=0)% For Second line
                
                x1 = (a-tan(theta+beta1)*z + sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                y1 = tan(theta+beta1)*(x1-xs)+ys;
                x2 = (a-tan(theta+beta1)*z - sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                y2 = tan(theta+beta1)*(x2-xs)+ys;
                if(y1 <= ys && y2 <= ys)
                    val = sqrt((x1-x2)^2+(y1-y2)^2);
                else
                    val = 0;
                end
                %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
                %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            else
                
                val = 0;
            end
        end
    elseif(abs(theta+beta1- pi/2) < 10^-13)% For second line
        if(((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2)>=0)% For First line
            
            x1 = ((a+b*tan(beta1))+sqrt((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2))/(sec(beta1)^2);
            y1 = tan(beta1)*x1;
            x2 = ((a+b*tan(beta1))-sqrt((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2))/(sec(beta1)^2);
            y2 = tan(beta1)*x2;
            if(y1> ys && y2 > ys )
                
                val = sqrt((x1-x2)^2+(y1-y2)^2);
                %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
                %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            elseif(y1>= ys && y2 >= ys && beta == 0 && x1 > xs && x2 > xs)
                
                val = sqrt((x1-x2)^2+(y1-y2)^2);
                %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
                %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            elseif(r^2 >= (xs-a)^2)% For the second line.
                
                x1 = xs;
                y1 = b + sqrt(r^2-(x1-a)^2);
                x2 = xs;
                y2 = b - sqrt(r^2-(x2-a)^2);
                if(y1 <= ys && y2 <= ys)
                    val = sqrt((x1-x2)^2+(y1-y2)^2);
                else
                    val = 0;
                end
                %$fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
                %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            else
                
                val = 0;
            end
        elseif(r^2 >= (xs-a)^2)% For the second line
                
                x1 = xs;
                y1 = b + sqrt(r^2-(x1-a)^2);
                x2 = xs;
                y2 = b - sqrt(r^2-(x2-a)^2);
                if(y1 <= ys && y2 <= ys)
                    val = sqrt((x1-x2)^2+(y1-y2)^2);
                else
                    val = 0;
                end
                %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
                %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
        else
            
            val = 0;
        end
               
    else
        
        if(((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2)>=0)% For First line
            
            x1 = ((a+b*tan(beta1))+sqrt((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2))/(sec(beta1)^2);
            y1 = tan(beta1)*x1;
            x2 = ((a+b*tan(beta1))-sqrt((a+b*tan(beta1))^2-(a^2+b^2-r^2)*sec(beta1)^2))/(sec(beta1)^2);
            y2 = tan(beta1)*x2;
            if(y1 >= ys && y2 >= ys && beta ==0 && x1 > xs && x2 > xs)
                
                val = sqrt((x1-x2)^2+(y1-y2)^2);
%                 fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
%                 fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            elseif(y1 > ys && y2 > ys)
                
                val = sqrt((x1-x2)^2+(y1-y2)^2);
%                 fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
%                 fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            else
                z = ys-b-tan(theta+beta1)*xs;
                if(((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2))>=0)% For Second line
                    
                    x1 = (a-tan(theta+beta1)*z + sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                    y1 = tan(theta+beta1)*(x1-xs)+ys;
                    x2 = (a-tan(theta+beta1)*z - sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                    y2 = tan(theta+beta1)*(x2-xs)+ys;
                    if(y1 <= ys && y2 <= ys)
                        val = sqrt((x1-x2)^2+(y1-y2)^2);
                    else
                        val = 0;
                    end
%                     fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
%                     fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
                else
                    
                    val = 0;
                end
            end
            
        else
            z = ys-b-tan(theta+beta1)*xs;
            if(((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2))>=0)% For Second line
                
                x1 = (a-tan(theta+beta1)*z + sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                y1 = tan(theta+beta1)*(x1-xs)+ys;
                x2 = (a-tan(theta+beta1)*z - sqrt((a-tan(theta+beta1)*z)^2-sec(theta+beta1)^2*(a^2+z^2-r^2)))/(sec(theta+beta1)^2);
                y2 = tan(theta+beta1)*(x2-xs)+ys;
                if(y1 <= ys && y2 <= ys)
                    val = sqrt((x1-x2)^2+(y1-y2)^2);
                else
                    
                    val = 0;
                end
%                 fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x1,y1);
%                 fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',x2,y2);
            else
                
                val = 0;
            end
        end
    end
    
    
end

