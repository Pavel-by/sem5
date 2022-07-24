function task3(A)
  meanPoint = [mean(A(1,:)), mean(A(2,:))]
  B = A - meanPoint';
  C = rotate(A, 15);
  D = rotate(B, 25);
  plot(A(1,:), A(2,:), '-+k;A;');
  hold on;
  plot(meanPoint(1), meanPoint(2), '-*r;Центр масс;');
  plot(B(1,:), B(2,:), '-om; A с ЦМ в нуле;');
  plot(C(1,:), C(2,:), '-og; A 15deg;');
  plot(D(1,:), D(2,:), '-sb; B 25deg;');
  
  grid on;
  xlabel('x');
  ylabel('y');
  #print('filename.png');
  
  function B = rotate(A, deg)
    deg = deg / 360 * 2 * pi();
    B = [cos(deg)*A(1,:) - sin(deg)*A(2,:);sin(deg)*A(1,:) + cos(deg) * A(2,:)];
  endfunction
endfunction
