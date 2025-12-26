#!/bin/bash

#mkdir -p assembly_unicycler
#for r1 in ONT_ILLUMINA/*1.fq.gz; do
    #samplename=$(basename "$r1"_1.fq.gz)
    #r2="ONT_ILLUMINA/$(samplename)_2.fq.gz"
    #longreads="ONT_ILLUMINA/${samplename}_minion.fq.gz"
    #outdir="assembly_unicycler/${samplename}_unicycler"

   # mkdir -p "outdir"
   # echo "running unicycler for $samplename..."
   # unicycler -1 "$r1" -2 "$r2" -l "$longreads" -t 6 -o "$outdir" / > "$outdir/unicycler.log" 2>&1 || echo "unicycler failed for $samplename"
#done
#!/bin/bash

INDIR="/DATASETS/ONT_ILLUMINA"
OUTDIR="/home1/amr31/assembly_unicycler"

mkdir -p "$OUTDIR"

for r1 in $INDIR/*1.fq.gz; do
    # remove directory and suffix "_1.fq.gz"
    filename=$(basename "$r1")
    samplename="${filename%_1.fq.gz}"

    r2="$INDIR/${samplename}_2.fq.gz"
    longreads="$INDIR/${samplename}_minion.fq.gz"
    sample_out="$OUTDIR/${samplename}_unicycler"

    mkdir -p "$sample_out"

    echo "Running Unicycler for $samplename..."

    unicycler \
        -1 "$r1" \
        -2 "$r2" \
        -l "$longreads" \
        -t 6 \
        -o "$sample_out" \
        > "$sample_out/unicycler.log" 2>&1 || echo "Unicycler failed for $samplename"
done

