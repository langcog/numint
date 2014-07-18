% this is just a compression wrapper for setting up the target arrays in
% each trial type

% set up number of grid tiles and number of dots
if ~test
  threshold = floor(nanmean(settings.num_dist(1,end-30:end,c)));
  settings.num_dist(2:3,:,c) = threshold;
end

% set up dots
quants = repmat(settings.quants,1,6);
quants = [quants 11 12 13 14 15];
quants = quants(randperm(length(quants)));
settings.num_dots(c,:) = quants;

% set up T/L search
num_search_items = repmat([4 8 12],1,20);
num_search_items = num_search_items(randperm(length(num_search_items)));
settings.num_search_items(c,:) = num_search_items;
settings.target_present(c,:) = rand(size(num_search_items)) > .5;