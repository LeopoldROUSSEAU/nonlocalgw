#!/bin/bash
#SBATCH --job-name=TL_attn_k1
#SBATCH --partition=serc
#SBATCH -c 10
#SBATCH -G 1
#SBATCH --gpus-per-node=1
#SBATCH --time=96:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --output=gpu_slurm-%j.out
#SBATCH -C GPU_MEM:40GB
#SBATCH --mem-per-cpu=10GB

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

# 'attention/ann' 'global'(horizontal) 'global'/'stratosphere_only'(vertical) and 'feature_set', 'CHECKPOINT_EPOCH'
# TRAINING - ATTENTION
#python training_ifs_transfer_learning.py attention global global uvtheta 110
#python training_ifs_transfer_learning.py attention global global uvthetaw 119

#python training_ifs_transfer_learning.py attention global stratosphere_only uvtheta 119
#python training_ifs_transfer_learning.py attention global stratosphere_only uvthetaw 105

#python training_ifs_transfer_learning.py attention global stratosphere_update uvtheta 131
# THIS ONE FOR JAMES REVISIONS
python training_ifs_transfer_learning.py attention global stratosphere_update uvthetaw 119 1
#python training_ifs_transfer_learning.py attention global global uvw 150


# TRAINING - ANN_CNN
# 'attention/ann' 'global'(horizontal) 'global'/'stratosphere_only'(vertical) and 'feature_set', 'CHECKPOINT_EPOCH', <stencil>
# 1x1
#python training_ifs_transfer_learning.py ann global global uvtheta 94 1
#python training_ifs_transfer_learning.py ann global global uvthetaw 94 1

#python training_ifs_transfer_learning.py ann global stratosphere_only uvtheta 88 1
#python training_ifs_transfer_learning.py ann global stratosphere_only uvthetaw 100 1

#python training_ifs_transfer_learning.py ann global stratosphere_update uvtheta 100 1
# THIS ONE FOR JAMES REVISIONS
#python training_ifs_transfer_learning.py ann global stratosphere_update uvthetaw 100 1 1
#python training_ifs_transfer_learning.py ann global stratosphere_update uvw 100 1


# 3x3
#python training_ifs_transfer_learning.py ann global global uvtheta 52 3
#python training_ifs_transfer_learning.py ann global global uvthetaw 80 3

#python training_ifs_transfer_learning.py ann global stratosphere_only uvtheta 93 3
#python training_ifs_transfer_learning.py ann global stratosphere_only uvthetaw 38 3

#python training_ifs_transfer_learning.py ann global stratosphere_update uvtheta 68 3
#python training_ifs_transfer_learning.py ann global stratosphere_update uvthetaw 52 3

#python training_ifs_transfer_learning.py attention global global uvw 150
#python training_ifs_transfer_learning.py ann global global uvw 100 1
#python training_ifs_transfer_learning.py ann global stratosphere_update uvw 100 3


# =================== DELETE LATER ===============================
#for month in 1 2 3 4 5 6 7 8 9 10 11 12;
#do
#        python ANN_inference.py global uvw 200 ERA5 $month 1
#        python ANN_inference.py stratosphere_update uvw 200 ERA5 $month 3
#	python attn_inference.py global uvw 200 ERA5 $month
#
#        python ANN_inference.py stratosphere_only uvtheta 200 ERA5 $month 3
#        python ANN_inference.py stratosphere_only uvthetaw 200 ERA5 $month 3
#
#        python ANN_inference.py stratosphere_update uvtheta 200 ERA5 $month 3
#        python ANN_inference.py stratosphere_update uvthetaw 200 ERA5 $month 3
#
#done

#python ANN_inference.py global uvtheta 200 IFS 1 3
#python ANN_inference.py global uvthetaw 200 IFS 1 3

#python ANN_inference.py stratosphere_only uvtheta 200 IFS 1 3
#python ANN_inference.py stratosphere_only uvthetaw 200 IFS 1 3

#python ANN_inference.py stratosphere_update uvtheta 200 IFS 1 3
#python ANN_inference.py stratosphere_update uvthetaw 200 IFS 1 3
#python attn_inference.py global uvw 200 IFS 1 1
#python ANN_inference.py global uvw 200 IFS 1 1
#python ANN_inference.py stratosphere_update uvw 200 IFS 1 3 
