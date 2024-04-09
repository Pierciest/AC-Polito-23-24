clear all
close all
clc

s = tf('s')
 
A = [0 1;-1 -1]

B = [27 0;-23 1]

C = [1 0]

U =[0;1] % Laplace transform of dirac's delta is equal to 1 hence u(t) = [1;dirac(t)] ; U(s) = [0;1]

x0 = [0;0]

tol = exp(-3)

X = zpk(minreal(inv(s*eye(2)-A)*(B*U+x0),tol))

[num_X1,denum_X1] = tfdata(X(1),'v')
[num_X2,denum_X2] = tfdata(X(2),'v')

[res_X1,pol_X1] = residue(num_X1,denum_X1)
[res_X2,pol_X2] = residue(num_X2,denum_X2)

Y = zpk(minreal(C*X,tol))

[num_Y,denum_Y] = tfdata(Y,'v')

[res_Y,pol_Y] = residue(num_Y,denum_Y)

%Until now, it is sane with the first exercies. But we can examine that our
%findings are imaginary numbers, hence we have to apply the Euler formula

M_X1 = abs(res_X1(1)),2*M_X1
phi_X1 = angle(res_X1(1))

M_X2 = abs(res_X2(1)),2*M_X2
phi_X2 = angle(res_X2(1))

M_Y = abs(res_Y(1)),2*M_Y
phi_Y = angle(res_Y(1))

%Now we can compute the values.
