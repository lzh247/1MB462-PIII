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
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth/metabat_output"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/functional_eggnoggmapper"

# Change working directory
cd $OUTDIR/D1

# Loop
for fa in $SEQDIR/D1/*
do
echo $fa
emapper.py --itype metagenome -i $fa -o $fa --output_dir $OUTDIR/D1
done

# Change working directory
cd $OUTDIR/D3

for fa in $SEQDIR/D3/*
do
echo $fa
emapper.py --itype metagenome -i $fa -o $fa --output_dir $OUTDIR/D3
done
