#! /usr/bin/python

import numpy
import sys

lables_file = sys.argv[1]
file_name = sys.argv[2]
output_file = sys.argv[3]

lables = numpy.genfromtxt(lables_file,dtype='int',delimiter=',')
lables_hist = numpy.hstack((0,lables))
lables_present = numpy.hstack((lables,0))

concat_lab = numpy.vstack((lables_present,lables_hist))

diff_points = lables_present - lables_hist

interest_points = numpy.nonzero(diff_points)[0] + numpy.ones((numpy.nonzero(diff_points)[0].shape)) # shifting by 1 as 1 frame lost in feat ext
interest_points[-1] = interest_points[-1]+2 # adding the last frame lost in feat ext and one more as 1 subtracted in to_write string 
interest_points[0] = interest_points[0]-1 

fo = open(output_file,"a")
for i in range(0,len(interest_points)-1):
	event_id = lables_present[interest_points[i]]
	
	if event_id == 1:
		event = 'garbage'
	elif event_id == 2:
		event = 'laughter'
	elif event_id == 3:
		event = 'filler'

	to_write = file_name + ' ' + str(float(interest_points[i])/100) + ' ' + str(float(interest_points[i+1]-1)/100) + ' ' + event +'\n'
	fo.write(to_write)

fo.close()	
