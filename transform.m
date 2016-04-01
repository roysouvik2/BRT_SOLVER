% Transformation of the phantom and the broken ray to the first quadrant.

function [a,b,beta] = transform(a,b,beta)


if( 0 <= beta && beta <= pi/2)
    %fprintf('\nThe original square remains\n');
    a = a;
    b = b;
    beta = beta;
elseif(pi/2 < beta && beta <= pi)
    beta = beta-pi/2;
    %fprintf('\nCenter of the original square is (%.2f,%.2f)\n',a,b);
    temp = a;
    a = b;
    b = -temp;
    %fprintf('\nCenter of the reference square is (%.2f,%.2f)\n',a,b);
elseif(pi < beta && beta <= 3*pi/2)
    beta = beta-pi;
    %fprintf('\nCenter of the original square is (%.2f,%.2f)\n',a,b);
    a = -a;
    b = -b;
    %fprintf('\nCenter of the reference square is (%.2f,%.2f)\n',a,b);
elseif(3*pi/2 < beta && beta <= 2*pi)
    beta = beta-3*pi/2;
    %fprintf('\nCenter of the original square is (%.2f,%.2f)\n',a,b);
    temp = a;
    a = -b;
    b = temp;
    %fprintf('\nCenter of the reference square is (%.2f,%.2f)\n',a,b);
end
