function get_ts_plots(prob_file,target_file,l_start,f_start)

%%
% prob_vals : containing values for both laughter and filler e.g. ../classification/dnn/results/test_output_basic_dnn
% target : 2nd column containing targets for laughter, 3rd column for
% filler e.g. ../classification/dnn/basic_dnn/test_lables

if nargin == 2
    l_start = 14000;
    f_start = 2300;
end

prob_vals = load(prob_file);
target = load(target_file);

% for laughters
close all;
figure;
subplot(2,1,1);
vals = prob_vals(l_start:l_start+1100,2);
labs = target(l_start:l_start+1100,2);
hold on;
plot(1:1101,vals,'r-','LineWidth',.7);
plot(1:1101,labs,'-b','LineWidth',2);
legend('Obtained probability','Target probability');
plot(1:1101,vals,'r-','LineWidth',.7);

xlabel('Frame number');
ylabel('Probability');

ylim([0 1.1]);
title('(a)')
% for fillers
subplot(2,1,2);
vals = prob_vals(f_start:f_start+1100,3);
labs = target(f_start:f_start+1100,3);
hold on;
plot(1:1101,vals,'r-','LineWidth',.7);
plot(1:1101,labs,'-b','LineWidth',2);
%legend('Obtained probability','Target probability');
plot(1:1101,vals,'r-','LineWidth',.7);
xlabel('Frame number');
ylabel('Probability');
title('(b)');
ylim([0 1.1]);

