# WGS Bacteria Analysis Pipeline

This repository contains scripts and a Nextflow workflow for performing **Whole Genome Sequencing (WGS) Antimicrobial Resistance (AMR) analysis**. it is designed to process raw illumina sequencing reads, perform quality assessment using FastQC, MultiQC, fastp/Trimmomatic, trim low-quality bases and adapter sequences, and produce high-quality reads ready for downstream analses.

## Pipeline Overview

The workflow performs:

- Quality control on raw sequencing reads
- Genome assembly
- AMR gene detection
- Post-processing and reporting

The pipeline is designed to handle multiple samples and can work with Illumina or Oxford Nanopore sequencing data.

## Repository Contents

- `amr_nextflow_pipeline/` : Nextflow workflow and configuration files  
- `*.sh` scripts : Auxiliary scripts for various steps in the pipeline, including:
  - **assembly.sh** : Controls genome assembly using tools like SPAdes and Flye
  - **flye.sh** : Runs Flye assembler specifically for long-read assemblies
  - **spade.sh / spades.sh /** : Runs SPAdes assembler for short-read assemblies
  - **unicycler.sh / ONTunicycler.sh** : Hybrid assembly using Unicycler
  - **genome_qc.sh / quast.sh** : Performs assembly quality control with QUAST
  - **is_finder.sh** : Identifies insertion sequences in assembled genomes
  - **intergron.sh / abricate_interon.sh** : Detects integrons and antimicrobial resistance genes using ABRicate and integron detection
  - **trimmed.sh** : Performs read trimming and quality control using fastp or Trimmomatic
- `.gitignore` : Ignores runtime and temporary files  

## Requirements

- [Nextflow](https://www.nextflow.io/)  
- Linux environment recommended  
- Conda or Docker for managing dependencies  

## How to Run

From the `amr_nextflow_pipeline/` directory:

```bash
./run_pipeline.sh
# or run directly using Nextflow
nextflow run amr_pipeline2.nf -c nextflow.config
