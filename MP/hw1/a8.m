n = 5;

## ������� ������� 
## 1  n+1 (n+1)*2 ...
## 1  n+1 (n+1)*2 ...
## 1  n+1 (n+1)*2 ...
## ...
triangle = ones(n, 1) * [1:n+1:n*n];

## ����������� � �������, ��� ���� ������� ��������� 
## ����� ������ ����, ���� - ������ ����, � �� ������� - ����
triangle = triangle - reshape([1:n*n], n, n);

mat = ones(n, 1) * [1:n];
mat = [1, 2]((mod(mat, 2) == 0) + ones(n));

mat = (mat .* (triangle <= 0)) + (mat .* (triangle < 0))';

printf("n=%d\n\n", n);
disp(mat);