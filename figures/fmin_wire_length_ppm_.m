 %homogeneity fmincon optimization
 %갭+두깨를 최적화 시킴
 %두깨가 너무 얇아서 원하는 Bz가 안나오면 식안에서 ppm을 10000으로 높여서 사용하지 않도록함
% Define the objective function with four variables (gap1, gap2, gap3, gap4)


%두깨가 최소한일 때 Bz가 정해진 값보다 작고 ppm도 100보다 작아야함
% Define the multi-objective function
%

% Define constraints (if any)
%nonlinearConstraints = @(x) computeConstraints(x);

% Lower and upper bounds for parameters
%lb = [lowerBound1, lowerBound2, ...]; % Lower bounds for magnet parameters
%ub = [upperBound1, upperBound2, ...]; % Upper bounds for magnet parameters

% Multi-objective optimization options
%options = optimoptions('paretosearch', 'Display', 'iter');

% Perform multi-objective optimization
%[paretoFront, paretoValues] = paretosearch(multiObjective, length(lb), [], [], [], [], lb, ub, nonlinearConstraints, options);

        %gap3는 실딩 코일ㅣ x-축에서 얼마나 떨어졌는지
        %gap5는 실딩 코일이 y-축에서 얼마나 떨어졌는지
% Define the objective functions (extremity_calculation3 and wireLength)
multiObjective = @(x) [extremity_calculation3(x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), x(9), x(10), x(11), x(12)), wirelength(x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), x(9), x(10), x(11), x(12))];

% Constraints (if any)
constraints = [];

% Initial guess for the optimization variables
x0 = [0.025, 0.0612, 0.15, 0.02283, 0.011, 0.02, 0.021, 0.03, 0.02, 0.02, 0.02, 0.02];

% Lower and upper bounds for optimization variables
lb = [0.01, 0.04, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01,0.01, 0.01, 0.01, 0.01];
ub = [0.04, 0.08, 0.03, 0.04, 0.05, 0.05, 0.05, 0.05, 0.03, 0.03, 0.03, 0.03];

% Perform multi-objective optimization using paretosearch
options = optimoptions('paretosearch', 'Display', 'iter');
[x, fval] = paretosearch(multiObjective, numel(x0), [], [], [], [], lb, ub, constraints, options);
optimizedWireLength = wirelength(x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), x(9), x(10), x(11), x(12));
optimizedHomogeneity = extremity_calculation3(x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), x(9), x(10), x(11), x(12));

% Display the optimized results
fprintf('Optimal values:\n');
fprintf('gap1 = %f\n', x(1));
fprintf('gap2 = %f\n', x(2));
fprintf('gap3 = %f\n', x(3));
fprintf('gap4 = %f\n', x(4));
fprintf('width1 = %f\n', x(5));
fprintf('width2 = %f\n', x(6));
fprintf('width3 = %f\n', x(7));
fprintf('width4 = %f\n', x(8));
fprintf('height1 = %f\n', x(9));
fprintf('height2 = %f\n', x(10));
fprintf('height3 = %f\n', x(11));
fprintf('height4 = %f\n', x(12));
fprintf('Optimized wire length: %f\n', optimizedWireLength);
fprintf('Optimized homogeneity: %f\n', optimizedHomogeneity);

%fprintf('Optimized objective function value: %f\n', fval);
%Optimal values:
%gap1 = 0.022858
%gap2 = 0.061826
%gap3 = 0.016015
%gap4 = 0.021887
%Optimized objective function value: 14.376049
%[Bzmax]=Bzmax_for_Ic(0.024091,0.066244,0.010073,0.024409,0.010490,0.021678,0.022064,0.026702)

