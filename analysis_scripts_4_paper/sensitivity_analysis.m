function sensitivity_analysis()

% load the dnn
load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/classification/dnn/basic_dnn/dnn_basic.mat');
addpath(genpath('/home/rcf-proj/mv/guptarah/DeepLearnToolbox/'));

sens_clm = -1:.1:1;
sens_data1 = [sens_clm  zeros(21,16)];

sens_data = sens_data1;
for i = 1:16
	sens_data_temp = circshift(sens_data1',i)';
	sens_data = [sens_data; sens_data_temp];
end

dummy_lables = [ones(357,1) zeros(357,2)];
[~, ~, output] = nntest(dnn, sens_data, dummy_lables);

% first plot mfccs
close all;
% for laughter
figure;
subplot(1,2,1)
hold on;
symbols = {'r','b','k','g','c','m','r','b','k','g','c','m'};
for i = 0:11
	if i == 6
		legend('mfcc1','mfcc2','mfcc3','mfcc4','mfcc5','mfcc6');
		ylim([.4 .8]);
		title('(a)');
		subplot(1,2,2);	
		hold on;
	end
	plot(-1:.1:1,output(21*i+1:21*(i+1),2),symbols{i+1});
end
ylim([.4 .8]);
legend('mfcc7','mfcc8','mfcc9','mfcc10','mfcc11','mfcc12');
title('(b)');

% for fillers
figure;
subplot(1,2,1)
hold on;
symbols = {'r','b','k','g','c','m','r','b','k','g','c','m'};
for i = 0:11
        if i == 6
%                legend('mfcc1','mfcc2','mfcc3','mfcc4','mfcc5','mfcc6');
                ylim([.07 .16]);
		title('(c)');
                subplot(1,2,2);
                hold on;
        end
        plot(-1:.1:1,output(21*i+1:21*(i+1),3),symbols{i+1});
end
ylim([.07 .16]);
%legend('mfcc7','mfcc8','mfcc9','mfcc10','mfcc11','mfcc12');
title('(d)')

% for prosodic features
% laughters
figure;
hold on;
symbols = {'r','b','k','g','c','m','r','b','k','g','c','m'};
for i = 12:16
        plot(-1:.1:1,output(21*i+1:21*(i+1),2),symbols{i-11});
end
legend('Log energy','Voicing probability','HNR','F0','Zero-crossing rate');
title('(a)');

% fillers 
figure;
hold on;
symbols = {'r','b','k','g','c','m','r','b','k','g','c','m'};
for i = 12:16
        plot(-1:.1:1,output(21*i+1:21*(i+1),3),symbols{i-11});
end
%legend('Log energy','Voicing probability','HNR','F0','Zero-crossing rate');
title('(b)');
