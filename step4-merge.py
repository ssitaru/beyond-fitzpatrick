#!/usr/bin/python

import pandas as pd
import os

in1 = 'out_arm.csv'
in2 = 'out_openface.csv'
out = 'out.csv'

in1pd = pd.read_csv(in1)
in2pd = pd.read_csv(in2)  

mergepd = in1pd.merge(in2pd, on = 'id')

print(mergepd)
mergepd.to_csv(out, index=False)