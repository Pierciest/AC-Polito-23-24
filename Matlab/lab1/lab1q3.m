clear all
close all
clc

s = tf('s') %defining the transfer function

A= [0 1 0 0;-1 -1 0 0;0 0 -10 0;0 0 0 -5] %defining the matrix A

B= [1;0;0;1] % defining the matrix B

C = [1 0 1 1]

%x0 = [0 0 0 0]'
x0 = [0 0 1 1]'

%U = 1/s + 1/s^2
U = 0

tol = 1*exp(-3) % defining the tolerance for minreal

X = zpk(minreal(inv(s*eye(4)-A)*(x0+B*U),tol)) %Performing the operation to find the X(s)

[num_X1,den_X1] = tfdata(X(1),"v") %defining the numerator and denumerators of first element of X(s) as a vector
[num_X2,den_X2] = tfdata(X(2),"v") %defining the numerator and denumerators of second element of X(s) as a vector
[num_X3,den_X3] = tfdata(X(3),"v") %defining the numerator and denumerators of third element of X(s) as a vector
[num_X4,den_X4] = tfdata(X(4),"v") %defining the numerator and denumerators of fourth element of X(s) as a vector

[res_X1,pol_X1] = residue(num_X1,den_X1) %finding the residues and poles of first element
[res_X2,pol_X2] = residue(num_X2,den_X2) %finding the residues and poles of second element
[res_X3,pol_X3] = residue(num_X3,den_X3) %finding the residues and poles of third element
[res_X4,pol_X4] = residue(num_X4,den_X4) %finding the residues and poles of fourth element

Y = zpk(minreal(C*X,tol)) %finding the Y(s)

[num_Y1,den_Y1] = tfdata(Y(1),"v") %defining the numerator and denumerators of first element of Y(s) as a vector

[res_Y,pol_Y] = residue(num_Y1,den_Y1) %finding the residues and poles of first element

M_Y = abs(res_Y(2)),2*M_Y
phi_Y = angle(res_Y(2))

