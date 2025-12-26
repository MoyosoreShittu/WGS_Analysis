#!/bin/bash

mkdir -p assembly_flye

# run flye
for fastq in MRSA_ONT_FILTERED/*_filtered.fastq.gz; do
    samplename=$(basename "$fastq" _filtered.fastq.gz)

	flye \
	  --nano-raw "$fastq" \
	  -g 2.8m \
	  -t 4 \
	  -o assembly_flye/"$samplename"
done
