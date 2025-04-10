#!/bin/bash

config="densepose_rcnn_R_101_FPN_s1x.yaml"
model="model_final_c6ab63.pkl"

python detectron2/projects/DensePose/apply_net.py show  models/$config models/$model "$1" dp_segm --output output.jpg 