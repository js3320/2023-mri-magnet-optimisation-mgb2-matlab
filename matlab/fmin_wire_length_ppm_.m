objective = @(x) field_homogeneity_optimization(x(1), x(2), x(3), x(4));
constraints = [];
x0=[0.025, 0.0612, 0.01388, 0.02283];
lb=[0.01,0.04,0.01,0.01];
ub=[0.04,0.08,0.04,0.04];
[x,fval] = fmincon(objective, x0, [], [], [], [], lb, ub, constraints);
disp(x); disp(fval);
