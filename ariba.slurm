#!/bin/bash
# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# array
#SBATCH --array=1-8

# The name of the job:
#SBATCH --job-name="Ariba"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-3:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# delay - a decent delay
wt=$((${SLURM_ARRAY_TASK_ID} * 10))
sleep $wt

# Dependency soup
module load Miniconda3
source activate ariba

# delay - a decent delay
wt=$((${SLURM_ARRAY_TASK_ID} * 10))
sleep $wt

# setting files name
cd /data/cephfs/punim0599/Jesse/emm75/fastqs
ls | while read line; do
	if [[ "$line" == *"R1"* ]] ; then
		 var1=${line:0:-11}
			var2=${var1}R2.fastq.gz
fi

# variables used 
driv="/data/cephfs/punim0599/Jesse/emm75/ariba/out.ncbi.prepareref"
out="/data/cephfs/punim0599/Jesse/emm75/ariba/${var1}"
read1="/data/cephfs/punim0599/Jesse/emm75/fastqs/${line}"
read2="/data/cephfs/punim0599/Jesse/emm75/fastqs/${var2}"

#work - #drive ariba was "ariba getref ncbi out.ncbi" in - # read1 - # read 2 # outdrive
ariba run ${driv} ${read1} ${read2} ${out}

done

