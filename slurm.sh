#!/bin/bash
#SBATCH --job-name=graphGPS
#SBATCH --output=/home/g202210120/projects/GraphGPS/logs/graphGPS_%j.out
#SBATCH --error=/home/g202210120/projects/GraphGPS/logs/graphGPS_%j.err
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --partition=gpu_x450
#SBATCH --gres=gpu:1
#SBATCH --chdir=/home/g202210120/projects/GraphGPS

set -e

# 1. Activate your Conda environment FIRST
source $(conda info --base)/etc/profile.d/conda.sh
conda activate graphgps

# 2. Force the node to use Conda's internal CUDA 11.7 libraries
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH

echo "Running on node: $(hostname)"
echo "Working directory: $(pwd)"
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
echo "Python path: $(which python)"
echo "Starting main.py"

# 3. Run the specific configuration
python -u main.py --cfg configs/GPS/zinc-GPS+RWSE.yaml wandb.use False

echo "Finished main.py"
