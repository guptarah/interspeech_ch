function get_pdf_plots(prob_file,target_file,nbins)

%%
% prob_vals : containing values for both laughter and filler ex: ../classification/dnn/results/test_output_basic_dnn
% target : 2nd column containing targets for laughter, 3rd column for
% filler ex : ../classification/dnn/basic_dnn/test_lables

% for feature context only 
prob_file = '../classification/dnn/results/test_output_basic_dnn';
target_file = '../classification/dnn/basic_dnn/test_lables';

nbins=100;

prob_vals = load(prob_file);
target = load(target_file);

% for laughters
l_target = target(:,2);
vals0 = prob_vals(find(l_target==0),2);
vals1 = prob_vals(find(l_target==1),2);

close all;
figure;
subplot(3,2,1);
h0 = hist(vals0,nbins);
h0 = h0/sum(h0);
%plot(0.01:0.01:1,h0,'-.r');
B1=bar(0.01:.01:1,h0,'r');
ch = get(B1,'child');
set(ch,'facea',.3)
title('(1a)');
ylabel('Empirical probability');
xlabel('Confidence values');
hold on;
h1 = hist(vals1,nbins);
h1 = h1/sum(h1);
%plot(0.01:0.01:1,h1,'-.b');
B2=bar(0.01:.01:1,h1,'b');
ch = get(B2,'child');
set(ch,'facea',.3)
xlim([0 1.02]);
legend('Frames without laughter','Frames with laughter');
ylabel('Empirical probability');
xlabel('Confidence values');
ylim([0 .12])
% for fillers
f_target = target(:,3);
vals0 = prob_vals(find(f_target==0),3);
vals1 = prob_vals(find(f_target==1),3);

subplot(3,2,2);
h0 = hist(vals0,nbins);
h0 = h0/sum(h0);
%plot(0.01:0.01:1,h0,'-.r');
B1=bar(0.01:.01:1,h0,'r');
ch = get(B1,'child');
set(ch,'facea',.3);
hold on;
B2=bar(0.01:.01:1,h1,'b');
ch = get(B2,'child');
set(ch,'facea',.3)
h1 = hist(vals1,nbins);
h1 = h1/sum(h1);
%plot(0.01:0.01:1,h1,'-.b');
xlim([0 1.02])
title('(1b)');
ylabel('Empirical probability');
xlabel('Confidence values');
legend('Frames without filler','Frames with filler');

%%
% after decision context

prob_file = '../smoothing/prob_encoding/results/results_test.best';
target_file = '../classification/dnn/basic_dnn/test_lables';

prob_vals = load(prob_file);
target = load(target_file);

% for laughters
l_target = target(:,2);
vals0 = prob_vals(find(l_target==0),2);
vals1 = prob_vals(find(l_target==1),2);



subplot(3,2,3);
h0 = hist(vals0,nbins);
h0 = h0/sum(h0);
%plot(0.01:0.01:1,h0,'-.r');
B1=bar(0.01:.01:1,h0,'r');
ch = get(B1,'child');
set(ch,'facea',.3)
title('(2a)');
ylabel('Empirical probability');
xlabel('Confidence values');
hold on;
h1 = hist(vals1,nbins);
h1 = h1/sum(h1);
%plot(0.01:0.01:1,h1,'-.b');
B2=bar(0.01:.01:1,h1,'b');
ch = get(B2,'child');
set(ch,'facea',.3)
xlim([0 1.02]);
ylabel('Empirical probability');
xlabel('Confidence values');
ylim([0 0.12]);

% for fillers
f_target = target(:,3);
vals0 = prob_vals(find(f_target==0),3);
vals1 = prob_vals(find(f_target==1),3);

subplot(3,2,4);
h0 = hist(vals0,nbins);
h0 = h0/sum(h0);
%plot(0.01:0.01:1,h0,'-.r');
B1=bar(0.01:.01:1,h0,'r');
ch = get(B1,'child');
set(ch,'facea',.3);
hold on;
B2=bar(0.01:.01:1,h1,'b');
ch = get(B2,'child');
set(ch,'facea',.3)
h1 = hist(vals1,nbins);
h1 = h1/sum(h1);
%plot(0.01:0.01:1,h1,'-.b');
xlim([0 1.02])
title('(2b)');
ylabel('Empirical probability');
xlabel('Confidence values');
ylim([0 0.12]);

%%
% after masking
prob_file = '../masking/test.results';
target_file = '../classification/dnn/basic_dnn/test_lables';

prob_vals = load(prob_file);
target = load(target_file);

% for laughters
l_target = target(:,2);
vals0 = prob_vals(find(l_target==0),2);
vals1 = prob_vals(find(l_target==1),2);


subplot(3,2,5);
h0 = hist(vals0,nbins);
h0 = h0/sum(h0);
%plot(0.01:0.01:1,h0,'-.r');
B1=bar(0.01:.01:1,h0,'r');
ch = get(B1,'child');
set(ch,'facea',.3)
title('(3a)');
ylabel('Empirical probability');
xlabel('Confidence values');
hold on;
h1 = hist(vals1,nbins);
h1 = h1/sum(h1);
%plot(0.01:0.01:1,h1,'-.b');
B2=bar(0.01:.01:1,h1,'b');
ch = get(B2,'child');
set(ch,'facea',.3)
xlim([0 1.02]);
ylabel('Empirical probability');
xlabel('Confidence values');
ylim([0 0.12])

% for fillers
f_target = target(:,3);
vals0 = prob_vals(find(f_target==0),3);
vals1 = prob_vals(find(f_target==1),3);

subplot(3,2,6);
h0 = hist(vals0,nbins);
h0 = h0/sum(h0);
%plot(0.01:0.01:1,h0,'-.r');
B1=bar(0.01:.01:1,h0,'r');
ch = get(B1,'child');
set(ch,'facea',.3);
hold on;
B2=bar(0.01:.01:1,h1,'b');
ch = get(B2,'child');
set(ch,'facea',.3)
h1 = hist(vals1,nbins);
h1 = h1/sum(h1);
%plot(0.01:0.01:1,h1,'-.b');
xlim([0 1.02])
title('(3b)');
ylabel('Empirical probability');
xlabel('Confidence values');
ylim([0 0.12])
