nextflow.enable.dsl = 2

// Parameters
params.outdir = "results"
params.threads = 32
params.reads = "/home2/ssyamoako/AMR_FASTQ/Data/*_{R1,R2}.fastq.gz"

// Channel for input reads
Channel
    .fromFilePairs(params.reads, size: 2)
    .set { read_pairs }

// Process 1: FASTP trimming
process fastp_trimming {
    tag "${sample}"
    publishDir "${params.outdir}/01_Trim", mode: 'copy', 
        pattern: "*.{html,json}",
        saveAs: { filename -> "qc_reports/$filename" }
    
    input:
    tuple val(sample), path(reads)
    
    output:
    tuple val(sample), path("*_R{1,2}.trimmed.fastq.gz"), emit: trimmed_reads
    path "*.{html,json}", emit: qc_reports
    
    cpus params.threads
    memory '8 GB'
    time '1h'
    
    script:
    def (r1, r2) = reads
    """
    fastp \
        --in1 $r1 \
        --in2 $r2 \
        --cut_front \
        --cut_tail \
        -W 4 -M 20 -l 30 \
        --out1 ${sample}_R1.trimmed.fastq.gz \
        --out2 ${sample}_R2.trimmed.fastq.gz \
        --html ${sample}.html \
        --json ${sample}.json \
        --thread ${task.cpus} \
        --detect_adapter_for_pe \
        --correction
    """
}

// Process 2: SPAdes assembly
process spades_assembly {
    tag "${sample}"
    publishDir "${params.outdir}/02_Assembly/${sample}", mode: 'copy',
        pattern: '*'
    
    input:
    tuple val(sample), path(reads)
    
    output:
    tuple val(sample), path("contigs.fasta"), emit: contigs
    path("*"), emit: assembly_files
    
    cpus params.threads
    memory '64 GB'
    time '12h'
    
    script:
    def (r1, r2) = reads
    """
    spades.py --careful -t ${task.cpus} \
        -1 $r1 \
        -2 $r2 \
        -o .
    """
}

// Process 3: Copy and rename contigs
process copy_contigs {
    tag "${sample}"
    publishDir "${params.outdir}/03_Contigs", mode: 'copy',
        pattern: '*.fasta'
    
    input:
    tuple val(sample), path(contigs)
    
    output:
    tuple val(sample), path("${sample}.fasta"), emit: renamed_contigs
    path("*.fasta"), emit: contigs_list
    
    cpus 1
    memory '1 GB'
    time '5m'
    
    script:
    """
    cp $contigs ${sample}.fasta
    """
}

// Process 4: QUAST analysis
process quast_analysis {
    tag "QUAST"
    publishDir "${params.outdir}/04_Quast", mode: 'copy'
    
    input:
    path contigs
    
    output:
    path("*"), emit: quast_results
    
    cpus 4
    memory '16 GB'
    time '2h'
    
    script:
    """
    quast.py -o . \$contigs
    """
}

// Process 5: staramr analysis
process staramr_analysis {
    tag "staramr"
    publishDir "${params.outdir}/05_Staramr", mode: 'copy'
    
    input:
    path contigs
    
    output:
    path("*"), emit: amr_results
    
    cpus 4
    memory '8 GB'
    time '1h'
    
    script:
    """
    staramr search \$contigs -o .
    """
}

// Workflow definition
workflow {
    // Print pipeline information
    println "AMR Analysis Pipeline"
    println "====================="
    println "Input directory: ${params.reads}"
    println "Output directory: ${params.outdir}"
    println "Threads: ${params.threads}"
    println ""
    
    // Main processing chain
    FASTP_OUT = fastp_trimming(read_pairs)
    SPADES_OUT = spades_assembly(FASTP_OUT.trimmed_reads)
    CONTIGS_OUT = copy_contigs(SPADES_OUT.contigs)
    
    // Collect all contig files
    all_contigs = CONTIGS_OUT.contigs_list.collect()
    
    // Run batch analyses
    QUAST_OUT = quast_analysis(all_contigs.flatten())
    STARAMR_OUT = staramr_analysis(all_contigs.flatten())
    
    // Print completion message
    QUAST_OUT.subscribe {
        println "Pipeline completed successfully!"
        println "Results available in: ${params.outdir}"
    }
}