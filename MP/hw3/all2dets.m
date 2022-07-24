function Y = all2dets (X)
  i1 = X(:,1) * ones(1, rows(X));
  i2 = X(:,2) * ones(1, rows(X));

  j1 = i1';
  j2 = i2';

  Y = (i1.*j2) - (j1.*i2);
endfunction