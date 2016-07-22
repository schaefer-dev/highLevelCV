import CsvParse
from shutil import copyfile
import numpy as np
import matplotlib.pyplot as plt




# IMPORTANT:
# the folders trainBOW and testBOW have to already exist!
# both of them have to contain subfolders called c0, c1, c2 and so on!






imgClassList = ["c0", "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9"]
imgTrainParticipants = ["p002", "p012", "p014", "p015"]

imgTestParticipants = ["p016"]

file = CsvParse.parseCsv("../../data/driver_imgs_list.csv")



# this part creates the folder trainBOW and copies all the pictures of the above set TrainParticipants inside it
for imgClass in imgClassList:

    filesToMove = []

    for row in file:
        if row[1]==imgClass and imgTrainParticipants.__contains__(row[0]):
            filesToMove.append(row[2])

    # now move files to the desired directory
    for picture in filesToMove:
        try:
            copyfile("../../data/train/" + imgClass + "/" + picture, "../../data/trainBOW/" + imgClass + "/" + picture)
            #print "copy: " + "../../data/train/" + imgClass + "/" + picture + "  " + "../../data/trainBOW/" + imgClass + "/" + picture
            pass
        except IOError:
            # do nothing
            print " FAILED! copy: " + "../../data/train/" + imgClass + "/" + picture + "  " + "../../data/trainBOW/" + imgClass + "/" + picture
            pass




# this part creates the folder testBOW and copies all the pictures of the above set TestParticipants inside it
for imgClass in imgClassList:

    filesToMove = []

    for row in file:
        if row[1]==imgClass and imgTestParticipants.__contains__(row[0]):
            filesToMove.append(row[2])

    # now move files to the desired directory
    for picture in filesToMove:
        try:
            copyfile("../../data/train/" + imgClass + "/" + picture, "../../data/testBOW/" + imgClass + "/" + picture)
            # print "copy: " + "../../data/train/" + imgClass + "/" + picture + "  " + "../../data/trainBOW/" + imgClass + "/" + picture
            pass
        except IOError:
            # do nothing
            print " FAILED! copy: " + "../../data/train/" + imgClass + "/" + picture + "  " + "../../data/testBOW/" + imgClass + "/" + picture
            pass
