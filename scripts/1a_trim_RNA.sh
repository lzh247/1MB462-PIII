#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:15:00
#SBATCH -J trim_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Trim RNA reads using trimmomatic

# Load modules 
module load bioinfo-tools
module load trimmomatic

# Path to sequence directory and output directories
SEQDIR="/home/lihu6475/1MB462-PIII/data/RNA_untrimmed"
OUTDIR="/home/lihu6475/1MB462-PIII/data/RNA_trimmed"

# Run trimmomatic on the two files. Include full path to input and output files. 
# Input files (2): paired end reads of untrimmed RNA. Output files (4): left and right, paired and unpaired trimmed reads.

java -jar /sw/apps/bioinfo/trimmomatic/0.36/milou/trimmomatic-0.36.jar PE -threads 5 -phred33 $SEQDIR/SRR4342137.1.fastq.gz $SEQDIR/SRR4342137.2.fastq.gz $OUTDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $OUTDIR/RNA_trim_37.left_unpaired.trimmed.fastq.gz $OUTDIR/RNA_trim_37.right_paired.trimmed.fastq.gz $OUTDIR/RNA_trim_37.right_unpaired.trimmed.fastq.gz ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.36/milou/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

java -jar /sw/apps/bioinfo/trimmomatic/0.36/milou/trimmomatic-0.36.jar PE -threads 5 -phred33 $SEQDIR/SRR4342139.1.fastq.gz $SEQDIR/SRR4342139.2.fastq.gz $OUTDIR/RNA_trim_39.left_paired.trimmed.fastq.gz $OUTDIR/RNA_trim_39.left_unpaired.trimmed.fastq.gz $OUTDIR/RNA_trim_39.right_paired.trimmed.fastq.gz $OUTDIR/RNA_trim_39.right_unpaired.trimmed.fastq.gz ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.36/milou/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
