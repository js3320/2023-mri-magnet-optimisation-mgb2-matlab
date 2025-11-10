objective = @(x) (x(1) - 2)^2 + (x(2) - 3)^2;
lb = [0, 0];
ub = [5, 5];
x0 = [1, 1];
[x, fval] = fmincon(objective, x0, [], [], [], [], lb, ub);
disp(x); disp(fval);
