function y = task7 (a, x)
  n = length(a);
  y = sum(a .* (x .^ [0:1:n-1]));
endfunction
