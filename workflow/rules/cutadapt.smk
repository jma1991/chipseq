# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule cutadapt_single:
    input:
        fqz = "results/cutadapt/{sample}/{subsample}.fastq.gz"
    output:
        fqz = "results/cutadapt/{sample}/{subsample}.fastq.gz"
    params:
        ""
    log:
        "logs/cutadapt/{sample}"
    message:
        "[cutadapt]"
    threads:
        16
    shell:
        "cutadapt {params} -j {threads} -o {output.fqz} {input.fqz} > {log}"

rule cutadapt_paired:
    input:
        fq1 = "results/cutadapt/{sample}/{subsample}_1.fastq.gz",
        fq2 = "results/cutadapt/{sample}/{subsample}_2.fastq.gz"
    output:
        fq1 = "results/cutadapt/{sample}/{subsample}_1.fastq.gz",
        fq2 = "results/cutadapt/{sample}/{subsample}_2.fastq.gz"
    params:
        ""
    log:
        "logs/cutadapt/{sample}"
    message:
        "[cutadapt]"
    threads:
        16
    shell:
        "cutadapt {params} -j {threads} -o {output.fq1} -p {output.fq2} {input.fq1} {input.fq2} > {log}"