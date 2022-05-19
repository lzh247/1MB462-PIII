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

GENDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"
GENOUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5b_bwa_genes"

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


# On gene data 
#sample D1
cd $GENDIR/D1/
for bin in *.out
do
cd $bin
for file in *.ffn
bwa index $file 
bwa mem -t 10 $file $SEQDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2>$GENOUTDIR/D1/${file}.sam | samtools sort -o $GENOUTDIR/D1/${file}_sorted.bam
done
#sample D3
cd $GENDIR/D3/
for bin in *.out
do
cd $bin
for file in *.ffn
bwa index $file 
bwa mem -t 10 $file $SEQDIR/RNA_trim_37.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_37.right_paired.trimmed.fastq.gz 2>$GENOUTDIR/D3/${file}.sam | samtools sort -o $GENOUTDIR/D3/${file}_sorted.bam
done
#sample D1
cd $GENDIR/D1/
for bin in *.out
do
for file in $GENDIR/D1/$bin/*.ffn
do
basename_file=$(basename -s .ffn $file)
bwa index $file
bwa mem -t 10 $file $SEQDIR/RNA_trim_39.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_39.right_paired.trimmed.fastq.gz 2>$GENOUTDIR/D1/${basename_file}.sam | samtools sort -o $GENOUTDIR/D1/${basename_file}_sorted.bam
done
done
#sample D3
cd $GENDIR/D3/
for bin in *.out
do
for file in $GENDIR/D3/$bin/*.ffn
do
basename_file=$(basename -s .ffn $file)
bwa index $file
bwa mem -t 10 $file $SEQDIR/RNA_trim_39.left_paired.trimmed.fastq.gz $SEQDIR/RNA_trim_39.right_paired.trimmed.fastq.gz 2>$GENOUTDIR/D3/${basename_file}.sam | samtools sort -o $GENOUTDIR/D3/${basename_file}_sorted.bam
done
done

cd $GENOUTDIR/D1
for bam in D1_normalized.*.fa_ann.out_sorted.bam
do 
samtools stats $bam | grep ^SN | cut -f 2- > $GENOUTDIR/D1/${bam}_summary  
done

cd $GENOUTDIR/D3
for bam in D3_normalized.*.fa_ann.out_sorted.bam
do 
samtools stats $bam | grep ^SN | cut -f 2- > $GENOUTDIR/D3/${bam}_summary  
done
