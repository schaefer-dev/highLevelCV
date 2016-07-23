import numpy as np
import csv
import cv2
import os
from random import random
from sklearn.cross_validation import train_test_split

def load_image_list(data_location):
    info = []
    with open(data_location + 'driver_imgs_list.csv', 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in reader:
            info.append(row)
    del info[0]
    info = np.asarray(info)
    return info

def load_steering_wheel_labels(data_location):
    info = []
    with open(data_location + 'labels.csv', 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in reader:
            info.append(row)
    info = np.asarray(info)
    return info

'''
Loads the data for a given number of participants.
'''


# TODO Currently the test/training split is not yielding a fresh set of participants in the test set
def load_training_data(data_location, num_participants=1, scale=0.5, skip = 0):
    print "Load data for %i participants..." % num_participants
    # Get image list
    image_list = load_image_list(data_location)


    pcipant = image_list[0, 0]
    car1 = ["p002"]
    car2 = ["p012", "p014", "p015", "p016"]
    car3 = ["p021", "p022", "p024", "p026"]
    car4 = ["p035", "p039", "p041", "p042", "p045", "p047", "p0049", "p050", "p051", "p052", "p056"]
    car5 = ["p061", "p064", "p066", "p072", "p075", "p081"]
    for pcipant in car1 + car2 + car3 + car5:
        pcipant_idxs = image_list[:, 0] == pcipant
        pcipant_idxs = np.nonzero(pcipant_idxs)
        image_list = np.delete(image_list, pcipant_idxs, axis=0)

    # Skip participants
    while skip > 0:
        skip -= 1
        pcipant = image_list[0, 0]
        pcipant_idxs = image_list[:, 0] == pcipant
        pcipant_idxs = np.nonzero(pcipant_idxs)
        image_list = np.delete(image_list, pcipant_idxs, axis=0)


    X = []
    Y = []
    pIDs = []
    image_names = [[] for i in range(10)]
    for p in range(num_participants):
        print "start with participant %f ..." % p
        # Pick next participant to load
        pcipant = image_list[0, 0]

        # DEBUG
        loc = data_location + "train/" + image_list[0, 1] + '/' + image_list[0, 2]
        img = cv2.imread(loc)
        cv2.imshow("Image", img)
        cv2.waitKey(5)
        # DEBUG

        # Find all images from that participant
        pcipant_idxs = image_list[:, 0] == pcipant
        pcipant_images = image_list[pcipant_idxs, 2]
        pcipant_labels = image_list[pcipant_idxs, 1]
        pcipant_ID = np.repeat(pcipant, pcipant_images.shape[0])

        pcipant_idxs = np.nonzero(pcipant_idxs)
        image_list = np.delete(image_list, pcipant_idxs, axis=0)

        images = []
        deleted = []
        for i in range(pcipant_images.shape[0]):
            loc = data_location + "train/" + pcipant_labels[i] + '/' + pcipant_images[i]
            rnd = random()
            if True and (pcipant_labels[i] != 'c0' and pcipant_labels[i] != 'c5'):# and rnd > 0.1:
                deleted.append(i)
                continue
            else:
                img = cv2.imread(loc)
                img = cv2.resize(img, dsize=None, fx=scale, fy=scale)
                images.append(img)
        pcipant_labels = np.delete(pcipant_labels, deleted, axis=0)
        X = X + images
        Y = Y + list(pcipant_labels)
        pIDs = pIDs + list(pcipant_ID)


        '''
        # Add to list of image names
        for i in range(pcipant_images.shape[0]):
            temp = (pcipant_labels[i])[1]
            image_names[int(temp)].append(pcipant_images[i])
        '''
        '''
        x_train, x_test, y_train, y_test = train_test_split(images, pcipant_labels, test_size = 0.15, random_state = 42)

        X_train = X_train + x_train
        X_test = X_test + x_test
        Y_train = Y_train + list(y_train)
        Y_test = Y_test + list(y_test)

    return (X_train, Y_train, X_test, Y_test)
    '''
    return (X, Y, pIDs, image_names)


def load_test_data(data_location, num_images = 1000, skip = 0, scale=0.5):
    print "Load test data..."

    files = os.listdir(data_location + "/test")
    files = files[skip:skip+num_images]
    images = []
    for file in files:
        loc = data_location + "test/" + file
        img = cv2.imread(loc)
        img = cv2.resize(img, dsize=None, fx=scale, fy=scale)
        images.append(img)

def load_random_same(data_location,amount):
    # load image_list
    image_list = load_image_list(data_location)

    # Pick next participant to load
    pcipant = image_list[0, 0]



    # Find all participants
    participants = []
    for image in image_list:
        if image[0] not in participants:
            participants.append(image[0])

    participant = participants[int(random()*len(participants))]

    train_images_names = []
    test_images_names = []
    test_images_names = [[] for i in range(10)]
    train_images_names = [[] for i in range(10)]
    test_images = []
    train_images = []
    labels = []
    for image in image_list:
        if image[0]==participant:
            if random() < amount:
                test_images.append(data_location + "train/" + image[1] + '/' + image[2])
                temp = (image[1])[1]
                test_images_names[int(temp)].append(image[2])
            else:
                train_images.append(data_location + "train/" + image[1] + '/' + image[2])
                temp = (image[1])[1]
                train_images_names[int(temp)].append(image[2])

    print(len(train_images))
    print(len(test_images))
    return (train_images_names,test_images_names,train_images,test_images)





   