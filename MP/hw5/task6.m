function [x, y1, y2] = task6 ()
  x = linspace(0, 1, 100);
  y1 = lsode(@(y, x) -2*y + x + 0.5, 1, x)
endfunction