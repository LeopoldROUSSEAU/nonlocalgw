#!/bin/bash
#SBATCH --job-name=Unet_Train
#SBATCH --partition=serc
#SBATCH -c 10
#SBATCH -G 1
#SBATCH --gpus-per-node=1
#SBATCH --time=120:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=gpu_slurm-%j.out
#SBATCH -C GPU_MEM:80GB
#SBATCH --mem-per-cpu=20GB

# from Mark:
# use sh_node_feat -p serc (or gpu) to see the node structure of the partition and what GPUs are available
# -c indicates cpu_per_task
# -G is the number of GPUs you want to request
# -p is the partition
# requesting SBATCH -G 4 || AND || --gpus-per-node=4 allocated 4 GPUs within a single node
# if you want the distributed over two nodes, do: -G 4 || --gpus-per-node=2

# for more information on GPUs on sherlock: https://www.sherlock.stanford.edu/docs/user-guide/gpu/#gpu-types

source /home/groups/aditis2/ag4680/miniconda3/etc/profile.d/conda.sh
conda activate siv2

# 'global'/'stratosphere_only'/'stratosphere_update' and 'feature_set'
# TRAINING
#python training_attention_unet.py global uvw
#python training_attention_unet.py stratosphere_update uvthetaw
#python training_attention_unet.py stratosphere_update uvtheta
#python training_attention_unet.py stratosphere_update uvw


python training_attention_unet.py global uvthetaw
#python training_attention_unet.py global uvtheta
#python training_attention_unet.py global uvw


#python inference.py stratosphere_update uvthetaw 119 9 /scratch/users/ag4680/training_data/era5/1x1_inputfeatures_u_v_theta_w_uw_vw_era5_training_data_hourly_2002_constant_mu_sigma_scalingSept20to30.nc

#python inference.py stratosphere_update uvthetaw 119 1 /scratch/users/ag4680/training_data/era5/1x1_inputfeatures_u_v_theta_w_uw_vw_era5_training_data_hourly_2013_constant_mu_sigma_scalingJan01to15.nc 

#python inference.py stratosphere_update uvthetaw 119 8 /scratch/users/ag4680/training_data/era5/1x1_inputfeatures_u_v_theta_w_uw_vw_era5_training_data_hourly_2019_constant_mu_sigma_scalingAug03to10.nc




#for month in 1 2 3 4 5 6 7 8 9 10 11 12;
#do
#	python inference.py global uvtheta 110 $month
#	python inference.py global uvthetaw 119 $month
	
#	python inference.py stratosphere_only uvtheta 119 $month
#	python inference.py stratosphere_only uvthetaw 105 $month

#	python inference.py stratosphere_update uvtheta 131 $month
#	python inference.py stratosphere_update uvthetaw 119 $month
#	python inference.py global uvw 150 $month
#done



# INFERENCE
# Most optimal epochs to use for respective configs
# stratosphere_only | uvtheta  | epoch=100 | month
# stratosphere_only | uvthetaw | epoch=100 | month
# Usage: python inference.py <vertical> <features> <epoch> <month>
#python probabilistic_inference.py stratosphere_only uvthetaw 100 $month 1
#python probabilistic_inference.py stratosphere_only uvtheta 100 $month 1

#python inference_ifs.py global uvw 150 1

