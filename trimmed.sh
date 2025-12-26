#!/bin/bash

# ------------------------------
# USER INPUT
# ------------------------------
RAW_DIR=~/AMR_FASTQ             # folder with raw FASTQ
TRIM_DIR=~/AMR_FASTQ/trimmed    # folder for trimmed output
THREADS=4
# ------------------------------

mkdir -p $TRIM_DIR

# Loop through all R1 files
for R1 in $RAW_DIR/*_R1.fastq.gz
do
    SAMPLE=$(basename $R1 "_R1.fastq.gz")
    R2="$RAW_DIR/${SAMPLE}_R2.fastq.gz"

    echo "Processing sample $SAMPLE ..."

    fastp \
    -i $R1 \
    -I $R2 \
    -o $TRIM_DIR/${SAMPLE}_R1_trimmed.fastq.gz \
    -O $TRIM_DIR/${SAMPLE}_R2_trimmed.fastq.gz \
    -h $TRIM_DIR/${SAMPLE}_fastp_report.html \
    -j $TRIM_DIR/${SAMPLE}_fastp_report.json \
    --detect_adapter_for_pe \
    --thread $THREADS
done

echo "All samples processed!"

