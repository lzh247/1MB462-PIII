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
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/functional_eggnoggmapper"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA/htseq_out"
BAMDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA"

# Run htseq
cd $SEQDIR/D1
for gff in *.gff
do
echo $gff
bin=$(echo $gff | cut -f2 -d ".")
echo $bin
cd $OUTDIR/D1
mkdir $bin
cd $bin
htseq-count -f bam -t CDS -r pos -i ID $BAMDIR/D1_normalized.${bin}.fa_sorted.bam $SEQDIR/D1/$gff > $OUTDIR/D1_htseq_${bin}.counts
done

cd $SEQDIR/D3
for gff in *.gff
do
echo $gff
bin=$(echo $gff | cut -f2 -d ".")
echo $bin
cd $OUTDIR/D3
mkdir $bin
cd $bin
htseq-count -f bam -t CDS -r pos -i ID $BAMDIR/D3_normalized.${bin}.fa_sorted.bam $SEQDIR/D1/$gff > $OUTDIR/D3_htseq_${bin}.counts
done
