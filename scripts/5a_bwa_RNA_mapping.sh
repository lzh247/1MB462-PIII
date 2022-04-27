#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J bwa_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Mapping RNA with bwa script 

# Load modules 
module load bioinfo-tools bwa samtools

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth"
OUTDIR="/home/lihu6475/1MB462-PIII/analyses/4_DNA_annotation/structural_prokka"

# Combine all .fa bin files into one aggregated file. See article. 
# D1
for bin in $SEQDIR/*.fa;
do
name=`echo $bin | awk 'BEGIN{FS="."}{print $1$3}'`; echo ">"$name >> $OUTDIR/D1_bins_concat.fa; grep -v '>' $bin >> $OUTDIR/D1_bins_concat.fa; 
done
