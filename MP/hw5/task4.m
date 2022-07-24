function [xs, xz, xe, dx] = task4 (a = 1000000)
  xs = fsolve(@(x) exp(x) - exp(-x) - a, 0);
  xz = fzero(@(x) exp(x) - exp(-x) - a, [-log(a)*2, log(a)*2]);
  xe = asinh(a/2);
  dx = xe - xs;
endfunction
