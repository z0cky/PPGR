function [A] = Euler2A(phi,theta,psi)

Rz=[cos(psi) -sin(psi) 0
    sin(psi) cos(psi) 0
    0 0 1];

Ry=[cos(theta) 0 sin(theta)
    0 1 0
    -sin(theta) 0 cos(theta)];

Rx = [1 0 0
      0 cos(phi) -sin(phi)
      0 sin(phi) cos(phi)];
  
A = Rz*Ry*Rx;

end

function [pPhi] = A2AxisAngle(A)

S = [A - eye(3)];

v1 = [S(1,1) S(1,2) S(1,3)];
v2 = [S(2,1) S(2,2) S(2,3)];
p1 = cross(v1,v2);

p = p1/norm(p1);  
 
u = [S(1,1) S(1,2) S(1,3)];

u1 = [A*u'];   

if det([u; u1'; p]) < 0
    p = -p; 
end

phi = real(acos((1/2)*(A(1,1,:)+A(2,2,:)+A(3,3,:)-1)));

disp([p,phi]);

end

function [Rp] = Rodrigez(p,phi)

Px = [0 -p(3) p(2)
      p(3) 0 -p(1)
     -p(2) p(1) 0];
 
Rp = p*p' + cos(phi)*(eye(3) - p*p') + sin(phi)*Px;

end

function [ang] = A2Euler(A)

% if det(A) ~= 1
%     error('Nije ortogonalna matrica!');
if A(3,1) < 1
    if A(3,1) > -1
      psi = atan2(A(2,1), A(1,1));
      theta = asin(-A(3,1));
      phi = atan2(A(3,2), A(3,3));
    else 
        psi = atan2(-A(1,2), A(2,2));
        theta = pi/2;
        phi = 0;
    end
else 
    psi = atan2(-A(1,2), A(2,2));
    theta = -pi/2;
    phi = 0;
end

disp([phi,theta,psi]);

end

function [q] = AngleAxis2Q(Rp)

p = Rp(1:3) / norm(Rp(1:3));

phi = Rp(4)/2;

q = [p(1).*sin(phi), p(2).*sin(phi), p(3).*sin(phi), cos(phi)];

end

function [pPhi] = Q2AxisAngle(q)

w = q(4);

% [0,Pi]
% if w < 0
%    q = -q;
% end

 phi = 2*acos(w);

if abs(w) == 1
    p = [1 0 0];
else
    p = q(1:3) / norm(q(1:3)); 
end

disp([p,phi]);

end