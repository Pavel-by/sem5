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
    msgbox("���������� ��������� ������ ���� ����� ������.");
    return;
  endif
  
  fuzziness = str2double(get(controls.fuzziEditor).string);
  if (isnan(fuzziness))
    msgbox("����������� ���������� ������� ���� ����� ��� ������� ������.");
    return;      
  endif
  
  iterationsLimit = str2int(get(controls.iterationsEditor).string);
  if (isnan(iterationsLimit))
    msgbox("���������� �������� �������� ���� ����� ������.");
    return;      
  endif
  
  
  groupsCount = str2int(get(controls.groupsEditor).string);
  if (isnan(groupsCount))
    msgbox("���������� ����� �������� ���� ����� ������.");
    return;      
  endif
  
  elementsCount = str2int(get(controls.elementsEditor).string);
  if (isnan(elementsCount))
    msgbox("���������� ��������� �������� ���� ����� ������.");
    return;      
  endif
  
  groupsDispersion = str2double(get(controls.groupsDispersionEditor).string);
  if (isnan(groupsDispersion))
    msgbox("������� ����� ������ ���� ������");
    return;      
  endif
  
  elementsDispersion = str2double(get(controls.elementsDispersionEditor).string);
  if (isnan(elementsDispersion))
    msgbox("������� ��������� ������ ���� ������");
    return;      
  endif
  
  if (elementsCount <= 0 || groupsCount <= 0)
    msgbox("���������� ����� � ��������� � ������ ���� �������������� ������ �������.");  
    return;
  endif
  
  if (clustersCount < 2)
    msgbox("����������� ���������� ��������� ����� ����.");  
    return;
  endif
  
  if (iterationsLimit < 1)
    msgbox("������ ���� ��� ������� ���� ��������");
    return;
  endif

  if (fuzziness <= 1)
    msgbox("����������� ���������� ������ ���� ������ 1.");
    return;
  endif
  
  if (elementsDispersion <= 0 || groupsDispersion <= 0)
    msgbox("�������� ����� � ��������� � ������ ������ ���� ��������������");
    return;
  endif  

  if (elementsCount < clustersCount)
    msgbox("���������� ��������� �� ������ ���� ������ ���������� ���������.");
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
