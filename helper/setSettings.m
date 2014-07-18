function settings = setSettings

% set fixation and presentation times for trials
settings.isi = .5;
settings.before_trial_interval = .5;
settings.tile_time = .3;
settings.fix_time = .3;
settings.trial_time_limit = 10;

settings.feedback_dur = .7;
settings.num_trials = [60 66];
settings.grid_dims = [4 4];
settings.tile_dim = 2; % dimension on which to tile
settings.box_size = 125; % size of boxes in grid 
settings.min_tiles = 3;
settings.min_digits = 3;
settings.min_letters = 3;
settings.min_dist = 2;
settings.text_size = 50;
settings.resp_len = 3;
settings.digits_resp_len = 10;

settings.space_dim = [800 800];
settings.dots.diam = 63;
settings.dots.show_interval = .5;
settings.dots.between_interval = .25;

settings.quants = 1:10;

settings.order = {'verbal','spatial'};
settings.part = {'search','numeric'};
settings.order = settings.order(randperm(length(settings.order)));
settings.num_parts = length(settings.part);

settings.num_dist = nan([settings.num_parts max(settings.num_trials) 2]);
settings.num_dist(:,1:3,:) = settings.min_dist; % initialize with minimum
