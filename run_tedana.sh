#!/bin/bash

# set default paths
subject=$1
raw_data_folder=$2
derivatives_folder=$3
scripts_folder=$4
session=$5
task=$6

echo_times=("13.2" "33.46" "53.72" "73.98" "94.24")

rm automask+orig*

3dAutomask ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}*task-${task}*echo-2_part-mag_desc-nordicNoNoise_bold.nii.gz
mask_file='automask+orig.HEAD'

mkdir -p ${derivatives_folder}/tedana_nordic_5echos/${subject}/ses-${session}

tedana -d ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}*task-${task}*echo-*_part-mag_desc-nordicNoNoise_bold.nii.gz \
       -e ${echo_times[@]} \
       --mask ${mask_file} \
       --convention orig \
       --no-reports \
       --out-dir ${derivatives_folder}/tedana_nordic_5echos/${subject}/ses-${session}/



rm automask+orig*

3dAutomask ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}*task-${task}*echo-2_part-mag_desc-noNoise_bold.nii.gz
mask_file='automask+orig.HEAD'

mkdir -p ${derivatives_folder}/tedana_5echos/${subject}/ses-${session}

tedana -d ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}*task-${task}*echo-*_part-mag_desc-noNoise_bold.nii.gz \
       -e ${echo_times[@]} \
       --mask ${mask_file} \
       --convention orig \
       --no-reports \
       --out-dir ${derivatives_folder}/tedana_5echos/${subject}/ses-${session}/


rm automask+orig*


