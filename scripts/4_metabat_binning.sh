#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J metabat
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Binning with MetaBat script 

# Load modules
module load bioinfo-tools 
module load MetaBat

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/2_megahit_assembly"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/4_metabat_binning"

metabat -i $SEQDIR/D1_megahit_output/final.contigs.fa -o $OUTDIR/D1_metabat_output -t 2 -v
metabat -i $SEQDIR/D3_megahit_output/final.contigs.fa -o $OUTDIR/D3_metabat_output -t 2 -v
