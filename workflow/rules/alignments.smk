rule alignments_raw_1:
    input:
        fqz = "data/reads/trimmed/{run}.fastq.gz"
    output:
        sam = "results/alignments/raw/{run}.sam"
    params:
        idx = "data/genomes/dm6/indexes/bowtie2/dm6"
    shell:
        "bowtie2 -x {params.idx} -U {input.fqz} -S {output.sam}"

rule alignments_raw_2:
    input:
        sam = "results/alignments/raw/{run}.sam"
    output:
        bam = "results/alignments/raw/{run}.bam"
    shell:
        "samtools sort -o {output.bam} {input.sam}"
        
rule alignments_merged:
    input:
        bam = lambda wildcards: expand("results/alignments/raw/{run}.bam", run = config["samples"][wildcards.sample])
    output:
        bam = "results/alignments/merged/{sample}.bam"
    shell:
        "samtools merge {output.bam} {input.bam}"
        
rule alignments_markdup_1:
    input:
        "results/alignments/merged/{sample}.bam"
    output:
        "results/alignments/markdup/{sample}.0001.bam"
    shell:
        "samtools sort -n -o {output} {input}"

rule alignments_markdup_2:
    input:
        "results/alignments/markdup/{sample}.0001.bam"
    output:
        "results/alignments/markdup/{sample}.0002.bam"
    shell:
        "samtools fixmate -m {input} {output}"

rule alignments_markdup_3:
    input:
        "results/alignments/markdup/{sample}.0002.bam"
    output:
        "results/alignments/markdup/{sample}.0003.bam"
    shell:
        "samtools sort -o {output} {input}"

rule alignments_markdup_4:
    input:
        "results/alignments/markdup/{sample}.0003.bam"
    output:
        "results/alignments/markdup/{sample}.bam"
    shell:
        "samtools markdup {input} {output}"

rule alignments_filtered_1:
    input:
        fai = "data/genomes/dm6/dm6.fa.fai"
    output:
        bed = "data/genomes/dm6/dm6.standard.bed.gz"
    shell:
        "bioawk -t '$1 !~ /(M|_)/ {{print $1,0,$2}}' {input.fai} | gzip > {output.bed}"

rule alignments_filtered_2:
    input:
        bam = "results/alignments/markdup/{sample}.bam",
        bed = "data/genomes/dm6/dm6.standard.bed.gz"
    output:
        bam = "results/alignments/filtered/{sample}.0001.bam"
    shell:
        "samtools view -b -L {input.bed} -q 30 -F 3844 {input.bam} > {output.bam}"

rule alignments_filtered_3:
    input:
        bam = "results/alignments/filtered/{sample}.0001.bam",
        bed = "data/genomes/dm6/dm6.blacklist.bed.gz",
        fai = "data/genomes/dm6/dm6.fa.fai"
    output:
        bam = "results/alignments/filtered/{sample}.0002.bam"
    shell:
        "bedtools intersect -v -g {input.fai} -sorted -a {input.bam} -b {input.bed}"

rule alignments_filtered_4:
    input:
        bam = "results/alignments/filtered/{sample}.0002.bam"
    output:
        bam = "results/alignments/filtered/{sample}.0003.bam"
    shell:
        "samtools sort -@ {threads} -n {input.bam} > {output.bam}"

rule alignments_filtered_5:
    input:
        bam = "results/alignments/filtered/{sample}.0003.bam"
    output:
        bam = "results/alignments/filtered/{sample}.0004.bam"
    shell:
        "samtools fixmate {input.bam} {output.bam}"

rule alignments_filtered_6:
    input:
        bam = "results/alignments/filtered/{sample}.0004.bam"
    output:
        bam = "results/alignments/filtered/{sample}.0005.bam"
    shell:
        "samtools sort {input.bam} > {output.bam}"

rule alignments_filtered_7:
    input:
        bam = "results/alignments/filtered/{sample}.0005.bam"
    output:
        bam = "results/alignments/filtered/{sample}.bam"
    shell:
        "samtools view -b -f 2 {input.bam} > {output.bam}"
