import numpy as np
import cv2
from sklearn.svm import LinearSVC
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report
from sklearn import preprocessing
from features import getHOG
from features import getLBP
from sklearn.preprocessing import StandardScaler
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
    c[c == "c1"] = "on" #o5
    c[c == "c2"] = "on"
    c[c == "c3"] = "on" #5
    c[c == "c4"] = "on"
    c[c == "c5"] = "on" # unclear
    c[c == "c6"] = "on"
    c[c == "c7"] = "on"
    c[c == "c8"] = "on"
    c[c == "c9"] = "on"
    return c


def prepare_images(images, pIDs, steering_wheel_labels, scale=0.5):
    feature = "hog"

    X = []
    for i in range(len(images)):
        img = images[i]

        center = None
        for row in steering_wheel_labels:
            if row[0] == pIDs[i]:
                center = (int(row[1]), int(row[2]))
                break

        wl = 100
        wr = 55
        ht = 120
        hb = 120
        y1 = int((center[1] - ht) * scale)
        y2 = int((center[1] + hb) * scale)
        x1 = int((center[0] - wl) * scale)
        x2 = int((center[0] + wr) * scale)
        cx = int(wl * scale)
        cy = int(ht * scale)
        # img = img[60:350, 460:-1]
        #y1 = int(60 * scale)
        #y2 = int(350 * scale)
        #x1 = int(460 * scale)
        img = img[y1:y2, x1:x2]
        #cv2.circle(img, (cx,cy), 2, (0,0,255), -1)
        #cv2.imshow("Image", img)
        #cv2.waitKey(5)

        # img = cv2.resize(img, dsize=None, fx=scale, fy=scale)



        # Extract features
        if feature == "raw":
            img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            img = cv2.equalizeHist(img)
            img = np.reshape(img, -1)
            X.append(img)
        elif feature == "hog":
            img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            hog = getHOG(img)
            X.append(hog)
        elif feature == "lbp":
            img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            lbp = getLBP(img)
            lbp = np.reshape(lbp, -1)
            X.append(lbp)
        elif feature == 'hog+lbp':
            img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            hog = getHOG(img)
            lbp = getLBP(img)
            lbp = np.reshape(lbp, -1)
            f = np.concatenate((hog,lbp))
            X.append(f)

    X = np.asarray(X)
    return X

def handpose_estimator(images, Y, pIDs, steering_wheel_labels, scale = 0.5):
    print "Train Handpose Estimator..."
    #Y = convert_classes(np.asarray(Y))
    Y = np.asarray(Y)

    # prepare training data
    X = prepare_images(images, pIDs, steering_wheel_labels, scale)
    scaler = StandardScaler(copy=False)
    X = scaler.fit_transform(X)

    # Train classifier
    #clf = SVC(kernel='linear', class_weight='balanced', C=1)
    clf = SVC(kernel='poly', class_weight='balanced', C=1)
    #clf = RandomForestClassifier(n_estimators=10, n_jobs=3, class_weight="balanced")
    clf.fit(X, Y)

    return (scaler,clf)

def run_handpose_estimator((scaler, clf), images, pIDs, steering_wheel_labels, scale = 0.5):
    # prepare training data
    X = prepare_images(images,pIDs, steering_wheel_labels, scale)
    X = scaler.transform(X)

    pred = clf.predict(X)
    return pred
