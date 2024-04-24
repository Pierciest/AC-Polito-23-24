clear all;
close all;
clc;

s = tf('s');

H = -1/((1+s)*(1-s)^2);
figure, bode(H)
[re,im] = nyquist(H);
figure, plot(squeeze(re),squeeze(im))
figure, nyquist(H)
figure, nichols(H)
