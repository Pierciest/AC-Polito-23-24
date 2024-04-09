clear all
close all
clc

s = tf('s')

A = [1 3;6 4]
B = [2;4]
C = [1 0]

tol = exp(-3)

eig(A)
H = zpk(minreal(C*inv(s*eye(2)-A)*B,tol))