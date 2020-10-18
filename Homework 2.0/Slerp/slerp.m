function [qs] = slerp(q1, q2, tm, t)

% if (t < 0) || (t > tm)
%     error('Greska');

if t == 0 
    qs = q1;
    
elseif t == tm
    qs = q2;
    
else
    
    cos0 = dot(q1,q2);                  
    
    if(cos0 < 0)
        q1 = -q1; 
        cos0 = -cos0;
    end
    if cos0 > 0.95
        qs = (1-t/tm)*q1 + (t/tm)*q2;
    else
        phi = acos(cos0);
        qs = ((sin(phi*(1-t/tm)))/sin(phi))*q1 + (sin(phi*t/tm)/sin(phi))*q2;
    end
end

end