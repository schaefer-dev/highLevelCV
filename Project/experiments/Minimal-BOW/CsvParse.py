import csv

def parseCsv(path):
	with open(path, 'rb') as csvfile:
		spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
		file = []
		for row in spamreader:
			file.append(row)

	return file