clear all
close all
clc

s = tf('s');
H = (1-s/50)/(s*(1-s/5)^2);
U = 2/s;

Y = zpk(H*U)

[num_Y1,den_Y1] = tfdata(Y,"v");
    
[res_Y,pol_Y] = residue(num_Y1,den_Y1)

K = dcgain(H)
