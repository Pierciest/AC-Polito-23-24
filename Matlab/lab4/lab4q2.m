clear all;
close all;
clc;

s = tf('s');

H = (1+s^2)/((s^2-4)*(s+4));
figure, bode(H)
[re,im] = nyquist(H);
figure, plot(squeeze(re),squeeze(im))
figure, nyquist(H)
figure, nichols(H)
