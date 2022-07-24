function XY = task5 (C1 = [0,0,5], C2 = [6,2,2])
  drawcircle(C1(1), C1(2), C1(3));
  hold on;
  grid on;
  drawcircle(C2(1), C2(2), C2(3));
  a = 1/(C2(1) - C1(1));
  b = -1/(C2(2) - C1(2));
  l = min(C2(3)*0.8, C1(3)*0.8);
  k = l / sqrt(a^2+b^2);
  distance = sqrt((C1(1)-C2(1))^2 + (C1(2)-C2(2))^2);
  d = C1(3)+C2(3)-distance;
  
  if (d < 0)
    error("No interception points");
  endif
  
  center = [(C1(1)+C2(1))*(C1(3) - d/2)/distance, (C1(2)+C2(2))*(C1(3) - d/2)/distance];
  p1 = center + [a*k,b*k];
  p2 = center - [a*k,b*k];
  res1 = fsolve(@(x) f(x, C1, C2), p1);
  res2 = fsolve(@(x) f(x, C1, C2), p2);
  
  plot(res1(1), res1(2), "*r");
  plot(res2(1), res2(2), "*r");
  
  XY = [res1',res2'];
  
  function drawcircle(x, y, r)
    t = linspace(0,2*pi,100)'; 
    circsx = r.*cos(t) + x; 
    circsy = r.*sin(t) + y; 
    plot(circsx, circsy);   
  endfunction
endfunction

function y = f(x, C1, C2)
  y = zeros(2, 1);
  y(1) = (x(1) - C1(1))^2 + (x(2) - C1(2))^2 - C1(3)^2;
  y(2) = (x(1) - C2(1))^2 + (x(2) - C2(2))^2 - C2(3)^2;
endfunction
