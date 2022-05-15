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

# Load modules 
module load bioinfo-tools
module load MetaPhlAn3/3.0.8 BioBakery

# Path to sequence directory and output directories
SEQDIR="/home/lihu6475/1MB462-PIII/data/DNA_trimmed"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/6_extra_analyses/metaphlan"

# Install MetaPhlAn
#metaphlan --install --bowtie2db $OUTDIR/install

# Run MetaPhlAn
metaphlan $SEQDIR/SRR4342129_1.paired.trimmed.fastq.gz,$SEQDIR/SRR4342129_2.paired.trimmed.fastq.gz --bowtie2db $OUTDIR/install --bowtie2out $OUTDIR/bt2out.txt --input_type fastq --nproc 2 --input_type fastq --add_viruses -o $OUTDIR/metagenome_profile.txt
metaphlan $SEQDIR/SRR4342133_1.paired.trimmed.fastq.gz,$SEQDIR/SRR4342133_2.paired.trimmed.fastq.gz --bowtie2db $OUTDIR/install --bowtie2out $OUTDIR/bt2out_D3.txt --input_type fastq --nproc 2 --input_type fastq --add_viruses -o $OUTDIR/metagenome_profile_D3.txt

#metaphlan $SEQDIR/SRR4342129_1.paired.trimmed.fastq.gz,$SEQDIR/SRR4342129_2.paired.trimmed.fastq.gz --bowtie2out $OUTDIR/bt2out.txt --input_type fastq --nproc 2 --input_type fastq --add_viruses -o $OUTDIR/metagenome_profile.txt
