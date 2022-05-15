#!/bin/bash -l
#SBATCH -A uppmax2022-2-5 -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -J coverage_RNA
#SBATCH -t 10:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Reading RNA coverage with samtools script 

# Load modules 
module load bioinfo-tools 
module load samtools

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA"

# Index BAM files
samtools index $SEQDIR/D1_sorted.bam
samtools index $SEQDIR/D3_sorted.bam

# Create summary table with statistics 
samtools coverage $SEQDIR/D1_sorted.bam -o $OUTDIR/D1_coverage
samtools coverage $SEQDIR/D3_sorted.bam -o $OUTDIR/D3_coverage

# Depth for per base coverage instead of average
samtools depth $SEQDIR/D1_sorted.bam -o $OUTDIR/D1_depth  
samtools depth $SEQDIR/D3_sorted.bam -o $OUTDIR/D3_depth  

# More statistics 
