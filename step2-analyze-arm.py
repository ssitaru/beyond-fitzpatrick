#!/usr/bin/python
# read detectron2's pkl and generate csv

import torch
import os
from PIL import Image
import numpy as np
from csv import DictWriter
import skimage.color
from math import atan,pi

rawdir = 'data.generated/test'
out = 'x_tmp_out_back2.csv'

f = open('output.generated.pkl', 'rb')
data = torch.load(f)

outf = open(out, 'w')
outcsv = DictWriter(outf, ['id', 'hex_arm', 'l_arm', 'u_arm', 'v_arm', 'ita_arm'])
outcsv.writeheader()

for img in data:
    if len(img['pred_boxes_XYXY']) < 1:
        continue
    box_origin_x = int(img['pred_boxes_XYXY'][0][0].round())
    box_origin_y = int(img['pred_boxes_XYXY'][0][1].round())
    p = os.path.basename(img['file_name'])
    imgfile = rawdir+'/'+p
    print('opening '+imgfile)
    print(img['scores'])
    with Image.open(imgfile) as pil_img:
        # only use first detection
        labels = np.array(img['pred_densepose'][0].labels.cpu())
        print(np.unique(labels))
        xy_label = np.asarray(np.column_stack(np.where((labels == 19) | (labels == 20))))
        tot_r = tot_g = tot_b = 0
        rgb_im = pil_img.convert('RGB')
        for pixel in xy_label:
            (r, g, b) = rgb_im.getpixel((pixel[1]+box_origin_x, pixel[0]+box_origin_y))
            tot_r = tot_r + r
            tot_g = tot_g + g
            tot_b = tot_b + b
            # for debug
            pil_img.putpixel((pixel[1]+box_origin_x, pixel[0]+box_origin_y), (255 , 0, 0))
        # for debug
        pil_img.save(imgfile+'_mod.png')
        print(len(xy_label), 'pixels')
        if(len(xy_label) > 0):
            tot_r = round(tot_r / len(xy_label))
            tot_g = round(tot_g / len(xy_label))
            tot_b = round(tot_b / len(xy_label))
            hexcolor = ''.join(f'{i:02x}' for i in [tot_r, tot_g, tot_b])
            luv = skimage.color.rgb2luv((tot_r / 255, tot_g/255, tot_b/255))
            lab = skimage.color.rgb2lab((tot_r / 255, tot_g/255, tot_b/255))
            # ITA = [arctan(L*-50)/b*)] *180/p
            # doi: 10.1111/php.13562
            ita = (atan(lab[0]-50)/lab[1]) * 180/pi
            print(ita)

            outcsv.writerow({'id': p, 'hex_arm': hexcolor, 'l_arm': luv[0], 'u_arm': luv[1], 'v_arm': luv[2], 'ita_arm': ita})