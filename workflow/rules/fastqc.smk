# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule fastqc:
    input:
        fqz = lambda wildcards: pep.subsample_table.loc[]
    output:
        ext = multiext("results/fastqc/{sample}/{subsample}_fastqc", ".html", ".zip")
    params:
        out = lambda wildcards, output: os.path.dirname(output)
    log:
        "logs/fastqc/{sample}/{subsample}.log"
    message:
        "[fastqc]"
    threads:
        16
    shell:
        "fastqc -o {params.out} -t {threads} -q {input.fqz} > {log}"

rule fastqc:
    input:
        fqz = lambda wildcards: pep.subsample_table.loc[]
    output:
        ext = multiext("results/fastqc/{sample}/{subsample}_{read}_fastqc", ".html", ".zip")
    params:
        out = lambda wildcards, output: os.path.dirname(output)
    log:
        "logs/fastqc/{sample}/{subsample}_{read}.log"
    message:
        "[fastqc]"
    threads:
        16
    shell:
        "fastqc -o {params.out} -t {threads} -q {input.fqz} > {log}"

rule fastqc:
    input:
        fqz = "results/cutadapt/{sample}/{subsample}.fastq.gz"
    output:
        ext = multiext("results/fastqc/{sample}/{subsample}_fastqc", ".html", ".zip")
    params:
        out = lambda wildcards, output: os.path.dirname(output)
    log:
        "logs/fastqc/{sample}/{subsample}.log"
    message:
        "[fastqc]"
    threads:
        16
    shell:
        "fastqc -o {params.out} -t {threads} -q {input.fqz} > {log}"

rule fastqc:
    input:
        fqz = "results/cutadapt/{sample}/{subsample}_{read}.fastq.gz"
    output:
        ext = multiext("results/fastqc/{sample}/{subsample}_{read}_fastqc", ".html", ".zip")
    params:
        out = lambda wildcards, output: os.path.dirname(output)
    log:
        "logs/fastqc/{sample}/{subsample}_{read}.log"
    message:
        "[fastqc]"
    threads:
        16
    shell:
        "fastqc -o {params.out} -t {threads} -q {input.fqz} > {log}"
