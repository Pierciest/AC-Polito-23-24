clear all;
close all;
clc;

%%%%%%%%%
% Q1-Q4 %
%%%%%%%%% 
s = tf('s');
G = 1/(1+s)^2;
C = (1+s)^2/(s*(1+s/4));
L = G*C;


tol = 1e-3;
Q = zpk(minreal(C/(1+G*C),tol));
da = 1/s;

U = zpk(minreal(Q*da,tol))

[num_U1,den_U1] = tfdata(U(1),"v")

[resU1,polU1] = residue(num_U1,den_U1)

figure, nyquist(Q)

%%%%%%%%
%  Q5  %
%%%%%%%% 

Q = 1/(1+C*G);
dy = (1/(2*(1+s^2)));

E = zpk(minreal(-Q*dy,tol))

[num_E,den_E] = tfdata(E,"v")

[resE,polE] = residue(num_E,den_E)

M = abs(resE(3));
2*M
phi = angle(resE(3))

%%%%%%%%
%  Q6  %
%%%%%%%% 

Q1 = (C*G)/(1+C*G);
Q2 = 1/(1+C*G);
R = 3/s;
dy = 2/s;

Y1 = zpk(minreal(Q1*R,tol))
Y2 = zpk(minreal(Q2*dy,tol))

Y = zpk(minreal((Y1+Y2) ,tol))

[num_Y,den_Y] = tfdata(Y,"v")

[resY,polY] = residue(num_Y,den_Y)



