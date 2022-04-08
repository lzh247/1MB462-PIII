#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J checkm
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Bin evaluation with ChheckM script 

# Load modules
module load bioinfo-tools 
module load CheckM

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/3_assembly_evaluation"
OUTDIR=$SEQDIR/...

# Run CheckM on ... 
# Threads = 4
checkm lineage_wf -t 4 -x fa $SEQDIR/... $OUTDIR
