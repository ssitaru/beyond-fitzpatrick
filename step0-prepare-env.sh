#!/bin/sh

conda env create -f conda-env.yml
conda activate detectron2
git clone https://github.com/facebookresearch/detectron2.git
python -m pip install -e detectron2
cd detectron2/projects/DensePose
python setup.py install