#!/usr/bin/python

import csv
import skimage.color
from math import atan,pi

fin = "out.generated.csv"
fout = "out.generated.ita.csv"

csvin = csv.reader(open(fin, 'r'))
outf = open(fout, 'w')
outcsv = csv.DictWriter(outf, ['id', 'hex_arm', 'ita_arm', 'hex_face', 'ita_face'])
outcsv.writeheader()

next(csvin)

for line in csvin:
    print(line)
    l_arm = float(line[2])
    u_arm = float(line[3])
    v_arm = float(line[4])
    rgb_arm = skimage.color.luv2rgb([l_arm, u_arm, v_arm])
    lab_arm = skimage.color.rgb2lab(rgb_arm)
    ita_arm = ita = (atan(lab_arm[0]-50)/lab_arm[1]) * 180/pi
    
    l_face = float(line[6])
    u_face = float(line[7])
    v_face = float(line[8])
    rgb_face = skimage.color.luv2rgb([l_face, u_face, v_face])
    lab_face = skimage.color.rgb2lab(rgb_face)
    ita_face = ita = (atan(lab_face[0]-50)/lab_face[1]) * 180/pi

    outcsv.writerow({'id': line[0], 'hex_arm': line[1], 'ita_arm': ita_arm, 'hex_face': line[5], 'ita_face': ita_face})
