n = 9;

mat = 1:n;
mat = mat.' * mat;

printf("n=%d\n\n", n);
disp(mat);