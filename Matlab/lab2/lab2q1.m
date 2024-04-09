clear all
close all
clc

s = tf('s')
%A = [0 1;-1 -1]
A = 1/3*[0 1;-1 -1]
B = [2;4]
C = [1 0]
tol = 1*exp(-3)

eig(A)
root(minpoly(A))
H = zpk(minreal(C*inv(s*eye(2)-A)*B,tol))