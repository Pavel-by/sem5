function [x, y] = task3 ()
  res = fsolve(@f, [0,0]);
  
  f1 = @(y) 1 - sin(y);
  f2 = @(x) 1 - cos(x);
  values = [-2:0.1:2];
  plot(values, arrayfun(f2, values));
  hold on;
  grid on;
  plot(arrayfun(f1, values), values);

  plot(res(1), res(2), "*r");  
endfunction

function y = f(x)
  y = zeros(2, 1);
  y(1) = x(1) + sin(x(2)) - 1;
  y(2) = x(2) + cos(x(1)) - 1;  
endfunction