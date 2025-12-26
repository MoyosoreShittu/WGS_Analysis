#!/bin/bash

indir="/home1/amr31/SPAdes_results"
outdir="/home1/amr31/IS_results"
mkdir -p "$outdir"

for samp in S1_spades S2_spades S3_spades S4_spades S5_spades S6_spades S7_spades S8_spades S9_spades S10_spades; do

    echo "Searching insertion sequences for $samp..."
    contigs="${indir}/${samp}/contigs.fasta"
    abricate --db isfinder "$contigs" > "${outdir}/${samp}_IS.tab"

done

