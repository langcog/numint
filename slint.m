% verbal/spatial grid forced choice
% - spatial grid originally given to me by todd thompson (don't know who wrote it)
% - mod mcf 10/10/08
%   rewrote, modularized, made it adaptive
% - now rewrite mcf 10/14/08
%   making it non-sequential in playback, should be harder
% - now this is a spatial interference task with addition in the middle
% - rewrite mcf 8/6/09, now this is a spatial intererence task that first
%   thresholds your spatial ability and then does number tasks
% - letter span version
% - consolidated/modified MCF 10/20/10 in order to address comments by
%   reviewers on version 1 of cogtech for cognitive psychology
  
function slint

home
subnum = input('Input subject number and press enter: ');

PsychJavaTrouble; % fix java issues
addpath('helper');
start_time = GetSecs;

settings = setSettings;

% QUESTION: are we in test mode?
test = 0;
if subnum == -1
  test = 1;
  settings.num_trials = [3 3];
  settings.num_dist(:,:,1) = 2; % initialize with minimum
  settings.num_dist(:,:,2) = 2; % initialize with minimum
  settings.order = {'spatial','verbal'};
elseif ~isempty(dir(['data/SLINT-' num2str(subnum) '.mat'])) && subnum~=-1 
  error('datafile already exists!')
end

ListenChar(2); % disable write to matlab

ws = doScreen;
Screen('TextSize',ws.ptr,settings.text_size);

%% staircase interference task
% approx 10s per trial, 50 trials = 500s < 8 min

resp.dist_correct = nan([settings.num_parts max(settings.num_trials) 2]);
resp.target_task = nan([settings.num_parts max(settings.num_trials) 2]);
resp.dist_rt = nan([settings.num_parts max(settings.num_trials) 2]);
resp.target_rt = nan([settings.num_parts max(settings.num_trials) 2]);
resp.times = nan(2,settings.num_parts);

for c = 1:length(settings.order) % LOOP OVER CONDITION 
  cond = settings.order{c}; % random order
  drawText(['PRESS ANY KEY TO START PART ' num2str(c)],ws,1);  

  for p = 1:settings.num_parts % LOOP OVER PART
    part = settings.part{p};
    drawText(['PRESS ANY KEY FOR SECTION ' num2str(p) '/2 OF PART ' num2str(c) '/2'],ws,1);
    
    setTrialStructure2; 
      
    for i = 1:settings.num_trials(p) % LOOP OVER TRIALS      
      if strcmp(part,'search'); % ADAPT NUMBER OF DISTRACTORS: 2up / 1down        
        settings.num_dist(p,i,c) = staircase2(settings.num_dist(p,:,c),...
          resp.dist_correct(p,1:i-1,c) & resp.target_task(p,1:i-1,c),settings.min_dist,i);
      end

      % DISTRACTOR PRESENTATION
      if strcmp(cond,'verbal')
        settings.letters{p,i} = getLetters(settings.num_dist(p,i,c));
        sequentialLetters(ws,settings,settings.letters{p,i});
      elseif strcmp(cond,'spatial')
        [settings.grid{p,i} settings.letters_ord{p,i}] = genShape(settings.grid_dims,settings.num_dist(p,i,c));
        dispGrid(ws,settings.num_dist(p,i,c),settings,settings.letters_ord{p,i});
      end

      % TARGET DISPLAY TASK (T-L/DOTS)
      if strcmp(part,'search')
        [resp.target_task(p,i,c) resp.target_rt(p,i,c)] = ...
          drawSearchDisplay(ws,settings,settings.num_search_items(c,i),settings.target_present(c,i));
      elseif strcmp(part,'numeric')
        drawDotsArraySequentialCenter(ws,settings,settings.num_dots(c,i));
        [resp.target_task(p,i,c) resp.target_rt(p,i,c)] = readInDotsResponse(ws,settings);
      end
      
      % DISTRACTOR RESPONSE
      if strcmp(cond,'verbal')
        [resp.dist_resp{p,i,c} resp.dist_rt(p,i,c)] = readInLettersResponse(ws,settings);
      elseif strcmp(cond,'spatial')
        [resp.dist_resp{p,i,c} resp.dist_rt(p,i,c)] = readInGridResponse(ws,settings);
      end

      % NOW DO ERROR-CHECKING FOR DISTRACTOR TASK
      ErrorCheckAndFeedback;
      WaitSecs(settings.feedback_dur);

      % save the data after every trial
      save(['data/' num2str(subnum) '-SLINT.mat'],'settings','resp');

      % now clear and wait
      Screen('Flip',ws.ptr);
      WaitSecs(settings.isi);      
    end
    
    settings.times(c,p) = GetSecs - start_time;
  end
end

% settings.times = diff([0 reshape(settings.times',1,6)]);
save(['data/' num2str(subnum) '-SLINT.mat'],'settings','resp');

%% clean up
clear screen
ListenChar(0); % enable write to matlab
ShowCursor
fprintf('*** total duration: %2.2f ***\n',round(GetSecs - start_time));
