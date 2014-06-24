function sensitivity_analysis(output_dir)

addpath(genpath('/home/rcf-proj/mv/guptarah/DeepLearnToolbox/'));

% load the 
load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/classification/dnn/basic_dnn/dnn_basic.mat');
addpath(genpath('/home/rcf-proj/mv/guptarah/DeepLearnToolbox/'));

% load the normalized values already obtained
load('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/classification/dnn/basic_dnn/normalized_values.mat');

demo_test_data = zeros(size(norm_test_data));
for i = 1:size(norm_test_data,2)
	demo_test_data = zeros(size(norm_test_data));
	demo_test_data(:,i) = norm_test_data(:,i);
	[~, ~, demo_test_output] = nntest(dnn,demo_test_data,test_lables);

	save_file=strcat(output_dir,'/outputs_',num2str(i));	
	csvwrite(save_file,demo_test_output);
end
