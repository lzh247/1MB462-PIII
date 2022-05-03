#!/bin/bash -l
#SBATCH -A uppmax2022-2-5 -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -J diff_expression
#SBATCH -t 10:00:00
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
cd $SEQDIR
for n in D1/*;
for m in 1 2 3 4 5 6 7 8 9 10 11 12;
do
    sed '/##FASTA/,$d' D1/${n}/D1_metabat_output_${m}.fa_ann.out.gff > $OUTDIR/htseq_${m}.gff
    htseq-count -f bam -t CDS -i ID -s no $BAMDIR/D1_sorted.bam $OUTDIR/htseq_${m}.gff > $OUTDIR/htseq_${m}_D1.counts
    htseq-count -f bam -t CDS -i ID -s no $BAMDIR/D3_sorted.bam $OUTDIR/htseq_${m}.gff > $OUTDIR/htseq_${m}_D3.counts
done
