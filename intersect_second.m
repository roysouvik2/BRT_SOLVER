% Determine the measure of intersection of the second component of the
% broken ray with the pixel.

function val = intersect_second(a,b,h,t,beta, theta,ys)

x1 = a-h/2.0;
x2 = a+h/2.0;
y1 = b-h/2.0;
y2 = b+h/2.0;

R = 1.0;


if(y1 > ys && y2 >ys) % No intersection at all.
    val = 0;
    return;
elseif((theta+beta) == 0) % The secod component of the broken ray is 
                          % hoizontal.
    % For the first point of intersection
    x = x2;
    check_y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    if(y1 <= check_y && check_y <= y2)
        y = check_y;
    else
        val = 0;
        return;
    end
    p1 = x;
    q1 = y;
    % For the second point of intersection
    x = x1;
    check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
    if(y1 <= check_y && check_y <= y2)
        y = check_y;
    else
        val = 0;
        return;
    end
    p2 = x;
    q2 = y;
elseif((theta+beta) == pi/2) % The second component of the broken ray is 
                             % vertical.
    % For the first point of intersection
    y = y2;
    check_x = (y2-t*sin(beta))/tan(theta+beta)+t*cos(beta);
    if(x1 <= check_x && check_x <= x2)
        x = check_x;
    else
        val = 0;
        return;
    end
    p1 = x;
    q1 = y;
    % For the second point of intersection
    y = y1;
    check_x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
    if(x1 <= check_x && check_x <= x2)
        x = check_x;
    else
        val = 0;
        return;
    end
    p2 = x;
    q2 = y;
else
    % For the first point of intersection
    % Point of intersection on CD
    
    check_x = (y2-t*sin(beta))/tan(theta+beta)+t*cos(beta);
    if(x1 <= check_x && check_x <= x2)
        
        x = check_x;
        y = y2;
        p1 = x;
        q1 = y;
        % For the second point of intersection
        % Point of intersection on AB
        check_x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
        if(x1 <= check_x && check_x <= x2)
            x = check_x;
            y = y1;
        else
            % Point of intersection on BC
            check_y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
            if(y1 <= check_y && check_y <= y2)
                x = x2;
                y = check_y;
            else
                % Point of intersection on AD
                check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
                if(y1 <= check_y && check_y <= y2)
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
    else
        % For the first point of intersection
        % Point of intersection on BC
        check_y = (x2-t*cos(beta))*tan(theta+beta)+t*sin(beta);
        if(y1 <= check_y && check_y <= y2)
            x = x2;
            y = check_y;
            p1 = x;
            q1 = y;
            
            % For the second point of intersection
            % Point of intersection on AB
            check_x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
            if(x1 <= check_x && check_x <= x2)
                x = check_x;
                y = y1;
                p2 = x;
                q2 = y;
            else
                % Point of intersection on AD
                check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
                if(y1 <= check_y && check_y <= y2)
                    x = x1;
                    y = check_y;
                    p2 = x;
                    q2 = y;
                else
                    val = 0;
                    return;
                end
            end
        else
            % For the first point of intersection
            % Point of intersection on AD
            check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
            if(y1 <= check_y && check_y <= y2)
                x = x1;
                y = check_y;
                p1 = x;
                q1 = y;
                
                % For the second point of intersection
                % Point of intersection on AB
                check_x = (y1-t*sin(beta))/tan(theta+beta)+t*cos(beta);
                if(x1 <= check_x && check_x <= x2)
                    x = check_x;
                    y = y1;
                    p2 = x;
                    q2 = y;
                else
                    % Point of intersection on AD
                    check_y = (x1-t*cos(beta))*tan(theta+beta)+t*sin(beta);
                    if(y1 <= check_y && check_y <= y2)
                        x = x1;
                        y = check_y;
                        p2 = x;
                        q2 = y;
                    else
                        val = 0;
                        return;
                    end
                end
            else
                val = 0;
                return
            end
        end
    
    end
        
end

%fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',p1,q1);

%fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',p2,q2);

val = sqrt((p1-p2)^2+(q1-q2)^2);
