# This function receives 
#   {lines} - cell of strings - words you are looking for
#   {filename} - string - name of input file. Remember, that first 4 lines will
#       be omitted
#   {savepath} - string - name of output file. This might be useful, if you
#       need to set custom path
#
# return value is cell of results for each line in format:
# { <line>, <first occurence>, <total count of occurences> }
#
# result also saves to file as
# <first occurence>\t<total count of occurences>
# for each line
function result = jabberwocky(lines = {'went', 'hand'}, filename = 'jabberwocky.txt', savepath = 'F:\University\5_semester\MP\hw3\jabberwocky-analysis.txt')
  text = fileread(filename);
  text = strsplit(text, {'\n'});
  text = {text{5:end}};
  
  result = cellfun("processline", lines, "UniformOutput", false);
  asArray = [cellfun(@(line)line{2}, result)' cellfun(@(line)line{3}, result)'];
  dlmwrite(savepath, asArray, 'delimiter', '\t');
  
  function lineresult = processline(line)
    indexes = strfind(text, line);
    indexes = cellfun(@(index) { index, indexes{index}}, num2cell(1:length(text)), "UniformOutput", false);
    indexes = {indexes{cellfun(@(row)length(row{2}) > 0, indexes)}};
    count = sum(cellfun(@(row) length(row{2}), indexes));
    firstLine = indexes{1}{1};
    lineresult = {line, firstLine, count};
  endfunction
endfunction
