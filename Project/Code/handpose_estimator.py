import numpy as np
import cv2
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
'''
It is a bit unclear what this function should do yet. We have several options:

1. We use an off-the-shelf handpose or handposition estimator similar as for the headpose. We should test a couple if
we can find any and check their quality. If it is good enough, that would be great

2. We try to implement such an estimator ourselves. This would probably be too much work though and require additional
annotaion of the data.

3. Use a croped image of the steering wheel and its vicinity. Try to do classification based only on that image.
Hopefully we could distinguish at least a few classes from this. Just try to train for example a Random Forrest for that.
'''
def convert_classes(c):
    c[c == "c0"] = "tw"
    c[c == "c1"] = "o5" #o5
    c[c == "c2"] = "on"
    c[c == "c3"] = "o5" #5
    c[c == "c4"] = "on"
    c[c == "c5"] = "on" # unclear
    c[c == "c6"] = "on"
    c[c == "c7"] = "on"
    c[c == "c8"] = "on"
    c[c == "c9"] = "tw"
    return c


def handpose_estimator(train_images, train_Y, test_images, test_Y):
    print "Train Handpose Estimator..."
    #train_Y = convert_classes(np.asarray(train_Y))
    #test_Y = convert_classes(np.asarray(test_Y))
    train_Y = np.asarray(train_Y)
    test_Y = np.asarray(test_Y)
    #scale = 0.5

    # prepare training data
    train_X = []
    for img in train_images:
        #img = img[60:350, 460:-1]
        img = img[30:175, 230:-1]
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        #img = cv2.resize(img, dsize=None, fx=scale, fy=scale)
        img = cv2.equalizeHist(img)
        #cv2.imshow("Image", img)
        #cv2.waitKey(100)
        img = np.reshape(img, -1)
        train_X.append(img)
    train_X = np.asarray(train_X)

    # Train classifier
    #clf = SVC(C=0.1)
    clf = RandomForestClassifier(n_estimators=10, n_jobs=3)
    clf.fit(train_X, train_Y)

    # Prepare test images
    test_X = []
    for img in test_images:
        #img = img[60:350, 460:-1]
        img = img[30:175, 230:-1]
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        #img = cv2.resize(img, dsize=None, fx=scale, fy=scale)
        img = cv2.equalizeHist(img)
        img = np.reshape(img, -1)
        test_X.append(img)
    test_X = np.asarray(test_X)

    # Make prediction
    pred = clf.predict(test_X)
    print classification_report(test_Y, pred)


    return clf