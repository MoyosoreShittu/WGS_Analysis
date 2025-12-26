#!/bin/bash
# Optional wrapper script to run the pipeline

set -e  # Exit on error

# Create necessary directories
mkdir -p results/{01_Trim,02_Assembly,03_Contigs,04_Quast,05_Staramr}

# Run the pipeline
nextflow run amr_pipeline.nf \
    -with-report execution_report.html \
    -with-timeline timeline.html \
    -with-trace trace.txt \
    -resume