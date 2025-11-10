%homogeneity fmincon optimization
%갭 값을 넣으면 ppm 계산해주는 식을 만듬
%그 식을 fmincon 안에 넣어서 ppm이 최소일 때, 갭 값이 얼마인지를 알아보게함
%[x, fval] = fmincon(ppm function, x0, [], [], [], [], lb, ub, constraints);
%x=initial value
%lb,ub=lower&upperbound
%
% Define the objective function with four variables (gap1, gap2, gap3, gap4)
objective = @(x) extremity_calculation1(x(1), x(2), x(3), x(4));
constraints=[];
x0=[0.025, 0.0612, 0.01388, 0.02283];
lb=[0.01,0.04,0.01,0.01];
ub=[0.04,0.08,0.04,0.04];
[x,fval] = fmincon(objective, x0, [], [], [], [], lb, ub, constraints);
fprintf('Optimal values:\n');
fprintf('gap1 = %f\n', x(1));
fprintf('gap2 = %f\n', x(2));
fprintf('gap3 = %f\n', x(3));
fprintf('gap4 = %f\n', x(4));
fprintf('Optimized objective function value: %f\n', fval);
%Optimal values:
%gap1 = 0.022858
%gap2 = 0.061826
%gap3 = 0.016015
%gap4 = 0.021887
%Optimized objective function value: 14.376049

