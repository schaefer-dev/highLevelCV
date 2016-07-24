import numpy as np
import cv2
from sklearn.svm import SVC
import os
import sys
import glob
from os.path import exists, isdir, basename, join, splitext
import dlib




EXTENSIONS = [".jpg", ".bmp", ".png", ".pgm", ".tif", ".tiff"]





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

def run_mult_HOG_classifier(clf, features):
	pred = clf.predict(features)
	return pred


def get_imgfiles(DataPath, cat):
	path = join(DataPath, cat)
	#print path
	images = []
	labels = []
	for filename in	glob.glob(path + "\*.jpg"):
		img = cv2.imread(os.path.join(path, filename))
		#print filename
		if img is not None:
			images.append(img)
			labels.append(cat)
			#print "showing"
			#cv2.imshow("Image", img)
			#cv2.waitKey(0)
		else:
			print "Image is None " + filename

	#print len(images)
	return (images, labels)





def get_mult_HOG_classifier(features,labels):
	#Y = np.asarray(Y)
	#scaler = StandardScaler(copy=False)
	#features = scaler.fit_transform(features)
	#Y = convert_classes(Y)

	#clf = RandomForestClassifier(n_estimators=10, n_jobs=3, class_weight="balanced")
	clf = SVC(class_weight='balanced')
	clf.fit(features, labels)
	return (clf)

def load_mult_HOG_data(dataSet,classes, ):
	all_files = []
	labels = []
	for i in range(len(classes)):
		(cat_files, img_labels) = get_imgfiles(dataSet, classes[i])
		all_files = all_files + cat_files
		labels = labels + img_labels
		#cv2.imshow("Image", all_files[1])
	return(all_files, labels)




def get_mult_hog_features(images):
	features =[]

	armBackDet = dlib.simple_object_detector("armBack.svm")
	drinkingDet = dlib.simple_object_detector("drinking.svm")
	faceBackDet = dlib.simple_object_detector("faceBack.svm")
	faceFrontDet = dlib.simple_object_detector("faceFront.svm")
	faceMissDet = dlib.simple_object_detector("faceMiss.svm")
	faceSideDet = dlib.simple_object_detector("faceSide.svm")
	makeupDet = dlib.simple_object_detector("makeup.svm")
	radioDet = dlib.simple_object_detector("radio.svm")
	talkLeftDet = dlib.simple_object_detector("talkLeft.svm")
	talkRightDet = dlib.simple_object_detector("talkRight.svm")
	textLeftDet = dlib.simple_object_detector("textLeft.svm")
	textRightDet = dlib.simple_object_detector("textRight.svm")
	#win = dlib.image_window()

	for i in range(len(images)):
		feature = []
		img = images[i]
		#cv2.imshow("Image", img)
		#cv2.waitKey(0)
		armBackDets = armBackDet(img)
		drinkingDets = drinkingDet(img)
		faceBackDets = faceBackDet(img)
		faceFrontDets = faceFrontDet(img)
		faceMissDets = faceMissDet(img)
		faceSideDets = faceSideDet(img)
		makeupDets = makeupDet(img)
		radioDets = radioDet(img)
		talkLeftDets = talkLeftDet(img)
		talkRightDets = talkRightDet(img)
		textLeftDets = textLeftDet(img)
		textRightDets = textRightDet(img)


		feature.append(len(armBackDets) > 0)
		feature.append(len(drinkingDets) > 0)
		feature.append(len(faceBackDets) > 0)
		feature.append(len(faceFrontDets) > 0)
		feature.append(len(faceMissDets) > 0)
		feature.append(len(faceSideDets) > 0)
		feature.append(len(makeupDets) > 0)
		feature.append(len(radioDets) > 0)
		feature.append(len(talkLeftDets) > 0)
		feature.append(len(talkRightDets) > 0)
		feature.append(len(textLeftDets) > 0)
		feature.append(len(textRightDets) > 0)

		features.append(feature)
		if i%50 ==0:
			print i

		'''
		print("Number of arm back detected: {}".format(len(armBackDets)))
		print("Number of drinking detected: {}".format(len(drinkingDets)))
		print("Number of face back detected: {}".format(len(faceBackDets)))
		print("Number of face front detected: {}".format(len(faceFrontDets)))
		print("Number of face miss detected: {}".format(len(faceMissDets)))
		print("Number of face side detected: {}".format(len(faceSideDets)))
		print("Number of makeup detected: {}".format(len(makeupDets)))
		print("Number of radio detected: {}".format(len(radioDets)))
		print("Number of talk left detected: {}".format(len(talkLeftDets)))
		print("Number of talk right detected: {}".format(len(talkRightDets)))
		print("Number of text left detected: {}".format(len(textLeftDets)))
		print("Number of text right detected: {}".format(len(textRightDets)))
		'''
		'''
		win.clear_overlay()
		win.set_image(img)
		win.add_overlay(armBackDets)
		win.add_overlay(drinkingDets)
		win.add_overlay(faceBackDets)
		win.add_overlay(faceFrontDets)
		win.add_overlay(faceMissDets)
		win.add_overlay(faceSideDets)
		win.add_overlay(makeupDets)
		win.add_overlay(radioDets)
		win.add_overlay(talkLeftDets)
		win.add_overlay(talkRightDets)
		win.add_overlay(textLeftDets)
		win.add_overlay(textRightDets)
		dlib.hit_enter_to_continue()
		'''


	return (features)


def pause():
    programPause = raw_input("Press the <ENTER> key to continue...")