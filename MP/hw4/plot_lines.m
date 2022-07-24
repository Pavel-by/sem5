function plot_lines(coef_line = [10 -11 5; 15 10 -15; 1 1 0], xrange = [-2 2], yrange = [-2 2])
  coefs = [-(coef_line(:,1) ./ coef_line(:,2)), -(coef_line(:,3) ./ coef_line(:,2))];
  x1 = xrange(1);
  y1 = coefs(:, 1) * x1 + coefs(:, 2);
  x2 = xrange(2);
  y2 = coefs(:,1) * x2 + coefs(:,2);
  [x1 x2]
  [y1 y2]'
  plot([x1 x2], [y1 y2]');
  grid on;
  axis([xrange, yrange]);
endfunction
