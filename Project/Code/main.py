import numpy as np
import cv2
import sklearn
import csv
import os

from load_data import load_training_data
from load_data import load_steering_wheel_labels
from headpose_estimator import headpose_estimator
from headpose_estimator import run_headpose_estimator
from headpose_estimator import get_head_features
import handpose_estimator
from handpose_estimator import run_handpose_estimator
from get_bow import get_bow
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from util import plot_confusion_matrix
from load_data import load_random_same
from mult_hog_detector import get_mult_hog_features
from mult_hog_detector import load_mult_HOG_data
from mult_hog_detector import get_mult_HOG_classifier
from mult_hog_detector import run_mult_HOG_classifier
from sklearn.externals import joblib


def main():
    handClassifier = False
    headClassifier = False
    mult_hog = True
    hog_train = True

    scale = 0.6
    # Location of the dataset. Change this to the correct location when running. Remember the '/' at the end!
    data_location = os.path.join(os.path.dirname(__file__), '../data/')

    # Get Training and Test Data

    if handClassifier:
        training_pcipants = 1
        (images, Y, pIDs, image_names) = load_training_data(data_location, skip=0, num_participants=training_pcipants, scale=scale)
    if headClassifier:
        (train_images_names,test_images_names,train_images,test_images) = load_random_same(data_location,0.5)


    if headClassifier:
        # Get Headposes
        paths = ["../experiments/Face/face-release1.0-basic/c0.csv","../experiments/Face/face-release1.0-basic/c1.csv","../experiments/Face/face-release1.0-basic/c2.csv","../experiments/Face/face-release1.0-basic/c3.csv","../experiments/Face/face-release1.0-basic/c4.csv","../experiments/Face/face-release1.0-basic/c5.csv","../experiments/Face/face-release1.0-basic/c6.csv","../experiments/Face/face-release1.0-basic/c7.csv","../experiments/Face/face-release1.0-basic/c8.csv","../experiments/Face/face-release1.0-basic/c9.csv"]
        (features,labels) = get_head_features(paths,train_images_names)
        (headpose_scaler, headpose_clf) = headpose_estimator(features,labels)

    # Get Handposes/Handpositions/Classifications based on Hands, whatever we want to do here
    hand_clf = None
    if handClassifier:
        steering_wheel_labels = load_steering_wheel_labels(data_location)
        (scaler, hand_clf) = handpose_estimator.handpose_estimator(images, Y, pIDs, steering_wheel_labels, scale=scale)

    if mult_hog:
        imgTrainPath = "C:\Users\enggr\Documents\git\hlcv\Project\data\\trainBOW"
        imgClassList = ["c0", "c1", "c2", "c3", "c4", "c5", "c6", "c8", "c9"]

        if hog_train:
            (images, labels) = load_mult_HOG_data(imgTrainPath,imgClassList)
            features = get_mult_hog_features(images)
            mult_HOG_clf = get_mult_HOG_classifier(features,labels)
            joblib.dump(mult_HOG_clf,  'mult_HOG_model.pkl', compress=9)
            print "Trained"
        else:
            mult_HOG_clf = joblib.load('mult_HOG_model.pkl')
            print "loaded"


    ################## TESTING ########################

    # Delete training data to free memory
    images = None
    Y = None

    # Perform validation
    if handClassifier:
        (images, Y, pIDs, image_names) = load_training_data(data_location, num_participants=3, scale=scale, skip=training_pcipants)
        #Y = handpose_estimator.convert_classes(np.asarray(Y))
        Y = np.asarray(Y)

        steering_wheel_labels = load_steering_wheel_labels(data_location)
        pred = run_handpose_estimator((scaler, hand_clf), images, pIDs, steering_wheel_labels, scale=scale)
        print classification_report(Y, pred)
        cm = confusion_matrix(Y, pred)
        plot_confusion_matrix(cm)

    if headClassifier:
        #(images, labels, pIDs, image_names) = load_training_data(data_location, num_participants=1, scale=scale, skip=training_pcipants)
        (pred, labels) = run_headpose_estimator(headpose_scaler, headpose_clf, test_images_names, paths)
        print classification_report(labels, pred)
        cm = confusion_matrix(labels, pred)
        plot_confusion_matrix(cm)

    if mult_hog:
        imgTestPath = "C:\Users\enggr\Documents\git\hlcv\Project\data\\testBOW"
        imgClassList = ["c0", "c1", "c2", "c3", "c4", "c5", "c6", "c8", "c9"]
        (images, labels) = load_mult_HOG_data(imgTestPath, imgClassList)
        (features) = get_mult_hog_features(images)
        pred = run_mult_HOG_classifier(mult_HOG_clf ,features)
        print classification_report(labels, pred)
        cm = confusion_matrix(labels, pred)
        plot_confusion_matrix(cm)



    
    # Generate BoW representation for each image
    #bow_train = get_bow(images_train)
    #bow_test = get_bow(images_test)
    
    #####################################################
    # Use the above to somehow make a prediction!
    pass
    

if __name__ == "__main__":
    main()