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

def convert_classes(c):
    c[c == "c0"] = "on"
    c[c == "c1"] = "on" #o5
    c[c == "c2"] = "on"
    c[c == "c3"] = "on" #5
    c[c == "c4"] = "on"
    c[c == "c5"] = "on" # unclear
    c[c == "c6"] = "on"
    c[c == "c7"] = "on"
    c[c == "c8"] = "on"
    c[c == "c9"] = "tw"
    return c

def run_headpose_estimator(scaler, clf, image_names, paths):
	(features, labels) = get_head_features(paths, image_names)
	labels = convert_classes(labels)
	features = scaler.transform(features)
	pred = clf.predict(features)
	return (pred, labels)

def headpose_estimator(features,Y):
	#Y = np.asarray(Y)
	scaler = StandardScaler(copy=False)
	features = scaler.fit_transform(features)
	Y = convert_classes(Y)

	#clf = RandomForestClassifier(n_estimators=10, n_jobs=3, class_weight="balanced")
	clf = SVC(class_weight='balanced')
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
				px1 = float(headpose[4].strip())
				py1 = float(headpose[5].strip())
				px2 = float(headpose[6].strip())
				py2 = float(headpose[7].strip())
				px = (px1+px2)/2
				py = (py1+py2)/2
				feature.append(px)
				feature.append(py)
				for i in range(1, 38):
					px1 = float(headpose[4+i*4].strip())
					py1 = float(headpose[5+i*4].strip())
					px2 = float(headpose[6+i*4].strip())
					py2 = float(headpose[7+i*4].strip())
					feature.append((px1+px2)/2 - px)
					feature.append((py1 + px2) / 2 - px)

				#feature.append(py)
				#for i in range(2, 38):
				#	if i%2 == 0:
				#		feature.append(float(headpose[4+i].strip()) - px)
				#	else:
				#		feature.append(float(headpose[4 + i].strip()) - py)
				feature = np.asarray(feature)
				features.append(feature)
				labels.append(label)
		#XCords.append(X)
		#YCords.append(Y)
	features = np.asarray(features)

	labels = np.ravel(labels)
	return (features,labels)

