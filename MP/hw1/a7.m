n = 5;
a = 4;
b = 2;

arr1 = [1:n];
arr1(:) = a;

arr2 = [1:n-1];
arr2(:) = b;

mat = diag(arr1) + diag(arr2, 1) + diag(arr2, -1);

printf("n=%d, a=%d, b=%d\n\n", n, a, b);
disp(mat);