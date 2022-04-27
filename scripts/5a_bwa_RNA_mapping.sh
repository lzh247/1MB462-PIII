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
module load bioinfo-tools bwa samtools

# Sequence directories
BINDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth/metabat_output"
SEQDIR="/home/lihu6475/1MB462-PIII/data/RNA_trimmed"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/4_DNA_annotation/structural_prokka"

# Combine all .fa bin files into one aggregated file. See article. 
# D1
for bin in $BINDIR/D1/*.fa; do name=`echo $bin | awk 'BEGIN{FS="."}{print $1$2}'`; echo ">"$name >> $OUTDIR/D1_bins_concat.fa; grep -v '>' $bin >> $OUTDIR/D1_bins_concat.fa; done

# D3
for bin in $BINDIR/D3/*.fa;
do name=`echo $bin | awk 'BEGIN{FS="."}{print $1$2}'`; echo ">"$name >> $OUTDIR/D3_bins_concat.fa; grep -v '>' $bin >> $OUTDIR/D3_bins_concat.fa; done

# Create reference index prior to bwa index
bwa index $OUTDIR/D1_bins_concat.fa 2> $OUTDIR/D1_index.out
bwa index $OUTDIR/D3_bins_concat.fa 2> $OUTDIR/D3_index.out

# Run bwa mem for alignment
bwa mem $OUTDIR/D1_bins_concat.fa $SEQDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2> $OUTDIR/D1_mem.out | samtools sort -o $OUTDIR/D1_sorted.bam
bwa mem $OUTDIR/D3_bins_concat.fa $SEQDIR/RNA_trim_39.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_39.right_paired.trimmed.fastq.gz 2> $OUTDIR/D3_mem.out | samtools sort -o $OUTDIR/D3_sorted.bam
