clear all
close all
clc

A = [-0.4 -1;1 0];
B = [1; 0];
C = [0 1];
D = 0;

x0 = [-0.1 0.5]';

sys = ss(A,B,C,D);

Mo = obsv(A,C);
rho_Mo = rank(Mo);

lambda_obsv_des = [-0.5 -0.5];
L = acker(A',C',lambda_obsv_des)';

eig(A-L*C);

%observer system
sys_obsv = ss(A-L*C,[B L],eye(2),0);
x0_hat=[0 0]';

%Simulation to generate observer inputs
t_sim = linspace(0,50,100);
u_sim = 0.1*ones(size(t_sim));

%state and output
%response simulation y is a column vector
[y,t,x] = lsim(sys,u_sim,t_sim,x0);

%estimated state zero input
%response simulation
[y_hat,t,x_hat] = lsim(sys_obsv,[u_sim',y],t_sim,x0_hat);


%plot simulation results
figure(1),subplot(211)
plot(t,x(:,1),'b','linew',1.5)
grid on, zoom on, hold on,
plot(t,x_hat(:,1),':r','linew',1.5)
xlabel('t (s)')
legend('x_1','x_1hat')
subplot(212)
plot(t,x(:,2),'b','linew',1.5)
xlabel('t (s)')
legend('x_2','x_2hat')