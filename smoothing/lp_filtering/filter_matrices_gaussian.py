#! /home/rcf-proj/mv/guptarah/python/ 

import sys
import math
from os import system
import numpy
from scipy import signal

# inputs 
prob_file = sys.argv[1] # file containing the probabilities
win_len = int(sys.argv[2]) # length of gaussian filter
std_dev = int(sys.argv[3]) # std dev for gaussian filter

probabilities = numpy.genfromtxt(prob_file,delimiter=',',dtype='float')
garbage_probs = probabilities[:,0]
laugh_probs = probabilities[:,1]
fil_probs = probabilities[:,2]

window = signal.gaussian(win_len, std=std_dev)
window = (1/numpy.sum(window))*window

filtered_laugh_probs = numpy.convolve(laugh_probs,window,mode='same') 
filtered_fil_probs = numpy.convolve(fil_probs,window,mode='same')

print numpy.matrix(filtered_laugh_probs).shape
# print filtered values to file
filtered_probs = numpy.concatenate([numpy.matrix(filtered_laugh_probs).T, numpy.matrix(filtered_fil_probs).T],axis=1) 
numpy.savetxt('/home/rcf-proj/mv/guptarah/interspeech_ch/scripts/smoothing/lp_filtering/cur_filtered',filtered_probs)

