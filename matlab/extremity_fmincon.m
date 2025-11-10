% homogeneity fmincon optimization
objective = @(x) extremity_calculation1(x(1), x(2), x(3), x(4));
constraints = [];
x0 = [0.025, 0.0612, 0.01388, 0.02283];
lb = [0.01, 0.04, 0.01, 0.01];
ub = [0.04, 0.08, 0.04, 0.04];
[x,fval] = fmincon(objective, x0, [], [], [], [], lb, ub, constraints);
fprintf('Optimal values:\n');
fprintf('gap1 = %f\n', x(1));
fprintf('gap2 = %f\n', x(2));
fprintf('gap3 = %f\n', x(3));
fprintf('gap4 = %f\n', x(4));
fprintf('Optimized objective function value: %f\n', fval);
