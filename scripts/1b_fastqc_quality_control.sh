#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:20:00
#SBATCH -J fastqc
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se
#SBATCH --output=/home/lihu6475/1MB462-PIII/slurm_outs/%j.out

# FastQC quality control script 

# Load modules
module load bioinfo-tools
module load FastQC/0.11.9

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/data"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/1_quality_control"

# Run FastQC trimmed DNA
for file in $SEQDIR/DNA_trimmed/*
do
fastqc $file -o $OUTDIR/DNA_trimmed_fastqc/
done

# Run FastQC untrimmed DNA
for file in $SEQDIR/RNA_untrimmed/*
do
fastqc $file -o $OUTDIR/RNA_untrimmed_fastqc/
done

# Run FastQC on trimmed RNA
for file in $SEQDIR/RNA_trimmed/*
do
fastqc $file -o $OUTDIR/RNA_trimmed_fastqc/
done

