#!/bin/bash

# set default paths
subject=$1
raw_data_folder=$2
derivatives_folder=$3
scripts_folder=$4
input_file=$5
session=$6
task=$7

# Define NORDIC parameters
temporal_phase=1
phase_filter_width=10
noise_volume_last=3

echo "Processing NORDIC on subject $subject"
subject_folder=${raw_data_folder}/${subject}/ses-${session}
subject_anat_folder=${subject_folder}/anat
subject_func_folder=${subject_folder}/func
output_folder=${derivatives_folder}/${subject}/ses-${session}/func

mkdir -p $output_folder

# Loop through the echos
for mag_echo in ${subject_func_folder}/*${task}*part-mag*.nii.gz; do
    echo $mag_echo
    phase_echo="${mag_echo/mag/phase}"
    output_filename="${mag_echo%_*}_desc-nordic_bold"
    output_filename=${output_filename##*/} # to remove the path

    python3.6 ${scripts_folder}/nordic_processing.py $mag_echo $phase_echo $output_filename

    mv *.nii $output_folder

    # Data organization post NORDIC processing
    cd $output_folder
    gzip -v *.nii

    # Remove last 3 volumes - noise volumes
    num_vols=$(fslinfo "${mag_echo}" | grep -w 'dim4' | awk '{print $2}')
    end_vol=$((num_vols - noise_volume_last - 1))
        
    fname_no_noise="${output_filename%_bold}NoNoise_bold.nii.gz"
    output_filename=${output_filename}.nii.gz
        
    3dTcat -prefix "$fname_no_noise" "$output_filename[0..$end_vol]"

done
