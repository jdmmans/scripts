#!/bin/bash
# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="phastaf"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Array setup
#SBATCH --array=1-60 

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-0:08:00

wt=$((${SLURM_ARRAY_TASK_ID} * 2))
sleep $wt

# dependency soup
module load Miniconda3
source activate phastaf

# setup
cd /data/cephfs/punim0599/Jesse/emm75/contigs
ls | while read line; do

# work
/home/jmmans/phastaf/bin/phastaf --outdir /data/cephfs/punim0599/Jesse/emm75/phastaf/${line:0:-3} ${line}

done

