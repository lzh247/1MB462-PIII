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
module load MetaBat

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/3_binning_evaluation/binning_with_depth"
OUTDIR=$SEQDIR

# Run binning with depth and .bam-files
jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/depth.txt --pairedContigs $OUTDIR/paired.txt $SEQDIR/*.bam
metabat -i assembly.fa -a $OUTDIR/depth.txt -p $OUTDIR/paired.txt -o $OUTDIR/bin --specific -l -v --saveTNF saved.tnf --saveDistance saved.gprob
