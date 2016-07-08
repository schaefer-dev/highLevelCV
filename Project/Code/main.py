import numpy as np
import cv2
import sklearn

from headpose_estimator import headpose_estimator
from handpose_estimator import handpose_estimator
from get_bow import get_bow


def main():
    # Get Training and Test Data! Marc will implement this
    train = None
    test = None
    
    # Get Headposes
    headpose_train = headpose_estimator(train)
    headpose_test = headpose_estimator(test)
    
    # Get Handposes/Handpositions/Classifications based on Hands, whatever we want to do here
    result = handpose_estimator(train, test)
    
    # Generate BoW representation for each image
    bow_train = get_bow(train)
    bow_test = get_bow(test)
    
    #####################################################
    # Use the above to somehow make a prediction!
    pass
    

if __name__ == "__main__":
    main()