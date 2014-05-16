#! /usr/bin/python

import numpy
import sys

test_file = sys.argv[1]
output_file = sys.argv[2]
test_probs = numpy.genfromtxt(test_file,delimiter=',')

test_laughter = numpy.concatenate((numpy.matrix(0),numpy.matrix(test_probs[:,1]),numpy.matrix(0)),axis=1)
test_filler = numpy.concatenate((numpy.matrix(0),numpy.matrix(test_probs[:,2]),numpy.matrix(0)),axis=1)

# for laughter
frame_len = 150
prob_thresh = 0.988

test_mask_laugh = (test_laughter > prob_thresh)*1
end_points = numpy.nonzero((numpy.diff(test_mask_laugh)==-1)*1)
start_points = numpy.nonzero((numpy.diff(test_mask_laugh)==1)*1)

win_index = numpy.vstack((start_points[1],end_points[1])).T
win_lens = win_index[:,1]-win_index[:,0]

win_start_use = numpy.array(start_points[1].T[win_lens>frame_len])
win_end_use = numpy.array(end_points[1].T[win_lens>frame_len])

test_laughter = test_laughter[0,1:-1]
# setting values to ones
for id_win_num in range(0,win_start_use.shape[1]):
	test_laughter[0,win_start_use[0,id_win_num]:win_end_use[0,id_win_num]] = 1

# for filler
frame_len = 40
prob_thresh = 0.982

test_mask_filler = (test_filler > prob_thresh)*1
end_points = numpy.nonzero((numpy.diff(test_mask_filler)==-1)*1)
start_points = numpy.nonzero((numpy.diff(test_mask_filler)==1)*1)

win_index = numpy.vstack((start_points[1],end_points[1])).T
win_lens = win_index[:,1]-win_index[:,0]

win_start_use = numpy.array(start_points[1].T[win_lens>frame_len])
win_end_use = numpy.array(end_points[1].T[win_lens>frame_len])

test_filler = test_filler[0,1:-1]
# setting values to ones 
for id_win_num in range(0,win_start_use.shape[1]):
        test_filler[0,win_start_use[0,id_win_num]:win_end_use[0,id_win_num]] = 1

# complete the matrix and save it
summed_probs = numpy.ones((test_laughter.shape[1],1)) - test_laughter.T - test_filler.T
complete_matrix = numpy.concatenate((summed_probs,test_laughter.T,test_filler.T),axis=1)

numpy.savetxt(output_file,complete_matrix,fmt='%f',delimiter=',')

