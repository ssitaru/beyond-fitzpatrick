# code for "Beyond Fitzpatrick: Automated Artificial Intelligence-based Skin Tone Analysis in Dermatological Patients"

The scripts are written by Sebastian Sitaru, 2024. License: MIT.

## 0. setup
run ```step0-prepare-env.sh```.

This will install a new conda environment containing all the necessary packages.

## 1.1. run the DensePose inference on the arm images
```./step1-inference-arm.sh```

## 1.2. run the OpenFace inference to get nose pixels
We ran this on a Windows computer due to versioning problems. Just run:
```FaceLandmarkImg.exe -fdir "<DIR>"``` with DIR pointing to the data directory.

## 2. gather the DensePose pixel data (arm)
```./step2-analyze-arm.sh```

## 3. gather the OpenFace pixel data (nose)
```./step3-analyze-arm.sh```

## 4. merge the datasets
```./step4-merge.py```

## NB
The x_ scripts are old and should not be used.