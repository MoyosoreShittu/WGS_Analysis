#!/bin/bash

# Directory where reads are located
READS_DIR="/DATASETS/ILLIMINA_COLI"

# Directory where you have write permission
OUTPUT_DIR="$HOME/assemblies"

# Create output folder if it doesn't exist
mkdir -p $OUTPUT_DIR

# Loop over all R1 fastq files
for R1 in $READS_DIR/*_R1.fastq.gz; do
    # Get the sample name (remove path and _R1.fastq.gz)
    SAMPLE=$(basename $R1 _R1.fastq.gz)
    R2="$READS_DIR/${SAMPLE}_R2.fastq.gz"
    
    # Run SPAdes for this sample
    spades.py --careful -1 $R1 -2 $R2 -t 6 -o $OUTPUT_DIR/${SAMPLE}_spades
done

