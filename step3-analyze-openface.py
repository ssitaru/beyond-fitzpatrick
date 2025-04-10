#!/usr/bin/python

from csv import DictReader, DictWriter
import sys 
from PIL import Image
from glob import glob
from pathlib import Path
import skimage.color
from math import atan,pi

dir = 'in_openface_front'
out = 'out_front_face.csv'
raw = 'data.front'

out_writer = DictWriter(open(out, "w"), ['id', 'r', 'g', 'b', 'l_face', 'a_face', 'b_face', 'ita_face'])
out_writer.writeheader()

for file in glob(dir+'/*.csv'):
    id = Path(file).stem

    print(id, file)
    with open(file, "r") as f:
        dr = DictReader(f)
        for row in dr:
            # 27. 28. 29. 30 are landmarks on the nose
            lms = []
            lms.append((round(float(row[" x_27"])), round(float(row[" y_27"]))))
            lms.append((round(float(row[" x_28"])), round(float(row[" y_28"]))))
            lms.append((round(float(row[" x_29"])), round(float(row[" y_29"]))))
            lms.append((round(float(row[" x_30"])), round(float(row[" y_30"]))))
            #print(lms)

    total_r =0
    total_b =0
    total_g = 0

    with Image.open(raw+'/'+id+'.png', "r") as img:
        rgb_im = img.convert('RGB')
        for p in lms:
            r, g, b = rgb_im.getpixel(p)
            total_r = total_r + r
            total_g = total_g + g
            total_b = total_b + b

    total_r = round(total_r / 4)
    total_g = round(total_g / 4)
    total_b = round(total_b / 4)
    hex = ''.join(f'{i:02x}' for i in [total_r, total_g, total_b])
    lab = skimage.color.rgb2lab([total_r/255, total_g/255, total_b/255])
    ita = (atan(lab[0]-50)/lab[2]) * 180/pi
    print(ita)

    out_writer.writerow({'id': id+'.png', 'r': total_r, 'g': total_g, 'b': total_b, 'l_face': lab[0], 'a_face': lab[1], 'b_face': lab[2], 'ita_face': ita})
