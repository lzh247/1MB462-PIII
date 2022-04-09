#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J bwa
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Mapping DNA reads to Megahit assembly contigs with BWA script 

# Load modules
module load bioinfo-tools
module load bwa samtools 

# Sequence directories 
READDIR="/home/lihu6475/1MB462-PIII/data/DNA_trimmed"
CONTIGDIR="/home/lihu6475/1MB462-PIII/analyses/2_assembly_evaluation"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/3_binning_evaluation/binning_with_depth"

# Run BWA on D1
bwa index $CONTIGDIR/D1_megahit_output/final.contigs.fa 2>$OUTDIR/D1_index.out
#bwa mem -t 12 $CONTIGDIR/D1_megahit_output/final.contigs.fa $READDIR/SRR4342129_1.paired.trimmed.fastq.gz $READDIR/SRR4342129_2.paired.trimmed.fastq.gz > $OUTDIR/D1_DNA_supercontig.sam 2>$OUTDIR/D1_DNA_bwamem.out
bwa mem -t 12 $CONTIGDIR/D1_megahit_output/final.contigs.fa $READDIR/SRR4342129_1.paired.trimmed.fastq.gz $READDIR/SRR4342129_2.paired.trimmed.fastq.gz 2> $OUTDIR/D1.bam.bwa.log | samtools view -b | samtools sort -o $OUTDIR/D1.sorted.bam -O BAM
samtools index $OUTDIR/D1.sorted.bam
#samtools view -S -b -h $OUTDIR/D1_DNA_supercontig.sam > $OUTDIR/D1_DNA_supercontig.bam

# Run BWA on D3
bwa index $CONTIGDIR/D3_megahit_output/final.contigs.fa 2>$OUTDIR/D3_index.out
#bwa mem -t 2 -h $CONTIGDIR/D3_megahit_output/final.contigs.fa $READDIR/SRR4342133_1.paired.trimmed.fastq.gz $READDIR/SRR4342133_2.paired.trimmed.fastq.gz > $OUTDIR/D3_DNA_supercontig.sam 2>$OUTDIR/D3_DNA_bwamem.out
bwa mem -t 12 $CONTIGDIR/D3_megahit_output/final.contigs.fa $READDIR/SRR4342133_1.paired.trimmed.fastq.gz $READDIR/SRR
samtools index $OUTDIR/D1.sorted.bam
#samtools view -S -b -h  $OUTDIR/D3_DNA_supercontig.sam > $OUTDIR/D3_DNA_supercontig.bam
