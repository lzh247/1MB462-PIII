#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J metabat
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Binning with depth file and Metabat script

# Load modules
module load bioinfo-tools
module load MetaBat

# Sequence directories 
CONTIGDIR="/home/lihu6475/1MB462-PIII/analyses/2_assembly_evaluation"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth"

# Run MetaBat with depth.txt on D1 and D3
jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/D1/depth.txt --pairedContigs $OUTDIR/D1/paired.txt $OUTDIR/D1/*.bam 
metabat -i $CONTIGDIR/D1_megahit_output/final.contigs.fa -a $OUTDIR/D1/depth.txt -p $OUTDIR/D1/paired.txt --specific -v --saveTNF $OUTDIR/D1/saved.tnf --saveDistance $OUTDIR/D1/saved.gprob -o $OUTDIR/metabat_output
/D1/D1_normalized

jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/D3/depth.txt --pairedContigs $OUTDIR/D3/paired.txt $OUTDIR/D3/*.bam
metabat -i $CONTIGDIR/D3_megahit_output/final.contigs.fa -a $OUTDIR/D3/depth.txt -p $OUTDIR/D3/paired.txt --specific -v --saveTNF $OUTDIR/D3/saved.tnf --saveDistance $OUTDIR/D3/saved.gprob -o $OUTDIR/metabat_output
/D3/D3_normalized
