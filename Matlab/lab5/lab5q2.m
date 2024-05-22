clear all;
close all;
clc;


s = tf('s');

% q = queue length
% p = probability of packet mark/drop
% c = link capacity
% N = load factor
% R = RTT

l = 1.86e-4;
k = 0.005;
Kc = 9.64e-6;
z = 0.53;
c = 3750;
N = 60;
R = 0.246;

q = c^2/(2*N)*exp(-s*R);
p=(s+(2*N/(R^2*c)))*(s+1/R)

G = q/p;
%C = l/(1+s/k);
C = Kc*(1+s/z)/s;

d_a=0;
d_y=0
rho=1;
tc=100;


out=sim('feedback_simulation_2')


figure(1)
plot(out.y.time,out.y.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
plot(out.r.time,out.r.data,'r','LineWidth',1.5)
xlabel('t (s)')
ylabel('y(t)')
figure(2)
plot(out.u.time,out.u.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('u(t)')
figure(3)
plot(out.e.time,out.e.data,'b','LineWidth',1.5)
hold on,grid on,zoom on
xlabel('t (s)')
ylabel('e(t)')
