#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J prokka
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Structural annotation with Prokka script 

# Load modules 
module load bioinfo-tools prokka

# Sequence directories
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/3_binning_evaluation"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"

# Loop for annotation of all .fa 
#for fa in $SEQDIR/D1_metabat_output/*
#do
#echo $fa
#prokka --metagenome --cpus 2 $fa --outdir $OUTDIR/D1/"$fa"_ann.out
#done

for fb in $SEQDIR/D3_metabat_output/*
do
echo $fb
prokka --metagenome --cpus 2 $fb --outdir $OUTDIR/D3/"$fb"_ann.out
done
