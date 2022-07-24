function a = sieve(count)
  vec = 2:count;
  index = 1;
  
  while (vec(index) <= sqrt(count) && index <= length(vec))
    vec = filter_multiples(vec, vec(index));
    index++;
  endwhile
  
  a = vec;
endfunction

function a1 = filter_multiples (a, k)
  a1 = a((a <= k) | (mod(a, k) != 0));
endfunction