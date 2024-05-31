#!/bin/bash

subject=$1
raw_data_folder=$2
derivatives_folder=$3
dataconfig_folder=$4
scripts_folder=$5
session=$6
task=$7

fname=${dataconfig_folder}/dataconfig_${subject}_task-${task}.yml

cat > ${fname} << EOF
- anat:
    T1w: ${raw_data_folder}/${subject}/ses-${session}/anat/${subject}_ses-${session}_T1w.nii.gz
  func:
    func-1:
      scan: ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}_task-${task}_echo-2_part-mag_desc-noNoise_bold.nii.gz
    func-2:
      scan: ${derivatives_folder}/${subject}/ses-${session}/func/${subject}_ses-${session}_task-${task}_echo-2_part-mag_desc-nordicNoNoise_bold.nii.gz
    func-3:
      scan: ${derivatives_folder}/tedana_5echos/${subject}/ses-${session}/ts_OC.nii.gz
    func-4:
      scan: ${derivatives_folder}/tedana_nordic_5echos/${subject}/ses-${session}/ts_OC.nii.gz
  site: site-NKIRS
  subject_id: ${subject}
  unique_id: ses-${session}

EOF