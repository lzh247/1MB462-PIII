#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J bwa_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se


# SOmething

# Load modules
module load bioinfo-tools
module load bwa samtools

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"
RAWDIR="/home/lihu6475/1MB462-PIII/data/RNA_trimmed"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5b_bwa_genes"

#sample D1
cd $SEQDIR/D1/
for bin in *.out
do
cd $bin
for file in *.ffn
bwa index $file 
bwa mem -t 10 $file $RAWDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $RAWDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2>$OUTDIR/D1/${file}.sam | samtools sort -o $OUTDIR/D1/${file}_sorted.bam
done

#sample D3
cd $SEQDIR/D3/
for bin in *.out
do
cd $bin
for file in *.ffn
bwa index $file 
bwa mem -t 10 $file $RAWDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $RAWDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2>$OUTDIR/D3/${file}.sam | samtools sort -o $OUTDIR/D3/${file}_sorted.bam
done
