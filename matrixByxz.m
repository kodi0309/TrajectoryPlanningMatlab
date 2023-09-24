function Byxz=matrixByxz(alpha,beta,gamma)

B_x=[1 0 0 
    0 cos(alpha) -sin(alpha) 
    0 sin(alpha) cos(alpha)];

B_y=[cos(beta) 0 sin(beta)
    0 1 0
    -sin(beta) 0 cos(beta)];

B_z=[cos(gamma) -sin(gamma) 0
    sin(gamma) cos(gamma) 0
    0 0 1];

% Kąty obrotu wokół stałego układu odniesienia YXZ
    Byxz=B_z*B_x*B_y;

end