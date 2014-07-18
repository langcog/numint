function [resp rt] = drawSearchDisplay(ws,settings,n,target)

% make items
if target 
  items = [repmat('T',1,n-1) 'L'];
else
  items = [repmat('T',1,n)];  
end

ts = Screen('TextBounds',ws.ptr,'T');
diam = max(ts) * 1.2;

posx = [];
posy = [];

for j = 1:n
  tx = ws.center(1)+round((rand-.5)*settings.space_dim(2));
  ty = ws.center(2)+round((rand-.5)*settings.space_dim(1));
  dist = sqrt(((posx-tx).^2) + (posy-ty).^2);

  i = 1;
  % repeat until they're not overlapping
  while sum(dist < (diam)+1)
    tx = ws.center(1)+round((rand-.5)*settings.space_dim(2));
    ty = ws.center(2)+round((rand-.5)*settings.space_dim(1));
    dist = sqrt(((posx-tx).^2) + (posy-ty).^2);
    i = i + 1;
    if i > 2000, disp('**ACK**'); break; end;
  end

  posx = [posx tx];
  posy = [posy ty];
end

% now draw
for i = 1:n
  Screen('DrawText',ws.ptr,items(i),posx(i),posy(i),ws.black);
end

%% now get input
instructions = 'Press L if there is an L present, K otherwise.';
ts = Screen('TextBounds',ws.ptr,instructions);
Screen('DrawText',ws.ptr,instructions,ws.center(1) - (ts(3)/2),20,ws.black);
Screen('Flip',ws.ptr);

%% now get input
r = 0;
accepted_keys = {'L','K','l','k'};

start_time = GetSecs;
pressed_key = getSingleResponseKeypad(accepted_keys);

if (upper(pressed_key) == 'L' && target) || (upper(pressed_key) == 'K' && ~target)
  resp = 1; 
else
  resp = 0; 
end;

rt = GetSecs - start_time;
