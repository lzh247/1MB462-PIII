#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 00:15:00 # LOOK HERE -SHORT
#SBATCH -J checkm
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Bin evaluation with ChheckM script 

# Load modules
module load bioinfo-tools 
module load CheckM

# Sequence directories 
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth/metabat_output"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3_binning_evaluation_with_depth/checkm_output"

# Move to wanted working directory.
cd $OUTDIR 

# Download the CheckM data to current directory. As of April 2022, the most recent version is 2015.01.16.
cp -av $CHECKM_DATA/2015_01_16/* .
checkm data setRoot $PWD

# Run the analyses with combined workflow: lineage_wf. Then follow up with analyze and qa to create ...
checkm lineage_wf -t 4 -x fa --reduced_tree $SEQDIR/D1/ $OUTDIR/D1_checkm
checkm lineage_wf -t 4 -x fa --reduced_tree $SEQDIR/D3/ $OUTDIR/D3_checkm

checkm analyze -t 4 -x fa $OUTDIR/D1_checkm/lineage.ms $SEQDIR/D1/ $OUTDIR/D1_checkm/
checkm analyze -t 4 -x fa $OUTDIR/D3_checkm/lineage.ms $SEQDIR/D3/ $OUTDIR/D3_checkm/

checkm qa -t 4 -o 1 -f $OUTDIR/D1_checkm/qa.out $OUTDIR/D1_checkm/lineage.ms $OUTDIR/D1_checkm/
checkm qa -t 4 -o 1 -f $OUTDIR/D3_checkm/qa.out $OUTDIR/D3_checkm/lineage.ms $OUTDIR/D3_checkm/
