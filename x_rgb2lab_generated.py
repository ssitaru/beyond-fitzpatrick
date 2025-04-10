#!/usr/bin/python

import csv
import skimage.color
from math import atan,pi
from PIL import ImageColor

# id,hex_arm,ita_arm,hex_face,ita_face
fin = "out.generated.ita.csv"
fout = "out.generated.lab.csv"

csvin = csv.DictReader(open(fin, 'r'))
outf = open(fout, 'w')
outcsv = csv.DictWriter(outf, ['id', 'hex_arm', 'l_arm', 'a_arm', 'b_arm', 'ita_arm', 'hex_face', 'l_face', 'a_face', 'b_face', 'ita_face'])
outcsv.writeheader()

for line in csvin:
    print(line)
    hex_arm = line['hex_arm']
    rgb_arm = [i/256 for i in ImageColor.getrgb("#"+hex_arm)]
    lab_arm = skimage.color.rgb2lab(rgb_arm)

    hex_face = line['hex_face']
    rgb_face = [i/256 for i in ImageColor.getrgb("#"+hex_face)]
    lab_face = skimage.color.rgb2lab(rgb_face)

    outcsv.writerow({'id': line['id'], 'hex_arm': line['hex_arm'], 'l_arm': lab_arm[0], 'a_arm': lab_arm[1], 'b_arm': lab_arm[2], 'ita_arm': line['ita_arm'],
                     'hex_face': line['hex_face'], 'l_face': lab_face[0], 'a_face': lab_face[1], 'b_face': lab_face[2], 'ita_face': line['ita_face']})
