#!/bin/bash -l
#SBATCH -A uppmax2022-2-5 -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -J phylogenetic
#SBATCH -t 50:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user linn.zetterberg-huser.6475@student.uu.se

# Phylogenetic reconstruction script, based on bins. 

# Load modules
module load bioinfo-tools 
module load phylophlan/0.99 python/2.7.15 biopython/1.73 FastTree muscle/3.8.31 usearch/5.2.32

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/structural_prokka"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/3b_phylo_reconstruct"

# Copy installed phylophlan files into working directory. 
#cp -r /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/* $OUTDIR/

# Symlink the phylophlan data files
cd  $OUTDIR/
#mkdir data
cd data
#mkdir -p ppaalns
#ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/*.bz2 .
#ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/ppaalns/*.bz2 ppaalns/
#ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/data/ppafull.tax.txt .
ln -sf /sw/apps/bioinfo/phylophlan/0.99/rackham/bin/taxcuration/ /proj/genomeanalysis2022/nobackup/work/lihu6475/3b_phylo_reconstruct/taxcuration

# The input .fa files will be the Prokka output, as these include amino acid sequence and not only nucleotide, in contrast to the binning output. 
# Further, the file names have to be given new names.
#cd $SEQDIR/D1
#for bins in *ann.out
#do
#echo $bins
#for files in $bins/*
#do
#echo $files
#mv "$files" "${files/PROKKA_05162022/$bins}"
#done
#done

#cd $SEQDIR/D3
#for bins in *ann.out
#do
#echo $bins
#for files in $bins/*
#do
#echo $files
#mv "$files" "${files/PROKKA_05162022/$bins}"
#done
#done

# Soft link the input data to phylophlans input directory
#ln -s $SEQDIR/D1/*ann.out/*.faa $OUTDIR/input/D1/
#ln -s $SEQDIR/D3/*ann.out/*.faa $OUTDIR/input/D3/

# Run pylophlan 
cd $OUTDIR
phylophlan.py -i D1 -t --nproc 2 2> D1_phylo.err
phylophlan.py -i D3 -t --nproc 2 2> D3_phylo.err
