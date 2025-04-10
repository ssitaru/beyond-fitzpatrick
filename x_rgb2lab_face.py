#!/usr/bin/python

import csv
import skimage.color
from math import atan,pi

# id,r,g,b,hex_face,ita_face
fin = "out_face.csv"
fout = "out_face.lab.csv"

csvin = csv.DictReader(open(fin, 'r'))
outf = open(fout, 'w')
outcsv = csv.DictWriter(outf, ['id', 'r', 'g', 'b', 'l_face', 'a_face', 'b_face', 'ita_face'])
outcsv.writeheader()

for line in csvin:
    print(line)
    r = int(line['r'])/255
    g = int(line['g'])/255
    b = int(line['b'])/255
    lab = skimage.color.rgb2lab([r, g, b])

    outcsv.writerow({'id': line['id'], 'r': line['r'], 'g': line['g'], 'b': line['b'], 'l_face': lab[0], 'a_face': lab[1], 'b_face': lab[2], 'ita_face': line['ita_face']})
