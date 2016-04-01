% Determine the measure of intersection of the first component of the
% broken ray with the pixel.

function val = intersect_first(a,b,h,beta,t)

x1 = a-h/2.0;
x2 = a+h/2.0;
y1 = b-h/2.0;
y2 = b+h/2.0;

R = 1.0;

% Distance travelled by ray before scattering.
d = R-t;

% First point of intersection on CD
int_x_1 = cot(beta)*y2/R;
int_y_1 = y2;


if(x1 <= int_x_1 && int_x_1 <= x2  ) % For the first point of intersection
    p1 = int_x_1;
    q1 = int_y_1;
    
    % Distance covered by ray before first intersection point
    d1 = sqrt((p1-R*cos(beta))^2+(q1-R*sin(beta))^2);
    if(d1 <= d)
        %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',p1,q1);
        
        % For the second point of intersection
        if(y1 <= R*tan(beta)*x1 && R*tan(beta)*x1 <= y2)
            p2 = x1;
            q2 = R*tan(beta)*x1;
        elseif(y1 <= R*tan(beta)*x2 && R*tan(beta)*x2 <= y2)
            p2 = x2;
            q2 = R*tan(beta)*x2;
            
        elseif(x1 <= cot(beta)*y1/R && cot(beta)*y1/R <= x2)
            p2 = cot(beta)*y1/R;
            q2 = y1;
        end
        %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',p2,q2);
        val = sqrt((p1-p2)^2+(q1-q2)^2);
    else
        %fprintf('First line does not intersect at all\n');
        val = 0;
    end
else
    % First point of intersection on BC
    int_x_1 = x2;
    int_y_1 = R*tan(beta)*x2;
    
    if(y1 <= int_y_1 && int_y_1 <= y2 )
        p1 = int_x_1;
        q1 = int_y_1;
        
        % Distance covered by ray before first intersection point
        d1 = sqrt((p1-R*cos(beta))^2+(q1-R*sin(beta))^2);
        if(d1 <= d)
            %fprintf('\nFirst point of intersection is (%.2f, %.2f)\n',p1,q1);
            
            % For the second point of intersection
            if(x1 <= cot(beta)*y1/R && cot(beta)*y1/R <= x2)
                p2 = cot(beta)*y1;
                q2 = y1;
            elseif(y1 <= R*tan(beta)*x1 && R*tan(beta)*x1 <= y2)
                p2 = x1;
                q2 = tan(beta)*x1;
            end
            %fprintf('\nSecond point of intersection is (%.2f, %.2f)\n',p2,q2);
            val = sqrt((p1-p2)^2+(q1-q2)^2);
        else
            %fprintf('First line does not intersect at all\n');
            val = 0;
        end
    else
        %fprintf('First line does not intersect at all\n');
        val = 0;
    end
end
end


    
    
    