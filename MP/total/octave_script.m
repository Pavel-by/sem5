A = dlmread('input.txt');

# 1
printf("Task 1\n");
mSize = rows(A);
A1 = A;
for i = 1:mSize
  t = A1(i,i);
  A1(i,i) = A(i,mSize-i+1);
  A1(i,mSize-i+1) = t;
endfor
A1

# 2
printf("Task 2\n");
A2 = A;
A2(A2 < 0) = 0

# 3
printf("Task 3\n");
t3_ok = false;
if mod(mSize, 2) == 0
  t3_ok = true;
  A3_1 = A(1:mSize/2, 1:mSize/2)
  A3_2 = A((mSize/2+1):mSize, 1:mSize/2)
  A3_3 = A(1:mSize/2, (mSize/2+1):mSize)
  A3_4 = A((mSize/2+1):mSize, (mSize/2+1):mSize)
else
  printf("I can't split matrix on 4 smaller\n");
endif

# 4
printf("Task 4\n");
printf("WTF\n");

#5
f = fopen('F:\University\5_semester\MP\total\output.txt', 'w');

fprintf(f, 'Task1\n');
dlmwrite(f, A1, "-append");

fprintf(f, '\nTask2\n');
dlmwrite(f, A2, "-append");

fprintf(f, '\nTask3\n');
if t3_ok
  fprintf(f, 'A3_1\n');
  dlmwrite(f, A3_1, "-append");
  fprintf(f, 'A3_2\n');
  dlmwrite(f, A3_2, "-append");
  fprintf(f, 'A3_3\n');
  dlmwrite(f, A3_3, "-append");
  fprintf(f, 'A3_4\n');
  dlmwrite(f, A3_4, "-append");
else
  fprintf(f, "I can't split matrix on 4 smaller\n");
endif

fprintf(f, "\nTask 4\n");
fprintf(f, "WTF\n");

fclose(f);