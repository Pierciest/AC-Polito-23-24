clear all
close all
clc
format compact

A = [1 3;4 2];
B = [-1;2];
C = [1 1];
D = 0;

Mr = ctrb(A,B);
rho_Mr = rank(Mr);

lambda_des = [-2 -3];
%K = place(A,B,lambda_des);
K = acker(A,B,lambda_des);

sys_cont_c = ss(A-B*K,B,C,D);
N = 1/dcgain(sys_cont_c)