#!/bin/bash
# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="psudeo_reads"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-0:02:00

# needed modules
module load zlib/1.2.9-intel-2017.u2
module load Seqtk/1.3-r106-intel-2017.u2

cd /data/cephfs/punim0599/Jesse/emm75/contigs
ls | while read line; do
if [[ "$line" == *".fna"* ]]; then
    var2="${line:0:-4}"
else
    var2="${line:0:-3}"
echo $var2
fi
#work
seqtk seq ${line} > /data/cephfs/punim0599/Jesse/emm75/reads/${var2}.R1.fastq
seqtk seq ${line} > /data/cephfs/punim0599/Jesse/emm75/reads/${var2}.R2.fastq

done
