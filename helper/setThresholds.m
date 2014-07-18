% set up number of grid tiles and number of dots
if test, threshold = 5;
else threshold = floor(mean(stair.num_letters(end-30:end))); end

settings.num_int(c,:) = repmat(threshold,1,settings.num_trials);
settings.num_dots(c,:) = repmat(4:12,1,settings.num_trials/8);
settings.num_dots(cm:) = settings.num_dots(randperm(settings.num_trials));
