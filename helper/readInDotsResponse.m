function [r rt2] = readInDotsResponse(ws,settings)

r = 0;
accepted_keys = {'RETURN','ENTER','DELETE',' '};

start_time = GetSecs;
running = 1;
first = 1;

drawDotsRow(ws,settings,r);

while running % keep doing this until we hit enter
  pressed_key = getResponseKeypad(accepted_keys);

  if first % only do this for the first keypress
    first = 0; 
    first_time = GetSecs;
    rt1 = first_time - start_time;
  end

  switch pressed_key % now decide what to do with the keypress    
    case 'RETURN'
      running = 0;
    case 'ENTER'
      running = 0;
    case 'DELETE'
      r = r - 1;
      drawDotsRow(ws,settings,r);
    case ' '
      r = r + 1;
      drawDotsRow(ws,settings,r);
  end
end

end_time = GetSecs;
rt2 = end_time - start_time;


function drawDotsRow(ws,settings,r)

diam = settings.dots.diam;
offset = 25;

posx = [];
posy = [];

for i = 1:r
  posx = [posx offset + i*diam*1.2];
  posy = [posy ws.halfh];
end
  
for i = 1:length(posx)  
  Screen('DrawDots', ws.ptr, [posx; posy], diam, ws.black, [0 0], 1);  
end

instructions = 'Press space to put out the same number of dots (backspace to delete).';
ts = Screen('TextBounds',ws.ptr,instructions);
Screen('DrawText',ws.ptr,instructions,ws.center(1) - (ts(3)/2),10,ws.black);
Screen('Flip',ws.ptr);


