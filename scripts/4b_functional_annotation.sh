#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 100:00:00
#SBATCH -J eggnoggmapper
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Functional annotation with EggNoggMapper script

# Load modules
module load bioinfo-tools eggNOG-mapper

# Sequence directories
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/3_binning_evaluation"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/functional_eggnoggmapper"

# Loop
for fa in $SEQDIR/D1_metabat_output/*
do
echo $fa
emapper.py --itype metagenome -i $fa -o $fa --output_dir $OUTDIR/D1
done

for fa in $SEQDIR/D3_metabat_output/*
do
echo $fa
emapper.py --itype metagenome -i $fa -o $fa --output_dir $OUTDIR/D3
done
