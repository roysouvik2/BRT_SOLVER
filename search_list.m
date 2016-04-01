% Search of the index for the lower limit of integration.
function val = search_list(i,t,theta)

M = length(t);
h = t(2)-t(1);

j = 1;
while (j <= M)
   if(t(j) >= t(i)*sin(theta) && t(j)-h < t(i)*sin(theta))
        val = j;
        return;
   elseif(t(i)*sin(theta) < t(1) && t(j) - h >= t(i)*sin(theta))
        val = 1;
        return
   else
        j = j+1;
    end
end
