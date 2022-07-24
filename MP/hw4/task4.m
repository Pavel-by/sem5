function task4(n = 10)
  x = [-1:0.01:1];
  y = sqrt(1 - x.^2);
  x = [x, -x];
  y = [y, -y];
  
  x = (x') * [1:n]
  y = (y') * [1:n]
  
  plot(x, y);
  grid on;
endfunction
