#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J checkm
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Bin evaluation with ChheckM script 

# Load modules
module load bioinfo-tools 
module load CheckM

# Sequence directories 
SEQDIR="/home/lihu6475/1MB462-PIII/analyses/3_assembly_evaluation"
OUTDIR=$SEQDIR/checkm_output

# Move to wanted working directory.
cd $OUTDIR 

# Download the CheckM data to current directory. As of April 2022, the most recent version is 2015.01.16.
cp -av $HOME/data/CheckM_data/2015_01_16/* .
checkm data setRoot $PWD

# Run the analyses with combined workflow: lineage_wf. 
checkm lineage_wf -t 4 -x fa --reduced_tree $SEQDIR/D1_metabat_output/* $OUTDIR/D1_checkm
checkm lineage_wf -t 4 -x fa --reduced_tree $SEQDIR/D3_metabat_output/* $OUTDIR/D3_checkm
