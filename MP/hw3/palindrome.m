function palindrome (str)
  str = regexprep(str, '[^A-Za-z]', '');
  str = tolower(str);
  if ((fliplr(str) - str) == 0)
    printf('Palindrome!\n');
  else
    printf('Not palindrome\n');
  endif
endfunction
