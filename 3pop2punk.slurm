#!/bin/bash
# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="GWAS"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-1:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# needed modules
module load Miniconda3
source activate popPUNK

# variables used 
rm -R /data/cephfs/punim0599/Jesse/emm75/GAS_query_new/GASupdate
out="/data/cephfs/punim0599/Jesse/emm75/GAS_query_new"
cd $out

# popPUNK
poppunk --assign-query --model-dir /data/cephfs/punim0599/Jesse/emm75/GAS_query_new --distances GAS_query_new.dists --previous-clustering /data/cephfs/punim0599/Jesse/emm75/GAS_query_new --ref-db /data/cephfs/punim0599/Jesse/emm75/GAS_query_new --q-files /data/cephfs/punim0599/Jesse/emm75/poppunklist.txt --output GASupdate --threads 4
done
