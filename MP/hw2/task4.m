function A1 = task4 (A)
    A1 = A + (A .* (mod(A, 2) == 1));
endfunction
