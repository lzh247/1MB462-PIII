#!/bin/bash -l
#SBATCH -A uppmax2022-2-5 -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -J diff_expression
#SBATCH -t 48:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Differential expression of RNA with htseq script 

# Load modules
module load bioinfo-tools
module load htseq

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA/htseq_out"
BAMDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA"

# Run htseq
cd $SEQDIR/D1/gff_collected
for gff in *.gff
do
echo $gff
intrm=$(echo $gff | cut -f3 -d ".")
bin=$(echo $intrm | cut -f4 -d "_")
echo $bin
cd $OUTDIR
cd $bin
htseq-count -f bam -t CDS -r pos -i ID *.bam $SEQDIR/D1/gff_collected/$gff > $OUTDIR/D1_htseq_${bin}.counts

cd $SEQDIR/D3/gff_collected
for gff in *.gff
do
echo $gff
intrm=$(echo $gff | cut -f3 -d ".")
bin=$(echo $intrm | cut -f4 -d "_")
echo $bin
cd $OUTDIR
cd $bin
htseq-count -f bam -t CDS -r pos -i ID *.bam $SEQDIR/D1/gff_collected/$gff > $OUTDIR/D1_htseq_${bin}.counts
