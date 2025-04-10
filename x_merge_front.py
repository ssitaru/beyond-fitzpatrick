#!/usr/bin/python

import pandas as pd

in1 = 'out_front.lab.csv'
in2 = 'out_front_face.csv'
out = 'out_front_merged.csv'

in1pd = pd.read_csv(in1)
in2pd = pd.read_csv(in2)  

mergepd = in1pd.merge(in2pd, on = 'id')

print(mergepd)
mergepd.to_csv(out, index=False)