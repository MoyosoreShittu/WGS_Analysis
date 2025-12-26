#!/bin/bash

# -------------------------------
# Bash script to run genome QC
# -------------------------------

# Set paths
ASSEMBLY="assembly_flye/DRR187567/assembly.fasta"
OUTDIR="$HOME/genome_analysis_results"

# Create main output directory
mkdir -p "$OUTDIR"

# --------------------------------
# 1. Run QUAST
# --------------------------------
QUAST_OUT="$OUTDIR/quast_results"
mkdir -p "$QUAST_OUT"

echo "Running QUAST..."
quast.py "$ASSEMBLY" -o "$QUAST_OUT" --threads 8
echo "QUAST completed. Results in $QUAST_OUT"

# --------------------------------
# 2. Run BUSCO
# --------------------------------
BUSCO_OUT="$OUTDIR/busco_results"
mkdir -p "$BUSCO_OUT"

echo "Running BUSCO..."
busco -i "$ASSEMBLY" -o "$BUSCO_OUT" -l bacteria_odb10 -m genome --cpu 8
echo "BUSCO completed. Results in $BUSCO_OUT"

# --------------------------------
# 3. Run Prokka
# --------------------------------
PROKKA_OUT="$OUTDIR/prokka_results"
mkdir -p "$PROKKA_OUT"

echo "Running Prokka annotation..."
prokka "$ASSEMBLY" --outdir "$PROKKA_OUT" --prefix DRR187567 --cpus 8
echo "Prokka annotation completed. Results in $PROKKA_OUT"

echo "All steps finished!"

