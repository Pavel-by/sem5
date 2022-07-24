function [x,y] = all_lines_intersections (fname)
  fid = fopen(fname, "rt");
  X = dlmread(fid);
  fclose(fid);
  
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