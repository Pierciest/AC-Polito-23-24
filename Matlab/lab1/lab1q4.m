clear all
close all
clc

s= tf('s')

A = [0 1 0 0;-1 0 0 0;3 0 0 0;0 0 2 0]
B = [1;0;0;0]
C = [1 0 0 0]

x0 = [0 0 0 0]'
%U = (2^(1/2))/(s^2+2)
U = 1/(s^2+1)
tol = 1*exp(-3)

X = zpk(minreal(inv((s*eye(4)-A))*(x0+B*U),tol))

Y = zpk(minreal(C*X,tol))

[num_Y1,den_Y1] = tfdata(Y,"v")

[resY,polY] = residue(num_Y1,den_Y1)


