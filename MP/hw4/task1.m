function [x, y] = task1()
  x = -2*pi():0.1:2*pi();
  y = sin(x) + cos(3*x);
  plot(x, y, '-b;y = sin(x) + cos(3x);'); 
  legend ("location", "northeast");
  grid('on');
  xlabel('x');
  ylabel('y');
endfunction
