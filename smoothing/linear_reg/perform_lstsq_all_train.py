#! /usr/bin/python

import numpy
import numpy.linalg
import sys

train_matrix_file = sys.argv[1]
all_train_matrix_file = sys.argv[2]

train_data = numpy.genfromtxt(train_matrix_file,delimiter=',')
all_train_data = numpy.genfromtxt(all_train_matrix_file,delimiter=',')

# determine filete coeffs
print train_data[:,0:-1].shape, numpy.ones((train_data.shape[0],1)).shape
X = numpy.hstack((train_data[:,0:-1], numpy.ones((train_data.shape[0],1))))
Y = numpy.matrix(train_data[:,-1]).T
coeff = numpy.linalg.lstsq(X,Y)[0]

# get results on all train set
X_all = numpy.hstack((all_train_data[:,0:-1], numpy.ones((all_train_data.shape[0],1))))
Y_all = X_all * coeff
output_file = all_train_matrix_file + '.output'
numpy.savetxt(output_file,Y_all)

coeff_file = train_matrix_file+'.coeff'
numpy.savetxt(coeff_file,coeff)
