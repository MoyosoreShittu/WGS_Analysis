#!/bin/bash

homedir="/home1/amr31/AMR_FASTQ/trimmed"  # set the path to trimmed data
cd "$homedir"  # navigate into the trim directory

for R1 in *_R1_trimmed.fastq.gz; do       # loop over all forward reads
    samp=$(basename "$R1" "_R1_trimmed.fastq.gz")  # extract sample name
    R2="${samp}_R2_trimmed.fastq.gz"               # corresponding reverse read
    spades.py --careful -t 16 -1 "$R1" -2 "$R2" -o "${samp}_spades"
done

