import numpy as np
import cv2
import sklearn
import csv
import os

from load_data import load_training_data
from headpose_estimator import headpose_estimator
from headpose_estimator import get_head_features
import handpose_estimator
from handpose_estimator import run_handpose_estimator
from get_bow import get_bow
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from util import plot_confusion_matrix
from load_data import load_random_same

def main():
    handClassifier = True
    headClassifier = False

    scale = 0.6
    # Location of the dataset. Change this to the correct location when running. Remember the '/' at the end!
    data_location = os.path.join(os.path.dirname(__file__), '../data/')

    # Get Training and Test Data

    training_pcipants = 5
    #(images, Y, image_names) = load_training_data(data_location, num_participants=training_pcipants, scale=scale)
    (train_images_names,test_images_names,train_images,test_images) = load_random_same(data_location,0.5)

    if headClassifier:
        # Get Headposes
        paths = ["../experiments/Face/face-release1.0-basic/c0.csv","../experiments/Face/face-release1.0-basic/c1.csv","../experiments/Face/face-release1.0-basic/c2.csv","../experiments/Face/face-release1.0-basic/c3.csv","../experiments/Face/face-release1.0-basic/c4.csv","../experiments/Face/face-release1.0-basic/c5.csv","../experiments/Face/face-release1.0-basic/c6.csv","../experiments/Face/face-release1.0-basic/c7.csv","../experiments/Face/face-release1.0-basic/c8.csv","../experiments/Face/face-release1.0-basic/c9.csv"]
        (features,labels) = get_head_features(paths,image_names)
        (headpose_scaler, headpose_clf) = headpose_estimator(features,labels)

    # Get Handposes/Handpositions/Classifications based on Hands, whatever we want to do here
    hand_clf = None
    if handClassifier:
        (scaler, hand_clf) = handpose_estimator.handpose_estimator(images, Y, scale=scale)

    ################## TESTING ########################

    # Delete training data to free memory
    images = None
    Y = None

    # Perform validation
    if handClassifier:
        (images, Y, image_names) = load_training_data(data_location, num_participants=3, scale=scale, skip=training_pcipants)
        #Y = handpose_estimator.convert_classes(np.asarray(Y))
        Y = np.asarray(Y)

        pred = run_handpose_estimator((scaler, hand_clf), images, scale=scale)
        print classification_report(Y, pred)
        cm = confusion_matrix(Y, pred)
        plot_confusion_matrix(cm)

    if headClassifier:
        (images, Y, image_names) = load_training_data(data_location, num_participants=3, scale=scale, skip=training_pcipants)
        (features,labels) = get_head_features(paths,image_names)
        features = headpose_scaler.transform(features)
        pred = headpose_clf.predict(features)
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