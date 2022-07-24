function r = arab2rome (a)
  map = {'I','II','III','IV','V','VI','VII','VIII','IX','X','$'};
  a(a > 10 | a < 1) = 11;
  r = {map{a}};
endfunction