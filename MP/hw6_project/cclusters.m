function cclusters(startConf)
  global conf;
  conf = startConf;
  
  conf.currentIteration = 0;
  generatePoints();
  conf.center = rand(conf.clustersCount, 2) .* conf.groupsDispersion
  conf.elementsCount *= conf.groupsCount;
  conf.u = zeros(conf.elementsCount, conf.clustersCount) + 0.5;
  conf.currentCluster = 1;
  
  conf.figure = figure(
    "Name", "C-Clusters", "numbertitle", "off",
    "position", [100, 100, 1200, 600]
  );
  axes("position", [0.1, 0.5, 0.8, 0.4]);
  
  conf.infoText = uicontrol(
    'style', 'text',
    'units', 'normalized',
    'position', [0.1, 0.3, 0.2, 0.1]
  );
  
  conf.nextStepButton = uicontrol(
    'style', 'pushbutton',
    'string', 'Следующий шаг',
    'units', 'normalized',
    'position', [0.35, 0.3, 0.25, 0.1],
    'callback', {@nextstep}
  );
  
  conf.lastStepButton = uicontrol(
    'style', 'pushbutton',
    'string', 'К последнему шагу',
    'units', 'normalized',
    'position', [0.65, 0.3, 0.25, 0.1],
    'callback', {@laststep}
  );
  
  x = 0.1;
  y = 0.1;
  h = 0.1;
  w = 0.8 / conf.clustersCount;
  
  for i = 1:conf.clustersCount
    uicontrol(
      'style', 'pushbutton',
      'string', num2str(i),
      'units', 'normalized',
      'position', [x, y, w, h],
      'callback', {@() selectCluster(i)}
    );
    x += w;
  endfor  
  
  conf.selectedClusterText = uicontrol(
    'style', 'text',
    'string', 'Выбранный кластер: 1',
    'units', 'normalized',
    'position', [0.1, .2, .8, .05]
  );
  
  drawClusters();
endfunction

function generatePoints()
  global conf;
  
  conf.points = [];
  for i = 1:conf.groupsCount
    center = rand(2, 1) .* conf.groupsDispersion
    points = [
      randn(conf.elementsCount, 1) * conf.elementsDispersion + center(1), randn(conf.elementsCount, 1) * conf.elementsDispersion + center(2)
    ];
    conf.points = [
      conf.points;
      points
    ];  
  endfor  
endfunction  

function selectCluster(index)
  global conf;
  
  set(conf.selectedClusterText, 'string', ['Выбранный кластер: ' num2str(index)]);
  conf.currentCluster = index;
  drawClusters();
endfunction

function nextstep()
  stepforward();
  drawClusters();
endfunction

function stepforward()  
  global conf;
  
  if (conf.currentIteration >= conf.iterationsLimit)
    drawClusters();
    return;  
  endif
  
  for i = 1:conf.elementsCount
    for j = 1:conf.clustersCount
      conf.u(i,j) = computeU(i, j);
    endfor  
  endfor
  
  for j = 1:conf.clustersCount
    conf.center(j,:) = computeC(j);
  endfor  
  
  conf.currentIteration += 1;
  
  set(conf.infoText, 'string', ['Текущая итерация: ' num2str(conf.currentIteration)]);
endfunction

function c = computeC(j) 
  global conf;
  
  u = conf.u(:,j) .^ conf.fuzziness;
  c = [
    sum(u .* conf.points(:,1)) / sum(u),
    sum(u .* conf.points(:,2)) / sum(u)
  ];
endfunction  

function u = computeU(i, j)
  global conf;
  
  point = conf.points(i, :);
  fpow = 2 / (conf.fuzziness);
  div = arrayfun(@(j) distance(conf.center(j, :), point), [1:conf.clustersCount]);
  u = 1 / sum((distance(conf.center(j,:), point) ./ div) .^ fpow);
endfunction

function d = distance(p1, p2)
  d = sqrt(sum((p1-p2).^2));
endfunction  

function laststep()
  global conf;
  while (conf.currentIteration < conf.iterationsLimit)
    stepforward();  
  endwhile
  drawClusters();
endfunction

function drawClusters()
  global conf;
  
  if (conf.currentIteration >= conf.iterationsLimit)
    set(conf.lastStepButton, 'enable', 'off');
    set(conf.nextStepButton, 'enable', 'off');
  endif  
  
  u = conf.u(:, conf.currentCluster);
  
  c = zeros(conf.elementsCount, 3);
  c(:,1) = 1;
  c(:,2) = 1 - u;
  c(:,3) = 1 - u;
  
  scatter(conf.points(:,1), conf.points(:,2), 50, c, "filled");
  hold on;
  scatter(conf.center(:,1), conf.center(:,2), 60, 'b', 'filled');
  scatter(
    conf.center(conf.currentCluster,1), 
    conf.center(conf.currentCluster,2), 
    60, 'r', 'filled'
  );
  hold off;
endfunction
