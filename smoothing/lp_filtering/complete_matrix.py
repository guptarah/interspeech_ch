#! /usr/bin/python

import numpy
import sys

input_file = sys.argv[1] # file containing probabilities for laughters and fillers

probs = numpy.genfromtxt(input_file)
garbage_prob = numpy.ones((probs.shape[0],1)) - numpy.matrix(numpy.sum(probs,axis=1)).T 
output_probs = numpy.concatenate((garbage_prob,probs),axis=1)

numpy.savetxt(input_file+'.complete',output_probs,fmt='%f',delimiter=',')
