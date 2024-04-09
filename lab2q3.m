clear all
close all
clc

s = tf('s')
A = [-2 0 0;0 0 2;0 0 0]
B = [1;1;1]
C= [1 0 0]
D = -2

tol = exp(-3)

eig(A)

H = zpk(minreal(C*inv(s*eye(3)-A)*B+D,tol))
minpoly(A)
roots(minpoly(A))