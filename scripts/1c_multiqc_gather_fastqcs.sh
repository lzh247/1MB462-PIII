# Script to create a single HTML report from .fastqcs with MultiQC

# Load modules
module load bioinfo-tools
module load MultiQC

# Sequence directories
cd /home/lihu6475/1MB462-PIII/analyses/1_quality_control

# Run MultiQC on all .fastqc in directory
multiqc .
