n = 7;
x = [0,1,2,3];

mat = zeros(n*2, n*2);
mat(1:n, 1:n) = x(1);
mat(1:n, n+1:n*2) = x(2);
mat(n+1:n*2, 1:n) = x(3);
mat(n+1:n*2, n+1:n*2) = x(4);

printf("n=%d\n\n", n);
printf("x:\n");
disp(x);
printf("\nresult:\n");
disp(mat);