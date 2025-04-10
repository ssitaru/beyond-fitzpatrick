#!/bin/bash
# apply DensePose to a dir of images

in="data.generated/test"
config="densepose_rcnn_R_101_FPN_s1x.yaml"
model="model_final_c6ab63.pkl"

python detectron2/projects/DensePose/apply_net.py dump --output output.generated.pkl models/$config models/$model "$in/*"