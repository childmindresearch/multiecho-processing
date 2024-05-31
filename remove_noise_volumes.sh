#!/bin/bash

# set default paths
subject=$1
raw_data_folder=$2
derivatives_folder=$3
scripts_folder=$4
session=$5
task=$6

noise_volume_last=3

for echo in {1..5}
do
    num_vols=$(fslinfo "${raw_data_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}_task-${task}_echo-${echo}_part-mag_bold.nii.gz" | grep -w 'dim4' | awk '{print $2}')
    end_vol=$((num_vols - noise_volume_last - 1))

    3dTcat -prefix ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}_task-${task}_echo-${echo}_part-mag_desc-noNoise_bold.nii.gz \
           ${raw_data_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}_task-${task}_echo-${echo}_part-mag_bold.nii.gz'[0..${end_vol}]'

done
