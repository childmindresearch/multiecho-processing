#!/bin/bash
#SBATCH --job-name=cpac_preproc
#SBATCH --output=multiecho_cpac_preproc.out
#SBATCH -N1 --ntasks-per-node=4
#SBATCH --mem-per-cpu=20G

subject=$1
raw_data_folder=$2
derivatives_folder=$3
cpac_image_folder=$4
dataconfig_folder=$5
scripts_folder=$6
session=$7
task=$8

cd ${scripts_folder}
mkdir tmp
mkdir ${derivatives_folder}/C-PAC
cpac_outputs=${derivatives_folder}/C-PAC


singularity run -e \
  -B ${raw_data_folder}:${raw_data_folder} \
  -B ${derivatives_folder}:${derivatives_folder} \
  -B ${derivatives_folder}:/outputs/ \
  -B ${scripts_folder}/tmp:/tmp/ \
  -B ${dataconfig_folder}:/data_config/ \
  ${cpac_image_folder}/c-pac_latest.sif ${raw_data_folder} /outputs participant \
  --preconfig rbc-options \
  --data_config_file /data_config/dataconfig_${subject}_task-${task}.yml \
  --participant_label ${subject} \
  --n_cpus 8 \
  --mem_gb 15 \
  --num_ants_threads 3 \
  --skip_bids_validator \
  --save_working_dir
