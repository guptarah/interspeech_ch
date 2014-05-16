#! /usr/bin/python

import sys
import math
from os import system
import numpy

# inputs 
prob_file = sys.argv[1] # file containing the probabilities
win_len = int(sys.argv[2]) # length of MA filter

probabilities = numpy.genfromtxt(prob_file,delimiter=',',dtype='float')
garbage_probs = probabilities[:,0]
laugh_probs = probabilities[:,1]
fil_probs = probabilities[:,2]

filtered_laugh_probs = numpy.convolve(laugh_probs,numpy.ones(win_len)/float(win_len),mode='same') 
filtered_fil_probs = numpy.convolve(fil_probs,numpy.ones(win_len)/float(win_len),mode='same')

print numpy.matrix(filtered_laugh_probs).shape
# print filtered values to file
filtered_probs = numpy.concatenate([numpy.matrix(filtered_laugh_probs).T, numpy.matrix(filtered_fil_probs).T],axis=1) 
numpy.savetxt('cur_filtered',filtered_probs)

