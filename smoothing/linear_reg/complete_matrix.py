#! /usr/bin/python

import numpy
import sys

filler_input_file = sys.argv[1] # file containing probabilities for fillers ex: appended_prob_dev/filler/dev_matrix_10.output
laughter_input_file = sys.argv[2] # file containing probabilities for laughter
output_file = sys.argv[3] # where to store output file

filler_probs = numpy.genfromtxt(filler_input_file)
laughter_probs = numpy.genfromtxt(laughter_input_file)

# limit between 0 and 1
filler_probs[filler_probs < 0,:] = 0
filler_probs[filler_probs > 1,:] = 1
laughter_probs[laughter_probs < 0,:] = 0
laughter_probs[filler_probs > 1,:] = 1
probs = numpy.vstack((numpy.matrix(laughter_probs), numpy.matrix(filler_probs))).T
print probs.shape,  numpy.ones((probs.shape[0],1)).shape, numpy.matrix(numpy.sum(probs,axis=1)).shape 

garbage_prob = numpy.ones((probs.shape[0],1)) - numpy.matrix(numpy.sum(probs,axis=1)) 
output_probs = numpy.concatenate((garbage_prob,probs),axis=1)

numpy.savetxt(output_file,output_probs,fmt='%f',delimiter=',')
