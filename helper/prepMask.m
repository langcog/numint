function mask = prepMask(ws,settings)

% mask = double(rand(700)>.5)*255; % make a random mask
m = repmat(spatialPattern(settings.space_dim+100,-1),[1 1 3]);
m = m + abs(min(min(min(m))));
m = m .* (255/max(max(max(m))));
mask = Screen('MakeTexture',ws.ptr,m); % turn it ito a texture

m(1:10,1:10,3)