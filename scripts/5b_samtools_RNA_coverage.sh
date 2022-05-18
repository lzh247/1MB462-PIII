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
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA/statistics"

cd $SEQDIR
for bam in D1_normalized.*.fa_sorted.bam
do 
#samtools coverage $bam -o $OUTDIR/${bam}_coverage
#samtools depth $bam -o $OUTDIR/${bam}_depth
samtools stats $bam | grep ^SN | cut -f 2- > $OUTDIR/${bam}_summary  
done

for bam in D3_normalized.*.fa_sorted.bam
do 
#samtools coverage $bam -o $OUTDIR/${bam}_coverage
#samtools depth $bam -o $OUTDIR/${bam}_depth
samtools stats $bam | grep ^SN | cut -f 2- > $OUTDIR/${bam}_summary  
done
