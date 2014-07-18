function drawDotsArraySequentialCenter(ws,settings,q)  
% make q dots in one location

diam = settings.dots.diam;

for i = 1:q
  Screen('DrawDots', ws.ptr, [ws.center(1) + (rand-.5)*150; ws.center(2) + (rand-.5)*150],...
    diam, ws.black, [0 0], 1);
  Screen('Flip',ws.ptr);
  WaitSecs(settings.dots.show_interval);
  Screen('Flip',ws.ptr);
  WaitSecs(settings.dots.between_interval);
end