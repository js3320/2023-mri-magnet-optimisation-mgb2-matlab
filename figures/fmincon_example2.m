% Define the objective function
objective = @(x) (1 + (x(1) + x(2) + 1)^2 * (19 - 14*x(1) + 3*x(1)^2 - 14*x(2) + 6*x(1)*x(2) + 3*x(2)^2)) * ...
    (30 + (2*x(1) - 3*x(2))^2 * (18 - 32*x(1) + 12*x(1)^2 + 48*x(2) - 36*x(1)*x(2) + 27*x(2)^2));
% Set up the constraints
% In this example, we will not have any constraints, so the constraints function will be empty.
constraints = [];

% Set up the initial guess and bounds
x0 = [0; -2];      % Initial guess
lb = [-2; -2];  % Lower bounds
ub = [2; 2];    % Upper bounds

% Set up the options
%options = optimoptions('fmincon', 'Display', 'iter');

% Call fmincon to minimize the objective function
[x, fval] = fmincon(objective, x0, [], [], [], [], lb, ub, constraints);

% Display the results
fprintf('Optimized variables: x = [%f, %f]\n', x(1), x(2));
fprintf('Optimized objective value: f(x) = %f\n', fval);