function task5 (coef_line = [10,-11,5], xrange = [-1,1], yrange = [-1,1])
  a = coef_line(1);
  b = coef_line(2);
  c = coef_line(3);
  
  if (b == 0)
    x = -c / a;
    if (x > xrange(1) && x < xrange(2))
      plot([x,x],yrange);  
    endif
  elseif (a == 0)
    y = -c / b;
    if (y > yrange(1) && y < yrange(2))
      plot(xrange, [y,y]);
    endif
  else
    y1 = min(yrange(2), max(yrange(1), (-c - a*xrange(1)) / b));
    x1 = (-c - b*y1) / a;
    y2 = min(yrange(2), max(yrange(1), (-c - a*xrange(2)) / b));
    x2 = (-c - b*y2) / a;
    plot([x1,x2], [y1,y2]);
  endif
  
  grid on;
  axis([xrange + [-1 1], yrange + [-1 1]])
endfunction