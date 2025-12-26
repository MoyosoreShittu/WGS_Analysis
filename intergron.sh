
#!/bin/bash

indir="/home1/amr31/SPAdes_results"
outbase="/home1/amr31/abricate_integron_result/integron"
mkdir -p "$outbase"

integron_cmd="/software/integron_finder/integron_finder"

for samp in S1_spades S2_spades S3_spades S4_spades S5_spades S6_spades S7_spades S8_spades S9_spades S10_spades; do
    contigs="${indir}/${samp}/contigs.fasta"
    outdir_integron="${outbase}/${samp}_integron"

    echo "Running integronFinder for $samp ..."
    $integron_cmd --local-max --cpu 16 -o "$outdir_integron" "$contigs"
    echo "Done $samp"
done

