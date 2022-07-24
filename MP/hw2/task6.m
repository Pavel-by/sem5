function [sh, sht, shv] = task6 (M)
  sh_f = @(type) sum(M(M(:,2) == type));
  sht_f = @(type) mean(M(M(:,2) == type));
  shv_f = @(type) mean(M((M(:,2) == type) & (M(:,1) <= 2) & (M(:,1) >= 1)));
  
  sh = arrayfun(sh_f, 1:5);
  sht = arrayfun(sht_f, 1:5);
  shv = arrayfun(shv_f, 1:5)
endfunction