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
module load bioinfo-tools phylophlan/0.99 python/2.7.15 biopython/1.73 FastTree muscle/3.8.31 usearch/5.2.32

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/3b_phylo_reconstruct"

# Copy installed phylophlan files into working directory. 
cp -r /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/* $OUTDIR/

# The input .fa files will be the Prokka output, as these include amino acid sequence and not only nucleotide, in contrast to the binning output. 
# Further, the file names have to be changed back to .fa


# Run pylophlan 
cd $OUTDIR/D1/
$OUTDIR/phylophlan.py -i $SEQDIR/D1/*.fa_ann.out/*.faa -t --nproc 2 2> D1_phylo.err
cd $OUTDIR/D3/
$OUTDIR/phylophlan.py -i $SEQDIR/D3/*.fa_ann.out/*.faa -t --nproc 2 2> D3_phylo.err
