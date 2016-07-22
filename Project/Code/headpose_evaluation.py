import CsvParse
import numpy as np
import matplotlib.pyplot as plt

def histogram(L):
    for x in L:
        if x in d:
            d[x] += 1
        else:
            d[x] = 1
    return d


imgClassList = ["c0", "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9"]
#imgClassList = ["c0"]

for imgClass in imgClassList:
    file = CsvParse.parseCsv("../experiments/Face/face-release1.0-basic/" + imgClass + ".csv")
    del file[0]

    poseArray = []
    for line in file:
        poseArray.append(float(line[3].split()[0]))

    hist, bin_edges = np.histogram(poseArray, bins=[-90, -75, -60, -45, -30, -15, 0, 15, 30, 45, 60, 75, 90, 105])
    # print hist
    # print imgClass + ": " + str(histogram(poseArray))

    plt.bar(bin_edges[:-1], hist, width = 15)

    plt.xlim(min(bin_edges), max(bin_edges))

    plt.title(imgClass)

    plt.xticks((-82, -67, -52, -37, -22, -7, 8, 23, 38, 53, 68, 83, 98),('-90', '-75', '-60', '-45', '-30', '-15', '0', '15', '30', '45', '60', '75', '90'))

    plt.show()