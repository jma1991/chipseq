# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule bwa_index:
    input:
        "results/bwa/{genome}.fasta"
    output:
        "results/bwa/{genome}.amb",
        "results/bwa/{genome}.ann",
        "results/bwa/{genome}.bwt",
        "results/bwa/{genome}.pac",
        "results/bwa/{genome}.sa"
    params:
        ""
    log:
        "logs/bwa/{genome}.log"
    message:
        "[bwa]"
    threads:
        16
    shell:
        "bwa index"

rule bwa_mem:
    input:
        fq1 = "results/cutadapt/{sample}/{subsample}_1.fastq.gz",
        fq2 = "results/cutadapt/{sample}/{subsample}_2.fastq.gz"
    output:
        bam = "results/bwa/{sample}/{subsample}.bam"
    params:
        rgs = "-R '@RG\tID:{subsample}\tSM:{sample}'",
    log:
        "logs/bwa/{sample}.log"
    message:
        "[bwa]"
    threads:
        16
    shell:
        "bwa mem"