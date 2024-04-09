clear all
close all
clc

s = tf('s')
A = [5 -1 2;3 1 0;-5 4 0]
B = [2;1;-1]
C= 1/2*[1 -1 3]

tol = 1*exp(-3)

eig(A)

H = zpk(minreal(C*inv(s*eye(3)-A)*B,tol))
roots(minpoly(A))