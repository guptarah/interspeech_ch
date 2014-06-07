function get_event_stats()

train_lables = load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/classification/dnn/basic_dnn/train_lables');
dev_lables = load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/classification/dnn/basic_dnn/dev_lables');
test_lables = load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/classification/dnn/basic_dnn/test_lables');


lables = [train_lables;test_lables;dev_lables];
diff_lables = diff(lables);

laughter_starts = find(diff_lables(:,2) == 1);
laughter_ends = find(diff_lables(:,2) == -1);

filler_starts = find(diff_lables(:,3) == 1);
filler_ends = find(diff_lables(:,3) == -1);

% get the stats
filler_mean = mean(-filler_starts + filler_ends)
filler_std = std(-filler_starts + filler_ends)
filler_min = min(-filler_starts + filler_ends)
filler_max = max(-filler_starts + filler_ends)

laughter_mean = mean(-laughter_starts + laughter_ends)
laughter_std = std(-laughter_starts + laughter_ends)
laughter_min = min(-laughter_starts + laughter_ends)
laughter_max = max(-laughter_starts + laughter_ends)
