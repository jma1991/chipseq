rule genomes_install:
    output:
        "data/genomes/{genome}/{genome}.annotation.bed.gz",
        "data/genomes/{genome}/{genome}.annotation.gtf.gz",
        "data/genomes/{genome}/{genome}.fa",
        "data/genomes/{genome}/{genome}.fa.fai",
        "data/genomes/{genome}/{genome}.fa.sizes",
        "data/genomes/{genome}/{genome}.gaps.bed",
        "data/genomes/{genome}/README.txt"
    params:
        "data/genomes"
    shell:
        "genomepy install -g {params} --annotation {wildcards.genome} UCSC"

rule indexes_bowtie2:
    input:
        "data/genomes/{genome}/{genome}.fa"
    output:
        "data/genomes/{genome}/indexes/bowtie2/{genome}.1.bt2",
        "data/genomes/{genome}/indexes/bowtie2/{genome}.2.bt2",
        "data/genomes/{genome}/indexes/bowtie2/{genome}.3.bt2",
        "data/genomes/{genome}/indexes/bowtie2/{genome}.4.bt2",
        "data/genomes/{genome}/indexes/bowtie2/{genome}.rev.1.bt2",
        "data/genomes/{genome}/indexes/bowtie2/{genome}.rev.2.bt2"
    params:
        "data/genomes/{genome}/indexes/bowtie2/{genome}"
    shell:
        "bowtie2-build {input} {params}"
