#!/usr/bin/python

import csv
import skimage.color
from math import atan,pi
from PIL import ImageColor

# id,hex_arm,l_arm,u_arm,v_arm,ita_arm
fin = "out_front.csv"
fout = "out_front.lab.csv"

csvin = csv.DictReader(open(fin, 'r'))
outf = open(fout, 'w')
outcsv = csv.DictWriter(outf, ['id', 'r', 'g', 'b', 'l_arm', 'a_arm', 'b_arm', 'ita_arm'])
outcsv.writeheader()

for line in csvin:
    print(line)
    hex = line['hex_arm']
    rgb = [i/256 for i in ImageColor.getrgb("#"+hex)]
    lab = skimage.color.rgb2lab(rgb)

    outcsv.writerow({'id': line['id'], 'r': round(rgb[0]*255), 'g': round(rgb[1]*255), 'b': round(rgb[2]*255), 'l_arm': lab[0], 'a_arm': lab[1], 'b_arm': lab[2], 'ita_arm': line['ita_arm']})
