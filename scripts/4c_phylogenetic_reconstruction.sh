#!/bin/bash -l
#SBATCH -A uppmax2022-2-5 -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -J phylogenetic
#SBATCH -t 10:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# NOT WORKING

# Phylogenetic reconstruction script, based on bins. 

# Load modules
module load bioinfo-tools python biopython FasTree muscle usearch/5.2.32
