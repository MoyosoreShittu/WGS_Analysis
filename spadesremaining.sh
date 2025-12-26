#!/bin/bash

homedir="/DATASETS/ILLIMINA_COLI"            # input FASTQ files
outbase="/home1/amr31/SPAdes_results"        # SPAdes results folder

mkdir -p "$outbase"
cd "$homedir" || { echo "Input directory not found"; exit 1; }

for R1 in *_R1.fastq.gz; do
    samp=$(basename "$R1" "_R1.fastq.gz")
    R2="${samp}_R2.fastq.gz"
    outdir="${outbase}/${samp}_spades"

    # Skip sample if output already exists
    if [ -d "$outdir" ]; then
        echo "Skipping $samp (already assembled)."
        continue
    fi

    echo "Running SPAdes for $samp..."
    spades.py --careful -t 16 -1 "$R1" -2 "$R2" -o "$outdir"
done

