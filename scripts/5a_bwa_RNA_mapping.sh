#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J bwa_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Mapping RNA with bwa, from DNA bins script 

# Load modules 
module load bioinfo-tools 
module load bwa samtools

# Sequence directories
BINDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth/metabat_output"
SEQDIR="/home/lihu6475/1MB462-PIII/data/RNA_trimmed"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA"

# D1
cd $BINDIR/D1
for fa in D1_normalized.*.fa
do
cp $BINDIR/D1/${fa} $OUTDIR/${fa} 
bwa index $OUTDIR/${fa} 2> $OUTDIR/${fa}_index.out
cd $OUTDIR
bwa mem $OUTDIR/${fa} $SEQDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2> $OUTDIR/${fa}_mem.out | samtools sort -o $OUTDIR/${fa}_sorted.bam
done 

# D3
cd $BINDIR/D3
for fa in D3_normalized.*.fa
do
cp $BINDIR/D3/${fa} $OUTDIR/${fa} 
bwa index $OUTDIR/${fa} 2> $OUTDIR/${fa}_index.out
cd $OUTDIR
bwa mem $OUTDIR/${fa} $SEQDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2> $OUTDIR/${fa}_mem.out | samtools sort -o $OUTDIR/${fa}_sorted.bam
done 
