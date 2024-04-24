clear all
close all
clc

s = tf('s');
H = 10/s^3;

figure, bode(H)
[re,im] = nyquist(H);
figure, plot(squeeze(re),squeeze(im))
figure, nyquist(H)
figure, nichols(H)
