function [x, y] = task2(n = 10) 
  x = [-2*pi:0.1:2*pi];
  m = sin([1:n]' * x) ./ [1:n]';
  y = ones(1, n) * m;
  plot(x, y, '-b;y = sin(x)+ ... + 1/n * sin(nx);'); 
  legend ("location", "northeast");
  grid('on');
  xlabel('x');
  ylabel('y');
endfunction
