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
module load bioinfo-tools phylophlan/0.99 python/2.7.15 biopython/1.78 FastTree muscle/3.8.31 usearch/5.2.32

# Sequence rectories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/3b_phylo_reconstruct"

# Copy installed phylophlan files into working directory. 
cp -r /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/* $OUTDIR/

# Run pylophlan 
# The input .fa files will be the Prokka output, as these include amino acid sequence and not only nucleotide, in contrast to the binning output.
$OUTDIR/phylophlan.py -i $SEQDIR/D1/*.fa_ann.out -t --nproc 2 -o $OUTDIR/D1/ 2> D1_phylo.err
$OUTDIR/phylophlan.py -i $SEQDIR/D3/*.fa_ann.out -t --nproc 2 -o $OUTDIR/D3/ 2> D3_phylo.err
