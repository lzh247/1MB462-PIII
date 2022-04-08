#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 12:00:00
#SBATCH -J metabat
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Binning with depth file and Metabat script

# Load modules
module load bioinfo-tools
module load metabat

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/3_binning_evaluation"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/3_binning_evaluation"

# Run binning
jgi_summarize_bam_contig_depths --outputDepth depth.txt --pairedContigs paired.txt *.bam
metabat -i assembly.fa -a depth.txt -p paired.txt -o bin --specific -l -v --saveTNF saved.tnf --saveDistance saved.gprob
