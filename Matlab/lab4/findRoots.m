function unique_roots = findRoots
    % Set x2 as 0
    x2 = 0;
    
    % Define the function with x2 = 0
    fun = @(x1) 19.62 * sin(x1) + 4 * x1 + 4 * x2;

    % Define a range of initial guesses for x1
    initial_guesses = linspace(-2*pi, 2*pi, 6); % 20 guesses from -2pi to 2pi

    % Array to store roots
    roots = zeros(size(initial_guesses));

    % Loop over initial guesses
    for i = 1:length(initial_guesses)
        try
            % Find the root near the current initial guess
            roots(i) = fzero(fun, initial_guesses(i));
        catch
            % If fzero fails, set the root to NaN (Not a Number)
            roots(i) = NaN;
        end
    end
    
    % Remove duplicate roots within a small tolerance
    unique_roots = unique(roots, 'stable');

    % Display each unique root found
    disp('Unique roots found for x1 when x2 = 0:');
    for i = 1:length(unique_roots)
        fprintf('x1 = %f\n', unique_roots(i));
    end
end
