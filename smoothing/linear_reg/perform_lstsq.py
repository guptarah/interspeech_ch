#! /usr/bin/python

import numpy
import numpy.linalg
import sys

train_matrix_file = sys.argv[1]
dev_matrix_file = sys.argv[2]
test_matrix_file = sys.argv[3]

train_data = numpy.genfromtxt(train_matrix_file,delimiter=',')
dev_data = numpy.genfromtxt(dev_matrix_file,delimiter=',')
test_data = numpy.genfromtxt(test_matrix_file,delimiter=',')

# determine filete coeffs
print train_data[:,0:-1].shape, numpy.ones((train_data.shape[0],1)).shape
X = numpy.hstack((train_data[:,0:-1], numpy.ones((train_data.shape[0],1))))
Y = numpy.matrix(train_data[:,-1]).T
coeff = numpy.linalg.lstsq(X,Y)[0]

# get results on dev set
X_dev = numpy.hstack((dev_data[:,0:-1], numpy.ones((dev_data.shape[0],1))))
Y_dev = X_dev * coeff
output_file = dev_matrix_file + '.output'
numpy.savetxt(output_file,Y_dev)

# get results on the test set
X_test = numpy.hstack((test_data[:,0:-1], numpy.ones((test_data.shape[0],1)))) 
Y_test = X_test * coeff
output_file = test_matrix_file + '.output'
numpy.savetxt(output_file, Y_test)

coeff_file = train_matrix_file+'.coeff'
numpy.savetxt(coeff_file,coeff)
