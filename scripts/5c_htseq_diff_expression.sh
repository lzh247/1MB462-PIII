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
module load htseq samtools 

# Sequence directories
SEQDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/4_DNA_annotation/functional_eggnoggmapper"
OUTDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA/htseq_out"
BAMDIR="/proj/genomeanalysis2022/nobackup/work/lihu6475/5_mapping_RNA"
: '
# Index bam files
cd $BAMDIR
for bam in *.bam
do
echo $bam
samtools index $bam
done 

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
htseq-count -f bam -t CDS -r pos -i ID $BAMDIR/D3_normalized.${bin}.fa_sorted.bam $SEQDIR/D3/$gff > $OUTDIR/D3_htseq_${bin}.counts
done

# Sort the counts
cd $OUTDIR
for counts in D1_htseq*.counts
do
echo $counts
grep -v "__" $counts | sort -k2rn > $OUTDIR/expression/${counts}
done

# Sort the counts
cd $OUTDIR
for counts in D3_htseq*.counts
do
echo $counts
grep -v "__" $counts | sort -k2rn > $OUTDIR/expression/${counts}
done
'
# Count the number of expressed genes and % expressed genes
cd $SEQDIR/D1
for gff in *.gff
do
echo $gff
input=$gff
echo $input
noexp=0
exp=0
cat $input |while IFS= read -r line;
do
value=$(echo $line | cut -d ' ' -f2)
if [ $value -eq 0 ]; then
noexp=$[$noexp+1]
else
exp=$[$exp+1]
fi
echo "$exp $noexp" > "out.txt"
done

cd $SEQDIR
exp=$(cut -d ' ' -f1 out.txt)
noexp=$(cut -d ' ' -f2 out.txt)
total=$(($exp+$noexp))
totalexp=$(($exp*100/$total))
echo "Bin $gff Expressed genes $exp and % expressed genes $totalexp \n" >> D1expressed.out
done

cd $SEQDIR/D3
for gff in *.gff
do
echo $gff
input=$gff
echo $input
noexp=0
exp=0
cat $input |while IFS= read -r line;
do
value=$(echo $line | cut -d ' ' -f2)
if [ $value -eq 0 ]; then
noexp=$[$noexp+1]
else
exp=$[$exp+1]
fi
echo "$exp $noexp" > "out.txt"
done

cd $SEQDIR
exp=$(cut -d ' ' -f1 out.txt)
noexp=$(cut -d ' ' -f2 out.txt)
total=$(($exp+$noexp))
totalexp=$(($exp*100/$total))
echo "Bin $gff Expressed genes $exp and % expressed genes $totalexp \n" >> D3expressed.out
done
