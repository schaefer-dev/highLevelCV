import numpy as np
from skimage.feature import hog
from skimage.feature import local_binary_pattern
import matplotlib.pyplot as plt
from skimage import exposure

def getHOG(image):
    fd = hog(image, orientations=8, pixels_per_cell=(16,16), cells_per_block=(2,2), visualise=False)

    ### DEBUG
    #hog_image_rescaled = exposure.rescale_intensity(hog_image, in_range=(0, 0.02))
    #plt.imshow(hog_image_rescaled, cmap=plt.cm.gray)
    #plt.show()
    ### DEBUG

    return fd

def getLBP(image):
    lbp = local_binary_pattern(image, 8, 1, 'uniform')
    return lbp