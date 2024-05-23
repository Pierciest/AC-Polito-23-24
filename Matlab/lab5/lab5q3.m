% Clear workspace, close figures, and clear command window
clear all;
close all;
clc;

% Define transfer function
s = tf('s');
L = 1/(s*(1+s/2)^3);
T = zpk(minreal(L*(1+L),1e-3));
%figure, nyquist(L)
%figure, nichols(L), hold on
%ngrid

% Calculate gain margin (Gm), phase margin (Pm), and corresponding crossover frequencies (Wcg, Wcp)
[Gm, Pm, Wcg, Wcp] = margin(L);

% Convert gain margin to dB
Gm_dB = 20*log10(Gm);

% Display results
fprintf('Gain Margin: %.2f dB\n', Gm_dB);
fprintf('Phase Margin: %.2f degrees\n', Pm);

%%%%%%%%
%  Q4  %
%%%%%%%%

deltaL = zpk(minreal(3*L,1e-3))
deltaT = zpk(minreal(deltaL*(1+deltaL),1e-3))
figure(1), nyquist(deltaL)
figure(2), nichols(deltaL), hold on
ngrid



