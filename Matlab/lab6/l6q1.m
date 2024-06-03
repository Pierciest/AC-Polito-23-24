clear;  % Clear variables
close all;  % Close figures
clc;  % Clear command window

s = tf('s');

% Plant
G = 10 / (s * (s + 5) * (s + 10));

% Steady-State Design
Kc = 5;  % This is derived mathematically
C_SS = Kc;
C = C_SS;


% Transient Requirements
phi = 0.615;
Tp_dB = 0.34;
Sp_dB = 2.93;
wc_des = 6.5;
wb = 9;

% Open-Loop System with Steady-State Controller
L1 = G * C;
figure(1);
nichols(L1, 'b');
hold on;
T_grid(Tp_dB);
S_grid(Sp_dB);

%Lead design
md1 = 8;
md2 = 8;

wnorm1 = 0.9;
wnorm2 = 0.9;

wD1 = wc_des/wnorm1;
wD2 = wc_des/wnorm2;

C_D1 = (1+s/wD1)/(1+s/(md1*wD1));
C_D2 = (1+s/wD2)/(1+s/(md2*wD2));

C_D = C_D1 * C_D2;
L2 = L1*C_D;
nichols(L2,'m')
C = C*C_D;

%Magnitude increase
K = 10^(17.3/20);
L3 = L2*K;
nichols(L3,'y')
C = C*K;

% Simulation
tc = 3;

%shat, ts%2

d_a = 0;
rho = 1;
d_y = 0;

out = sim("feedback_simulation");
figure(2)
plot(out.y.time,out.y.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('y(t)')

%tracking error

d_a = 0;
rho = 1;
d_y = 0;

out = sim("feedback_simulation_2");
figure(3)
plot(out.e.time,out.e.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('e(t)')

%yda

d_a = 0.3;
rho = 0;
d_y = 0;

out = sim("feedback_simulation");
figure(4)
plot(out.y.time,out.y.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('yda(t)')

%u(t)

d_a = 0;
rho = 0.1;
d_y = 0;

out = sim("feedback_simulation");
figure(5)
plot(out.u.time,out.u.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('u(t)')


%y(t)

d_a = 0.3;
rho = 0.1;
d_y = 0;

out = sim("feedback_simulation");
figure(6)
plot(out.y.time,out.y.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('y(t)')




