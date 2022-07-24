function A1 = task2 (A)
  A1 = [A(rows(A)/2+1:end,:);A(1:rows(A)/2,:)];
endfunction
