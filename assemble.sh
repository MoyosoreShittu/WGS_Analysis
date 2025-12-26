
 #!/bin/bash

homedir="/home1/amr31/AMR_FASTQ/trimmed"  #set the path to trim data

cd $homedir #navigate into the trim directory
for R1 in *_1.trimmed.fastq.gz;   #set all forward
do
    samp=$(basename $R1_1.trimmed.fastq.gz) #pick
    R2=${samp}_2.trimmed.fastq.gz  #set R2 to all reverse reads
    spades.py --careful -t 16 -1 $R1 -2 $R2 -o $samp

done

