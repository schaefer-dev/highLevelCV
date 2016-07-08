import numpy as np
import csv
import cv2
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


'''
Loads the data for a given number of participants.
'''


# TODO Currently the test/training split is not yielding a fresh set of participants in the test set
def load_data(data_location, num_participants=1):
    print "Load data for %i participants..." % num_participants
    # Get image list
    image_list = load_image_list(data_location)

    X_train = []
    X_test = []
    Y_train = []
    Y_test = []
    for p in range(num_participants):
        print "start with participant %f ..." % p
        # Pick next participant to load
        pcipant = image_list[0, 0]

        # Find all images from that participant
        pcipant_idxs = image_list[:, 0] == pcipant
        pcipant_images = image_list[pcipant_idxs, 2]
        pcipant_labels = image_list[pcipant_idxs, 1]

        pcipant_idxs = np.nonzero(pcipant_idxs)
        image_list = np.delete(image_list, pcipant_idxs, axis=0)

        images = []
        for i in range(pcipant_images.shape[0]):
            loc = data_location + "train/" + pcipant_labels[i] + '/' + pcipant_images[i]
            img = cv2.imread(loc)
            images.append(img)

        x_train, x_test, y_train, y_test = train_test_split(images, pcipant_labels, test_size = 0.15, random_state = 42)

        X_train = X_train + x_train
        X_test = X_test + x_test
        Y_train = Y_train + list(y_train)
        Y_test = Y_test + list(y_test)

    return (X_train, Y_train, X_test, Y_test)
