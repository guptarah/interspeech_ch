% matlab script to z-normzlize files before training

%% first load the entire data to get the mean and std

if (exist('mu_sigma_all_data.mat', 'file') == 2) && (exist('normalized_values.mat', 'file') ~= 2))
	disp ('loading existing means and sigma');whos
	load('mu_sigma_all_data.mat');
elseif (exist('normalized_values.mat', 'file') ~= 2)
	disp ('extracting means and sigma')
	all_train_data = load('all_train_data');
	[~,mu,sigma] = zscore(all_train_data);
	save('mu_sigma_all_data.mat',mu,sigma);
end

%%

if exist('normalized_values.mat', 'file') ~= 2
    train_data = load('train_data');
    norm_train_data = (train_data - repmat(mu,size(train_data,1),1))./repmat(sigma,size(train_data,1),1);
    train_lables = load('train_lables');

    dev_data = load('dev_data');
    norm_dev_data = (dev_data - repmat(mu,size(dev_data,1),1))./repmat(sigma,size(dev_data,1),1);
    dev_lables = load('dev_lables');

    test_data = load('test_data');
    norm_test_data = (test_data - repmat(mu,size(test_data,1),1))./repmat(sigma,size(test_data,1),1);
    test_lables = load('test_lables');
    s
    save('normalized_values.mat','norm_train_data','train_lables','norm_dev_data','dev_lables','norm_test_data','test_lables');

else 
    load('normalized_values.mat');
   
end

% first get results on dev
addpath(genpath('/home/rcf-proj/mv/guptarah/DeepLearnToolbox/'));
nbClasses = 3;
dbn_size = [32 16];
[dnn,dev_output] = train_dnn(nbClasses,norm_train_data,train_lables,norm_dev_data,dev_lables,dbn_size);

% get results on test
[~, ~, test_output] = nntest(dnn, norm_test_data, test_lables);

save('dnn_basic.mat','dnn');
csvwrite('dev_outputs',dev_output);
csvwrite('test_outputs',test_output);

