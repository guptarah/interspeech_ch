#! /usr/bin/python

import numpy
import sys

dev_file = sys.argv[1]
frame_len = int(sys.argv[2])
prob_thresh = float(sys.argv[3])/1000

dev_probs = numpy.genfromtxt(dev_file,delimiter=',')

dev_laughter = numpy.concatenate((numpy.matrix(1),numpy.matrix(dev_probs[:,1]),numpy.matrix(1)),axis=1)
dev_filler = numpy.concatenate((numpy.matrix(1),numpy.matrix(dev_probs[:,2]),numpy.matrix(1)),axis=1)


# for laughter
dev_mask_laugh = (dev_laughter < prob_thresh)*1
end_points = numpy.nonzero((numpy.diff(dev_mask_laugh)==-1)*1)
start_points = numpy.nonzero((numpy.diff(dev_mask_laugh)==1)*1)

win_index = numpy.vstack((start_points[1],end_points[1])).T
win_lens = win_index[:,1]-win_index[:,0]

win_start_use = numpy.array(start_points[1].T[win_lens>frame_len])
win_end_use = numpy.array(end_points[1].T[win_lens>frame_len])

numpy.savetxt('temp1',win_start_use.T,'%f')
numpy.savetxt('temp2',win_end_use.T,'%f')


dev_laughter = dev_laughter[0,1:-1]
# setting values to zeros
for id_win_num in range(0,win_start_use.shape[1]):
	dev_laughter[0,win_start_use[0,id_win_num]+10:win_end_use[0,id_win_num]-10] = 0

# for filler
dev_mask_filler = (dev_filler < prob_thresh)*1
end_points = numpy.nonzero((numpy.diff(dev_mask_filler)==-1)*1)
start_points = numpy.nonzero((numpy.diff(dev_mask_filler)==1)*1)

win_index = numpy.vstack((start_points[1],end_points[1])).T
win_lens = win_index[:,1]-win_index[:,0]

win_start_use = numpy.array(start_points[1].T[win_lens>frame_len])
win_end_use = numpy.array(end_points[1].T[win_lens>frame_len])

dev_filler = dev_filler[0,1:-1]
# setting values to zeros
for id_win_num in range(0,win_start_use.shape[1]):
        dev_filler[0,win_start_use[0,id_win_num]+10:win_end_use[0,id_win_num]-10] = 0

# complete the matrix and save it
summed_probs = numpy.ones((dev_laughter.shape[1],1)) - dev_laughter.T - dev_filler.T
complete_matrix = numpy.concatenate((summed_probs,dev_laughter.T,dev_filler.T),axis=1)

numpy.savetxt('complete_matrix.temp',complete_matrix,fmt='%f',delimiter=',')

