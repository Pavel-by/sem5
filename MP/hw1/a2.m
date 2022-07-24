n = 10;

mat = zeros(n);

mat(1:2:n, 2:2:n) = 1;
mat(2:2:n, 1:2:n) = 1;

printf("n=%d\n\n", n);
disp(mat);