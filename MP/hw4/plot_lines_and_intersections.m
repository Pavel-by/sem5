function plot_lines_and_intersections (coef_line = [10 -11 5; 15 10 -15; 1 1 0], xrange = [-2 2], yrange = [-2 2])
  
  [x, y] = all_lines_intersections(coef_line);
  plot_lines(coef_line, xrange, yrange);
  hold on;
  plot(x, y, '*r');
  grid on;
  axis([xrange, yrange]);
  
  function plot_lines(coef_line, xrange, yrange)
    coefs = [-(coef_line(:,1) ./ coef_line(:,2)), -(coef_line(:,3) ./ coef_line(:,2))];
    x1 = xrange(1);
    y1 = coefs(:, 1) * x1 + coefs(:, 2);
    x2 = xrange(2);
    y2 = coefs(:,1) * x2 + coefs(:,2);
    [x1 x2]
    [y1 y2]'
    plot([x1 x2], [y1 y2]', '-');
  endfunction
  
  function [x,y] = all_lines_intersections (X)    
    d = all2dets  ([X(:,1) X(:,2)]);
    dX = all2dets ([-X(:,3) X(:,2)]);
    dY = all2dets ([X(:,1) -X(:,3)]);

    x = dX ./ d;
    y = dY ./ d;
    
    function Y = all2dets (X1)
      i1 = X1(:,1) * ones(1, rows(X1));
      i2 = X1(:,2) * ones(1, rows(X1));

      j1 = i1';
      j2 = i2';

      Y = (i1.*j2) - (j1.*i2);
    endfunction
  endfunction
endfunction
