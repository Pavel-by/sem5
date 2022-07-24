# В txt хранится:
# %d\t%d\n
# %d\t%d\n
# и матрица, разделенная табуляцией
# нужно извлечь подматрицу
function task()
  fid = fopen('F:\University\5_semester\MP\temp\matr.txt', "rt");
  lfid = fopen('F:\University\5_semester\MP\temp\log.txt', "at+");

  if (fid == -1)
    fprintf(lfid, "%s", "Failed to open file\n");
    fclose(lfid);
    return;
  endif
  
  [s_c, read_count_s, err] = fscanf(fid, "%d", 2);
  [e_c, read_count_e, err] = fscanf(fid, "%d", 2);
  matr = dlmread(fid);
  
  if (read_count_e != 2 || read_count_s != 2)
    fprintf(lfid, "Wrong file format\n");
    fclose(lfid);
    return;
  endif
  
  if (s_c(1) < 1 || s_c(2) < 1 || s_c(1) > rows(matr) || s_c(2) > columns(matr))
    fprintf(lfid, "Wrong start coords\n");
    fclose(lfid);
    return;
  endif
  
  if (e_c(1) < s_c(1) || e_c(2) < s_c(2) || e_c(1) > rows(matr) || e_c(2) > columns(matr))
    fprintf(lfid, "Wrong end coords\n");
    fclose(lfid);
    return;
  endif
  
  result = matr(s_c(1):e_c(1), s_c(2):e_c(2))
  dlmwrite(lfid, result, " ");

  fclose(fid);
  fclose(lfid);
endfunction
