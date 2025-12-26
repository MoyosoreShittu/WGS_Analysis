#!/bin/bash
#this code is correct oo you just hav to work on the location
# Path to your SPAdes assemblies
#assembly_dir="/DATASETS/ILLIMINA_COLI"
#output_dir="/home1/amr31/genome_analysis_results"

#mkdir -p "$output_dir/abricate"
#mkdir -p "$output_dir/integron"

#for asm in "$assembly_dir"/*_spades/contigs.fasta; do
 #   samp=$(basename $(dirname "$asm"))   # get sample name (directory name)

  #  echo "Running ABRicate for $samp..."
   # abricate --db resfinder "$asm" > "$output_dir/abricate/${samp}_resfinder.tab"

    #echo "Running IntegronFinder for $samp..."
    #Integron_Finder.py "$asm" -o "$output_dir/integron/${samp}_integron"
#done

#echo "All ABRicate and IntegronFinder analyses completed!"



#!/bin/bash

# ===========================
# ABRicate & IntegronFinder pipeline for SPAdes assemblies
# ===========================

# Path to your SPAdes assemblies
assembly_dir="/home1/amr31/SPAdes_results"

# Output directory for all results
output_dir="/home1/amr31/abricate_integron_result"

# Create the output directory
mkdir -p "$output_dir/abricate"
mkdir -p "$output_dir/integron"

# Loop over each assembly contigs file
for asm in "$assembly_dir"/*_spades/contigs.fasta; do
    # Extract sample name from folder
    samp=$(basename $(dirname "$asm"))

    echo "=========================================="
    echo "Running ABRicate for sample: $samp"
    echo "=========================================="

    # Run ABRicate with the ResFinder database
    abricate --db resfinder "$asm" > "$output_dir/abricate/${samp}_resfinder.tab"

    echo "ABRicate done for $samp!"
    echo ""

    echo "=========================================="
    echo "Running IntegronFinder for sample: $samp"
    echo "=========================================="

    # Run IntegronFinder
    Integron_Finder.py "$asm" -o "$output_dir/integron/${samp}_integron"

    echo "IntegronFinder done for $samp!"
    echo ""
done

echo "All ABRicate and IntegronFinder analyses completed!"
echo "Results saved in $output_dir"

