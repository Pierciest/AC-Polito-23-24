clear all
close all
clc

a = -19.62;

unique_roots = findRoots;

for i = 1:length(unique_roots)
    x1 = unique_roots(i);
    A = [0 1; a * cos(x1) - 4, -4];
    eigenvalues = eig(A)

    if any(real(eigenvalues) > 0)
        fprintf('For x1= %.4f, x2= 0; The system is unstable.\n', x1);
    else
        if any(real(eigenvalues) == 0)
            fprintf('For x1= %.4f, x2= 0; No conclusion can be drawn about the equilibrium stability.\n', x1);
        else
            fprintf('For x1= %.4f, x2= 0; The system is stable.\n', x1);
        end
    end
end


%Alternative method!

% Define the range of x values
x = linspace(-2*pi, 2*pi, 1000); % 1000 points between -2pi and 2pi

% Calculate y using the given function
y = -19.62 * sin(x) - 4 * x;

% Create the plot
figure; % Open a new figure window
plot(x, y, 'b', 'LineWidth', 2); % Plot with a blue line of width 2
grid on; % Turn on the grid
xlabel('x'); % Label for the x-axis
ylabel('y'); % Label for the y-axis
title('Plot of y = -19.62*sin(x) - 4*x'); % Title of the plot

% Optional: Adding a zero line for reference
hold on; % Hold the current plot
plot(x, zeros(size(x)), 'k--'); % Plot a black dashed line at y = 0
hold off; % Release the plot hold
