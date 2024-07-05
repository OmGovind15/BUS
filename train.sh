#!/bin/bash

#SBATCH --job-name=bus_Decon
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-gpu=4
#SBATCH --mem-per-gpu=28G
#SBATCH --partition batch_grad
#SBATCH -o case5_%j.out
#SBATCH --time=7-0


#source /data/opt/anaconda3/bin/conda init
source /data/dragoon0905/init.sh
conda activate hrda2

python run_experiments.py --config configs/mic/gtaHR2csHR_mic_hrda_512.py




