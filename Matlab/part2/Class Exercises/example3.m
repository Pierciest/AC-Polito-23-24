clear all
close all
clc

A = [-0.4 -1;1 0];
B = [1;0];
C = [0 1];
D = 0;

x0 = [-0.5 0]';
x0_hat = [0 0]';

M_r = ctrb(A,B)
rho_M = rank(M_r)

Mo = obsv(A,C)
rho_Mo = rank(Mo)

%%%%%%%%%%%%%%%%%%%%%%%%%
% State feedback design %
%%%%%%%%%%%%%%%%%%%%%%%%%

zeta = 0.63;
wn = 1.84;

%Defining the eigen values
lambda_1 = -zeta*wn+j*wn*sqrt(1-zeta^2)
lambda_2 = -zeta*wn-j*wn*sqrt(1-zeta^2)
lambda_des = [lambda_1,lambda_2];

%Compute K
K = place(A,B,lambda_des)
eig(A-B*K)

%state matrices needed to compute N
A_c = A-B*K;
B_c = B;
C_c = C;
D_c = D;
sys_N = ss(A_c,B_c,C_c,D_c);

%Compute N
N = 1/dcgain(sys_N)

%%%%%%%%%%%%%%%%%%%
% Observer Design %
%%%%%%%%%%%%%%%%%%%

%Compute observer gain L
lambda_obsv_des = [-zeta*wn -zeta*wn]*5;
%5 defines how fast should be observer eigenvalues wrt the control law
%eigenvalues

L = acker(A',C',lambda_obsv_des)'
eig(A-L*C)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Complete controlled system   %
% i.e. control law + observer  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A_I = [A -B*K; L*C A-B*K-L*C];
B_I = [B;B]*N;
C_I = [C zeros(1,2)];
D_I = 0;
sys_cont = ss(A_I,B_I,C_I,D_I);

%simulation
t_sim = linspace(0,15,10000);
u_sim = ones(size(t_sim));
[y,t,x_I] = lsim(sys_cont,u_sim,t_sim,[x0;x0_hat]);

%plot simulation results
figure(1),subplot(211)
plot(t,x_I(:,1),'b','linew',1.5)
grid on, zoom on, hold on,
plot(t,x_I(:,3),':r','linew',1.5)
xlabel('t (s)')
legend('x_1','x_1hat')
subplot(212)
plot(t,x_I(:,2),'b','linew',1.5)
grid on, zoom on, hold on,
plot(t,x_I(:,4),':r','linew',1.5)
xlabel('t (s)')
legend('x_2','x_2hat')
figure(1),plot(t,y,'b','linew',1.5)
grid on, zoom on, hold on
xlabel('t (s)')
ylabel('y (t)')





