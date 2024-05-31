#!/bin/bash

# Run-1: Single echo (echo 2) + C-PAC
# Run-2: Single echo (echo 2) + NORDIC + C-PAC
# Run-3: 5 echos + TEDANA + C-PAC
# Run-4: 5 echos + NORDIC + TEDANA + C-PAC

# Run C-PAC only once, using the above scenarios as runs

# Defining files and paths
raw_data_folder='/data3/cdb/nesper/MultiEcho/RocklandSample2'
derivatives_folder='/data3/cdb/nesper/MultiEcho/RocklandSample2/derivatives'
cpac_image_folder='/data3/cdb/nesper/MultiEcho/CPAC_tests/scripts'
dataconfig_folder='/data3/cdb/nesper/MultiEcho/data_config'
scripts_folder='/data3/cdb/nesper/MultiEcho/scripts_me_cpac'
subjects_file=${scripts_folder}/all_subjects.txt
session='MRI1'
task='MoviePresent'

while read subject; do

    # Step 1 - Run NORDIC
    bash ${scripts_folder}/run_nordic.sh ${subject} ${raw_data_folder} ${derivatives_folder} ${scripts_folder} ${subjects_file} ${session} ${task}

    # Step 2 - Remove last three volumes - noise
    bash ${scripts_folder}/remove_noise_volumes.sh ${subject} ${raw_data_folder} ${derivatives_folder} ${scripts_folder} ${session} ${task}

    # Step 3 - Run TEDANA
    bash ${scripts_folder}/run_tedana.sh ${subject} ${raw_data_folder} ${derivatives_folder} ${scripts_folder} ${session} ${task}

    # Step 4 - Create data_config file for C-PAC
    bash ${scripts_folder}/create_dataconfig.sh ${subject} ${raw_data_folder} ${derivatives_folder} ${dataconfig_folder} ${scripts_folder} ${session} ${task}

    # Step 5 - Run C-PAC
    bash ${scripts_folder}/run_cpac.sh ${subject} ${raw_data_folder} ${derivatives_folder} ${cpac_image_folder} ${dataconfig_folder} ${scripts_folder} ${session} ${task}

done <${subjects_file}

echo "Done!"
