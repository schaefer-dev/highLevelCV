import numpy as np
import cv2
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
from CsvParse import parseCsv
from sklearn.preprocessing import StandardScaler
'''
This function should return the headposes for the given images.
The results may have been generated previously and can be loaded from data. In this case
the function prototype may have to be changed to be able to identify the images to find
their corresponding headposes in the files.
'''

def headpose_estimator(features,Y):
	#Y = np.asarray(Y)
	scaler = StandardScaler(copy=False)
	features = scaler.fit_transform(features)

	#clf = RandomForestClassifier(n_estimators=10, n_jobs=3, class_weight="balanced")
	clf = SVC()
	clf.fit(features, Y)
	return (scaler, clf)

def get_head_features(paths,imglist):
	filenumber = 0
	features = []
	labels = []
	#XCords = []
	#YCords = []
	for imgClass in imglist:
		file = parseCsv(paths[filenumber])
		filenumber = filenumber+1
		#X = []
		#Y = []
		for headpose in file:
			label = []
			feature = []
			imgname=headpose[1].strip()
			#print(imgname)
			#print(imgClass)
			if imgname in imgClass:
				label.append(headpose[2].strip())
				pose = headpose[3].split(" ")[1]
				feature.append(pose)
				quant = headpose[3].split(" ")[2]
				px = float(headpose[4].strip())
				py = float(headpose[5].strip())
				feature.append(px)
				feature.append(py)
				for i in range(2, 38):
					if i%2 == 0:
						feature.append(float(headpose[4+i].strip()) - px)
					else:
						feature.append(float(headpose[4 + i].strip()) - py)
				feature = np.asarray(feature)
				features.append(feature)
				labels.append(label)
		#XCords.append(X)
		#YCords.append(Y)
	features = np.asarray(features)

	labels = np.ravel(labels)
	return (features,labels)
		
