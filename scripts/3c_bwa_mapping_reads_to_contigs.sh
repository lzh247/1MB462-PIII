#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 06:00:00
#SBATCH -J DNA_bwa
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Mapping DNA reads to Megahit assembly contigs with BWA script 

# Load modules
module load bioinfo-tools
module load bwa samtools MetaBat

# Sequence directories 
READDIR="/home/lihu6475/1MB462-PIII/data/DNA_trimmed"
CONTIGDIR="/home/lihu6475/1MB462-PIII/analyses/2_assembly_evaluation"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth"

# Run BWA on D1
bwa index $CONTIGDIR/D1_megahit_output/final.contigs.fa 2> $OUTDIR/D1/D1_index.out
bwa mem $CONTIGDIR/D1_megahit_output/final.contigs.fa $READDIR/SRR4342129_1.paired.trimmed.fastq.gz $READDIR/SRR4342129_2.paired.trimmed.fastq.gz 2> $OUTDIR/D1/D1.bam.bwa.log | samtools sort -o $OUTDIR/D1/D1.sorted.bam

# Create depth file
jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/D1/D1_depth.txt $OUTDIR/D1/*.bam #LOOK AT THIS - move to next script?

# Run BWA on D3
bwa index $CONTIGDIR/D3_megahit_output/final.contigs.fa 2> $OUTDIR/D3/D3_index.out
bwa mem $CONTIGDIR/D3_megahit_output/final.contigs.fa $READDIR/SRR4342133_1.paired.trimmed.fastq.gz $READDIR/SRR4342133_2.paired.trimmed.fastq.gz 2> $OUTDIR/D3/D3.bam.bwa.log | samtools sort -o $OUTDIR/D3/D3.sorted.bam

# Create depth file
jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/D3/D3_depth.txt $OUTDIR/D3/*.bam
