function x = task2 (p = [1,1,1], a = 10)
  f = @(x) polyval(p, x) * exp(x) - a;
  x = fzero(f, 0);
endfunction
