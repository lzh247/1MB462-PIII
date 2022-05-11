#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J metaphlan_profiling
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Profiling of composition of microbial communities with Metaphlan script

# NOT WORKING, CANNOT LOAD METAPHLAN

# Load modules 
module load bioinfo-tools
module load MetaPhlAn3/3.0.8
module load BioBakery
#module load python 
#module load biopython FastTree muscle usearch

dbdir=$SNIC_TMP/db
mkdir $metadir 

metaphlan --install --bowtie2db $metadir

# Path to sequence directory and output directories
SEQDIR="/home/lihu6475/1MB462-PIII/data/DNA_trimmed"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/6_extra_analyses/metaphlan"

# Run MetaPhlAn
#metaphlan $SEQDIR/SRR4342129_1.paired.trimmed.fastq.gz,$SEQDIR/SRR4342129_2.paired.trimmed.fastq.gz --bowtie2db $metadir --bowtie2out $OUTDIR/bt2out.txt --input_type fastq --nproc 2 --input_type fastq --add_viruses -o $OUTDIR/metagenome_profile.txt
metaphlan $SEQDIR/SRR4342129_1.paired.trimmed.fastq.gz,$SEQDIR/SRR4342129_2.paired.trimmed.fastq.gz --bowtie2out $OUTDIR/bt2out.txt --input_type fastq --nproc 2 --input_type fastq --add_viruses -o $OUTDIR/metagenome_profile.txt
