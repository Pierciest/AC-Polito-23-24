% Clear workspace, close all figures, clear command window
clear all;
close all;
clc;

% System matrices
A = [-0.2 -1; 1 0];
B = [0.5; 0];
x0 = [0.1; 0.1];
C = [0 1];
D = 0;

% Calculate controllability and observability matrices
M_r = ctrb(A,B);
rho_M = rank(M_r); % Rank of controllability matrix

Mo = obsv(A,C);
rho_Mo = rank(Mo); % Rank of observability matrix

% Desired specifications for controller
zeta = 0.66; % Damping ratio
wn = 2.93; % Natural frequency

% Calculate desired eigenvalues for controller
lambda_1 = -zeta*wn + j*wn*sqrt(1-zeta^2);
lambda_2 = -zeta*wn - j*wn*sqrt(1-zeta^2);
lambda_des = [lambda_1 lambda_2];

% Pole placement for the controller
K = place(A, B, lambda_des);
eig_A_minus_BK = eig(A-B*K); % Eigenvalues of (A-B*K)

% State-space model for the closed-loop system
A_c = A-B*K;
B_c = B;
C_c = C;
D_c = D;
sys_N = ss(A_c, B_c, C_c, D_c);

% Adjust input gain to achieve unitary DC gain
N = 1/dcgain(sys_N);

% Desired poles for the observer
lambda_obsv_des = [-zeta*wn -zeta*wn];

% Pole placement for the observer
L = acker(A', C', lambda_obsv_des)';
eig_A_minus_LC = eig(A-L*C); % Eigenvalues of (A-L*C)

% Initial conditions
x0_hat = [0; 0];
A_I = [A -B*K; L*C A-B*K-L*C];
B_I = [B; B]*N;
C_I = [C zeros(1, 2)];
D_I = 0;
sys_cont = ss(A_I, B_I, C_I, D_I);

% Time simulation from 0 to 15 seconds
t_sim = linspace(0, 15, 10000);
u_sim = ones(size(t_sim));

% Simulate the closed-loop response
[y, t, x_I] = lsim(sys_cont, u_sim, t_sim, [x0; x0_hat]);

% Plotting the results
figure(1);
subplot(211);
plot(t, x_I(:,1), 'b', 'LineWidth', 1.5);
grid on; hold on;
plot(t, x_I(:,3), ':r', 'LineWidth', 1.5);
xlabel('t (s)');
legend('x_1', 'x_1_{hat}');

subplot(212);
plot(t, x_I(:,2), 'b', 'LineWidth', 1.5);
grid on; hold on;
xlabel('t (s)');

figure(2);
plot(t, y, 'b', 'LineWidth', 1.5);
grid on; xlabel('t (s)'); ylabel('y(t)');

% Simulate the closed-loop response
[y, t, x_I] = lsim(sys_cont, u_sim, t_sim, [x0; x0_hat]);

% Find the steady-state value (should be 1 due to unitary gain design)
y_ss = 1;

% Calculate the maximum value of the output response
y_max = max(y);

% Calculate the overshoot as a percentage of the steady-state value
overshoot_percent = (y_max - y_ss) / y_ss * 100;

% Display the maximum overshoot
disp(['Maximum Overshoot: ', num2str(overshoot_percent), '%']);

