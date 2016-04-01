% Determine the measure of intersection of both the components of the
% broken ray with the pixel.

function val = intersect_broken_lines(a,b,h,t,beta,theta)

x1 = a-h/2.0;
x2 = a+h/2.0;
y1 = b-h/2.0;
y2 = b+h/2.0;

% Scattering point
s1 = t*cos(beta);
s2 = t*sin(beta);

% For the first point of intersection on CD

if(x1 <= cot(beta)*y2 && cot(beta)*y2 <= x2) 
    p1 = cot(beta)*y2;
    q1 = y2;
    %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',p1,q1);
    
    % For the second point of intersection
        
    if((theta+beta) == 0)
        x = x1;
        y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    elseif((theta+beta) == pi/2)
        x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
        y = y1;
    elseif((theta+beta) == pi)
        x = x2;
        y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    else
        check_x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
        if(x1 <= check_x && check_x < x2)
            x = check_x;
            y = y1;
        else
            check_y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
            if(y1 <= check_y && check_y < y2)
                x = x2;
                y = check_y;
            else
                check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
                if(y1 <= check_y && check_y < y2)
                    x = x1;
                    y = check_y;
                else
                    val = 0;
                    return;
                end
            end
        end
    end
    p2 = x;
    q2 = y;
        
    %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',p2,q2);
    
          
else
    % First point of intersection on BC
    p1 = x2;
    q1 = tan(beta)*x2;
    
    %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',x2,tan(beta)*x2);
    
    % For the second point of intersection
    x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
    y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    
    if((theta+beta) == 0)
        x = x1;
        y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    elseif((theta+beta) == pi/2)
        x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
        y = y1;
    elseif((theta+beta) == pi)
        x = x2;
        y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    else
        check_x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
        if(x1 <= check_x && check_x < x2)
            x = check_x;
            y = y1;
        else
            check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
            if(y1 <= check_y && check_y < y2)
                x = x1;
                y = check_y;
            else 
                val = 0;
                return;
                
            end
        end
    end
    p2 = x;
    q2 = y;
           
    %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',p2,q2);
    
end

 val = sqrt((p1-s1)^2+(q1-s2)^2)+sqrt((p2-s1)^2+(q2-s2)^2);