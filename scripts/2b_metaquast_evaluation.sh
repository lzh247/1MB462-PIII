#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J metaquast
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# DNA assembly evaulation with MetaQuast script 

# Load modules
module load bioinfo-tools 
module load quast

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/2_assembly_evaluation"
OUTDIR=$SEQDIR

# Run metaquast on sites D1 and D3, assembled by megahit 

metaquast.py -o $OUTDIR/D1_metaquast_out $SEQDIR/D1_megahit_output/final.contigs.fa
metaquast.py -o $OUTDIR/D3_metaquast_out $SEQDIR/D3_megahit_output/final.contigs.fa
