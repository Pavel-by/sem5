function process_controls(controls)
  conf = validate(controls);
  
  if (conf.success == true)
    cclusters(conf);
  endif
endfunction

function conf = validate(controls)
  conf.success = false;
  
  clustersCount = str2int(get(controls.clustersEditor).string);
  if (isnan(clustersCount))
    msgbox("Количество кластеров должно быть целым числом.");
    return;
  endif
  
  fuzziness = str2double(get(controls.fuzziEditor).string);
  if (isnan(fuzziness))
    msgbox("Коэффициент нечеткости должнен быть целым или дробным числом.");
    return;      
  endif
  
  iterationsLimit = str2int(get(controls.iterationsEditor).string);
  if (isnan(iterationsLimit))
    msgbox("Количество итераций должнено быть целым числом.");
    return;      
  endif
  
  
  groupsCount = str2int(get(controls.groupsEditor).string);
  if (isnan(groupsCount))
    msgbox("Количество групп должнено быть целым числом.");
    return;      
  endif
  
  elementsCount = str2int(get(controls.elementsEditor).string);
  if (isnan(elementsCount))
    msgbox("Количество элементов должнено быть целым числом.");
    return;      
  endif
  
  groupsDispersion = str2double(get(controls.groupsDispersionEditor).string);
  if (isnan(groupsDispersion))
    msgbox("Разброс групп должен быть числом");
    return;      
  endif
  
  elementsDispersion = str2double(get(controls.elementsDispersionEditor).string);
  if (isnan(elementsDispersion))
    msgbox("Разброс элементов должен быть числом");
    return;      
  endif
  
  if (elementsCount <= 0 || groupsCount <= 0)
    msgbox("Количества групп и элементов в группе быть положительными целыми числами.");  
    return;
  endif
  
  if (clustersCount < 2)
    msgbox("Минимальное количество кластеров равно двум.");  
    return;
  endif
  
  if (iterationsLimit < 1)
    msgbox("Должна быть как минимум одна итерация");
    return;
  endif

  if (fuzziness <= 1)
    msgbox("Коэффициент нечеткости должен быть больше 1.");
    return;
  endif
  
  if (elementsDispersion <= 0 || groupsDispersion <= 0)
    msgbox("Разбросы групп и элементов в группе должны быть положительными");
    return;
  endif  

  if (elementsCount < clustersCount)
    msgbox("Количество элементов не должно быть меньше количества кластеров.");
    return;
  endif  
  
  conf = struct();
  conf.clustersCount = clustersCount;
  conf.fuzziness = fuzziness;
  conf.iterationsLimit = iterationsLimit;
  conf.elementsCount = elementsCount;
  conf.groupsCount = groupsCount;
  conf.elementsDispersion = elementsDispersion;
  conf.groupsDispersion = groupsDispersion;
  conf.success = true;
endfunction

function result = str2int(str)
  result = str2double(str);
  
  if (result == NaN || mod(result, 1) != 0)
    result = NaN;
  endif
endfunction
