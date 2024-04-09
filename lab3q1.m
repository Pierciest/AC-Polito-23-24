close all
clc
clear all

A = [-0.2 -1; 1 0];
B = [0.5;0];
C = [0 1];
D = 0;

x0 = [0;0];
damp(A);
sys = ss(A,B,C,D);
step(sys);

%asymptotically stable

M_r = ctrb(A,B);
rho_M = rank(M_r);

%Rho_M = 2; n = 2 hence reachable!

s_hat = 0.06;
t_s2 = 2;

zeta = abs(log(s_hat))/(sqrt(pi^2+(log(s_hat))^2));
wn = log((1/100)^(-1))/(zeta*t_s2);

lambda_1 = -zeta*wn+j*wn*sqrt(1-zeta^2);
lambda_2 = -zeta*wn-j*wn*sqrt(1-zeta^2);

lambda_des = [lambda_1 lambda_2];

K = place(A,B,lambda_des);

A_c = A-B*K;
B_c = B;
C_c = C;
D_c = D;
sys_N = ss(A_c,B_c,C_c,D_c);

N = 1/dcgain(sys_N);

sys_contr = ss(A-B*K,B*N,C,D);

t_sim = linspace(0,20,10000);
u_sim = ones(size(t_sim));

[y,t,x] = step(sys_contr,t_sim);

figure(2),subplot(211)
plot(t,x(:,1),'b','linew',1.5)
grid on, zoom on, xlabel('t (s)'), ylabel('x_1(t)')
subplot(212)
plot(t,x(:,2),'b','linew',1.5)
grid on, zoom on, xlabel('t (s)'), ylabel('x_2(t)')
figure(3), plot(t,y,'b','linew',1.5)
grid on, zoom on, xlabel('t (s)'), ylabel('y(t)')


