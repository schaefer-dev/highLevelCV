import numpy as np
import cv2
import sklearn
import csv
import os

from load_data import load_data
from headpose_estimator import headpose_estimator
from handpose_estimator import handpose_estimator
from get_bow import get_bow


def main():
    # Location of the dataset. Change this to the correct location when running. Remember the '/' at the end!
    data_location = os.path.join(os.path.dirname(__file__), '../data')

    # Get Training and Test Data
    (images_train, Y_train, images_test, Y_test) = load_data(data_location, num_participants=1)

    # Get Headposes
    headpose_train = headpose_estimator(images_train)
    headpose_test = headpose_estimator(images_test)
    
    # Get Handposes/Handpositions/Classifications based on Hands, whatever we want to do here
    result = handpose_estimator(images_train, images_test)
    
    # Generate BoW representation for each image
    bow_train = get_bow(images_train)
    bow_test = get_bow(images_test)
    
    #####################################################
    # Use the above to somehow make a prediction!
    pass
    

if __name__ == "__main__":
    main()