% do error checking for the different parts
if (strcmp(cond,'verbal') && seteq(resp.dist_resp{p,i,c},settings.letters{p,i})) || ...
   (strcmp(cond,'spatial') && all(all(resp.dist_resp{p,i,c} == settings.grid{p,i})))
  resp.dist_correct(p,i,c) = 1; 

  if strcmp(part,'search')
    if ~resp.target_task(p,i,c)
      drawText('ERROR ON T/L SEARCH',ws,0,1,[200 0 0]);
    else
      drawText('CORRECT',ws,0,1,[0 200 0]);
    end
  else       
    drawText('CORRECT',ws,0,1,[0 200 0]);
  end
else
  resp.dist_correct(p,i,c) = 0;

  if strcmp(part,'search')
    if ~resp.target_task(p,i,c)
      drawText('ERROR ON BOTH',ws,0,1,[200 0 0]);
    else
      drawText('ERROR ON MEMORY',ws,0,1,[200 0 0]);
    end
  else
    drawText('ERROR ON MEMORY',ws,0,1,[200 0 0]);
  end
end    
