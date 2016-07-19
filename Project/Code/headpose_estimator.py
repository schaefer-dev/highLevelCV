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

def headpose_estimator(features,Y):
	Y = np.asarray(Y)
	print(len(Y))
	print(len(features))
	clf = RandomForestClassifier(n_estimators=10, n_jobs=3, class_weight="balanced")
	clf.fit(features, Y)
	return clf

def get_head_features(paths,imglist):
	filenumber = 0
	features = []
	#XCords = []
	#YCords = []
	for imgClass in imglist:
		file = parseCsv(paths[filenumber])
		filenumber = filenumber+1
		#X = []
		#Y = []
		for headpose in file:
			feature = []
			imgname=headpose[1].strip()
			if imgname in imgClass:
				pose = headpose[3].split(" ")[1]
				feature.append(pose)
				quant = headpose[3].split(" ")[2]
				for i in range(0, int(quant)):
					feature.append(headpose[4+i])
				features.append(feature)
		#XCords.append(X)
		#YCords.append(Y)
	#features = np.asarray(features)
	return features
		
