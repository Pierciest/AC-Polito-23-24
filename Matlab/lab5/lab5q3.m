clear all;
close all;
clc;

s = tf('s');
L = 1/(s*(1+s/2)^3);
T = zpk(minreal(L*(1+L),1e-3))
%figure, nyquist(L)
figure, nichols(L), hold on
ngrid