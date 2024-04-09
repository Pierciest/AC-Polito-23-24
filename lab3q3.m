clear all
close all
clc

s = tf('s');

% Define the system matrices
A = [-1 0; 0 10];
B = [1; 1];
C = [1 0];
D = 0;

% Tolerance for minimal realization
tol = 1*exp(-3);

% Eigenvalues of A
eigenvalues = eig(A);
disp('Eigenvalues of A:');
disp(eigenvalues);

% Transfer function of the system
disp('Transfer function H(s):');
H = zpk(minreal(C*inv(s*eye(2)-A)*B, tol))

% Analysis of stability based on eigenvalues
% The system has eigenvalues at -1 (stable) and 10 (unstable),
% indicating internal instability. However, the transfer function
% being 1/(s+1) shows that it is BIBO stable.
% Part 2: System response and damping characteristics AN EXAMPLE TO SHOW IT
% CAN BE MADE STABILE

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


% PART 3

Mo = obsv(A,C)
rho_Mo = rank(Mo)


