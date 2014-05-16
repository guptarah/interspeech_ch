function run_command()
train_file='appended_prob_train/laughter/training_matrix_100'
dev_file='appended_prob_dev/laughter/dev_matrix_100'
test_file='appended_prob_test/laughter/test_matrix_100'
dbn_size=50
save_file='output_laughter_100'
[dev_op,test_op] = encode(train_file,dev_file,test_file,dbn_size,save_file)
