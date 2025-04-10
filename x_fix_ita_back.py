#!/usr/bin/python

import csv
import skimage.color
from math import atan,pi
from PIL import ImageColor

# id,r,g,b,l_arm,a_arm,b_arm,ita_arm
fin = "out_back.lab.csv"
fout = "out_back.fixedv3.csv"

csvin = csv.DictReader(open(fin, 'r'))
outf = open(fout, 'w')
outcsv = csv.DictWriter(outf, ['id', 'l_arm', 'a_arm', 'b_arm', 'ita_arm'])
outcsv.writeheader()

for line in csvin:
    print(line)
    l_arm = float(line['l_arm'])
    b_arm = float(line['b_arm'])
    ita_arm = (atan(l_arm - 50)/b_arm) * 180/pi

    outcsv.writerow({'id': line['id'], 'l_arm': line['l_arm'], 'a_arm': line['a_arm'], 'b_arm': line['b_arm'], 'ita_arm': ita_arm})
