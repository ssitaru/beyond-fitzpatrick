#!/usr/bin/python

import csv
import skimage.color
from math import atan,pi
from PIL import ImageColor

# id,hex_arm,l_arm,a_arm,b_arm,ita_arm,hex_face,l_face,a_face,b_face,ita_face
fin = "out_front_merged.csv"
fout = "out_front.fixedv3.csv"

csvin = csv.DictReader(open(fin, 'r'))
outf = open(fout, 'w')
outcsv = csv.DictWriter(outf, ['id', 'l_arm', 'a_arm', 'b_arm', 'ita_arm', 'l_face', 'a_face', 'b_face', 'ita_face'])
outcsv.writeheader()

for line in csvin:
    print(line)
    l_arm = float(line['l_arm'])
    b_arm = float(line['b_arm'])
    ita_arm = atan((l_arm - 50) / b_arm) * 180/pi

    l_face = float(line['l_face'])
    b_face = float(line['b_face'])
    ita_face = atan((l_face - 50)/b_face) * 180/pi


    outcsv.writerow({'id': line['id'], 'l_arm': line['l_arm'], 'a_arm': line['a_arm'], 'b_arm': line['b_arm'], 'ita_arm': ita_arm,
                     'l_face': l_face, 'a_face': line['a_face'], 'b_face': line['b_face'], 'ita_face': ita_face})
