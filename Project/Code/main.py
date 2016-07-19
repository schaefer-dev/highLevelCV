import numpy as np
import cv2
import sklearn
import csv
import os

from load_data import load_training_data
from headpose_estimator import headpose_estimator
import handpose_estimator
from get_bow import get_bow
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from util import plot_confusion_matrix


def main():
    handClassifier = True
    headClassifier = False

    scale = 0.6
    # Location of the dataset. Change this to the correct location when running. Remember the '/' at the end!
    data_location = os.path.join(os.path.dirname(__file__), '../data/')

    # Get Training and Test Data
    training_pcipants = 4
    (images, Y, image_names) = load_training_data(data_location, num_participants=training_pcipants, scale=scale)

    if headClassifier:
        # Get Headposes
        paths = ["../experiments/Face/face-release1.0-basic/c0.csv","../experiments/Face/face-release1.0-basic/c1.csv","../experiments/Face/face-release1.0-basic/c2.csv","../experiments/Face/face-release1.0-basic/c3.csv","../experiments/Face/face-release1.0-basic/c4.csv","../experiments/Face/face-release1.0-basic/c5.csv","../experiments/Face/face-release1.0-basic/c6.csv","../experiments/Face/face-release1.0-basic/c7.csv","../experiments/Face/face-release1.0-basic/c8.csv","../experiments/Face/face-release1.0-basic/c9.csv"]
        headpose_clf = headpose_estimator(paths,images,Y)
        #headpose_test = headpose_estimator(paths,imglist,Y)

    # Get Handposes/Handpositions/Classifications based on Hands, whatever we want to do here
    hand_clf = None
    if handClassifier:
        hand_clf = handpose_estimator.handpose_estimator(images, Y, scale=scale)

    ################## TESTING ########################

    # Delete training data to free memory
    images = None
    Y = None

    # Perform validation
    if handClassifier:
        (images, Y) = load_training_data(data_location, num_participants=1, scale=scale, skip=training_pcipants)
        Y = handpose_estimator.convert_classes(np.asarray(Y))
        Y = np.asarray(Y)
        X = handpose_estimator.prepare_images(images, scale)
        pred = hand_clf.predict(X)
        print classification_report(Y, pred)
        pred = headpose_clf.predict(images)
        print classification_report(Y, pred)


    
    # Generate BoW representation for each image
    #bow_train = get_bow(images_train)
    #bow_test = get_bow(images_test)
    
    #####################################################
    # Use the above to somehow make a prediction!
    pass
    

if __name__ == "__main__":
    main()