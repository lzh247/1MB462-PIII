#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 12:00:00
#SBATCH -J megahit
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# FastQC quality control script 

# Load modules
module load bioinfo-tools
module load megahit 

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/data/DNA_trimmed"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/2_assembly_evaluation"

# Run megahit on sites D1 and D2
# Parameters fromthe paper (IBDA-UB): -mink 65 -maxk 105 -step 10.

megahit --k-min 65 --k-max 105 --k-step 10 --kmin-1pass -1 $SEQDIR/SRR4342129_1.paired.trimmed.fastq.gz -2 $SEQDIR/SRR4342129_2.paired.trimmed.fastq.gz -o $OUTDIR/D1_megahit_output 2>$OUTDIR/D1_assembly_output

megahit --k-min 65 --k-max 105 --k-step 10 --kmin-1pass -1 $SEQDIR/SRR4342133_1.paired.trimmed.fastq.gz -2 $SEQDIR/SRR4342133_2.paired.trimmed.fastq.gz -o $OUTDIR/D3_megahit_output 2>$OUTDIR/D3_assembly_output
