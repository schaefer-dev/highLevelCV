import numpy as np
import cv2
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
from CsvParse import parseCsv
'''
This function should return the headposes for the given images.
The results may have been generated previously and can be loaded from data. In this case
the function prototype may have to be changed to be able to identify the images to find
their corresponding headposes in the files.
'''

def headpose_estimator(paths,imglist,Y):
	filenumber = 0
	Poses = []
	XCords = []
	YCords = []
	for imgClass in imglist:
		file = parseCsv(paths[filenumber])
		filenumber = filenumber+1
		X = []
		Y = []
		for headpose in file:
			if headpose[2] not in imgClass:
				Poses.append(headpose[4].split(" ")[0])
				quant = headpose[4].split(" ")[1]
				for i in range(0, quant):
					if(i%2==0):
						X.append(headpose[5+i])
					else:
						Y.append(headpose[5+i])

	clf = RandomForestClassifier(n_estimators=10, n_jobs=3, class_weight="balanced")
	clf.fit(Poses, Y)
	return clf
		
