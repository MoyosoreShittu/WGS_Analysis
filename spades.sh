#!/bin/bash

homedir="/DATASETS/ILLIMINA_COLI"  # set the path to trimmed data
cd "$homedir"  # navigate into the trim directory

for R1 in *_R1.fastq.gz; do       # loop over all forward reads
    samp=$(basename "$R1" "_R1.fastq.gz")  # extract sample name
    R2="${samp}_R2.fastq.gz"               # corresponding reverse read
    spades.py --careful -t 16 -1 "$R1" -2 "$R2" -o "${samp}_spades"
done
