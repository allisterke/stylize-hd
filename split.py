#!/usr/bin/python
# usage: split.py src row column dir suffix

import sys
from skimage.io import imread, imsave

src = sys.argv[1]
row = int(sys.argv[2])
column = int(sys.argv[3])
path = sys.argv[4]
path = path if path.endswith('/') else path + '/'
suffix = sys.argv[5]

# read image data

image = imread(src)

if len(image.shape) == 2:
	image = image.reshape(image.shape + (1,))

# split & save image data

shape = image.shape
rstep = int(shape[0]/row)
cstep = int(shape[1]/column)

idx = 0
for r in range(0, image.shape[0], rstep):
	for c in range(0, image.shape[1], cstep):
		subimg = image[r:r+rstep, c:c+cstep, :]
		if subimg.shape[2] == 1:
			subimg = subimg.reshape((subimg.shape[0], subimg.shape[1]))
		imsave(path + str(idx) + suffix, subimg)
		idx += 1
