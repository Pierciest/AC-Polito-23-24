clear all
close all
clc

s = tf('s') %defining the transfer function

A= [5 8;1 3] %defining the matrix A

B= [4;-1] % defining the matrix B

C = [3 -4]

x0 = [3;-3] % defining the x(0)

U = 0 % u(t) is given 0 hence, it's laplace transform is also 0
%U = 4/s % u(t) in the second part of the exercise is given as 4*step(t) hence, U = 4/s

tol = 1*exp(-3) % defining the tolerance for minreal

X = zpk(minreal(inv(s*eye(2)-A)*(x0+B*U),tol)) %Performing the operation to find the X(s)

[num_X1,den_X1] = tfdata(X(1),"v") %defining the numerator and denumerators of first element of X(s) as a vector
[num_X2,den_X2] = tfdata(X(2),"v") %defining the numerator and denumerators of second element of X(s) as a vector

[res1,pol1] = residue(num_X1,den_X1) %finding the residues and poles of first element
[res2,pol2] = residue(num_X2,den_X2) %finding the residues and poles of second element

Y = zpk(minreal(C*X,tol)+7*U) %finding the Y(s)

[num_Y1,den_Y1] = tfdata(Y(1),"v") %defining the numerator and denumerators of first element of Y(s) as a vector

[resy1,poly1] = residue(num_Y1,den_Y1) %finding the residues and poles of first element
