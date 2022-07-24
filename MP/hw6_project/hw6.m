launcher = struct();
launcher.figure = figure("Name", "C-Clusters", "numbertitle", "off", 'position', [200, 150, 490, 520]);

alghp = uipanel('title', 'Параметры алгоритма', 'units', 'pixels', 'position', [30, 330, 430, 160]);
groupp = uipanel('title', 'Параметры генерации', 'units', 'pixels', 'position', [30, 100, 430, 200]);

uicontrol(
  'parent', alghp,
  'style', 'text',
  'string', 'Количество кластеров',
  'position', [15, 15, 250, 30]
);  
launcher.clustersEditor = uicontrol(
  'parent', alghp,
  'style', 'edit',
  'string', '5',
  'position', [265, 15, 150, 30]
);

uicontrol(
  'parent', alghp,
  'style', 'text',
  'string', 'Коэффициент нечеткости',
  'position', [15, 55, 250, 30]
);  
launcher.fuzziEditor = uicontrol(
  'parent', alghp,
  'style', 'edit',
  'string', '2',
  'position', [265, 55, 150, 30]
);

uicontrol(
  'parent', alghp,
  'style', 'text',
  'string', 'Количество итераций',
  'position', [15, 95, 250, 30]
); 
launcher.iterationsEditor = uicontrol(
  'parent', alghp,
  'style', 'edit',
  'string', '100',
  'position', [265, 95, 150, 30]  
);

uicontrol(
  'parent', groupp,
  'style', 'text',
  'string', 'Количество групп',
  'position', [15, 135, 250, 30]
); 
launcher.groupsEditor = uicontrol(
  'parent', groupp,
  'style', 'edit',
  'string', '3',
  'position', [265, 135, 150, 30]
);

uicontrol(
  'parent', groupp,
  'style', 'text',
  'string', 'Элементов в группе',
  'position', [15, 95, 250, 30]
); 
launcher.elementsEditor = uicontrol(
  'parent', groupp,
  'style', 'edit',
  'string', '25',
  'position', [265, 95, 150, 30]
);

uicontrol(
  'parent', groupp,
  'style', 'text',
  'string', 'Разброс групп',
  'position', [15, 55, 250, 30]
); 
launcher.groupsDispersionEditor = uicontrol(
  'parent', groupp,
  'style', 'edit',
  'string', '150',
  'position', [265, 55, 150, 30]
);

uicontrol(
  'parent', groupp,
  'style', 'text',
  'string', 'Разброс элементов',
  'position', [15, 15, 250, 30]
); 
launcher.elementsDispersionEditor = uicontrol(
  'parent', groupp,
  'style', 'edit',
  'string', '10',
  'position', [265, 15, 150, 30]
);

uicontrol(
  'style', 'pushbutton',
  'string', 'Смоделировать',
  'position', [30, 20, 430, 60],
  'callback', {@() process_controls(launcher)}
);