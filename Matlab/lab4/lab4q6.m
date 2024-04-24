clear all;
close all;
clc;

% Define constants
m = 0.1;       % Mass in kg
l = 0.5;       % Length in meters
beta = 0.1;    % Damping coefficient in N s rad^-1
g = 9.81;      % Acceleration due to gravity in m/s^2

% Compute equilibrium control input
u = m * l * g; % Torque needed to hold pendulum at pi/2

% Display the equilibrium control input
disp(['Equilibrium control input u = ', num2str(u), ' Nm']);

% Define the Jacobian matrix A at the equilibrium point
% Since cos(pi/2) = 0, the partial derivative of dot{x}_2 with respect to x_1 is 0
a = 0;          % g/l * cos(pi/2) is 0
b = -beta / (m * l^2); % Damping term
A = [0 1;       % System matrix
     a b];

% Calculate eigenvalues of the Jacobian matrix
eigenvalues = eig(A);

% Display eigenvalues
disp('Eigenvalues of the Jacobian matrix at the equilibrium point are:');
disp(eigenvalues);

% Conclude based on eigenvalues
if any(real(eigenvalues) > 0)
    disp('The system is unstable.');
else
    if any(real(eigenvalues) == 0)
        disp('No conclusion can be drawn about the equilibrium stability');
    else
        disp('The system is stable.');
    end
end
