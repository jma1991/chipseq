rule reads_raw:
    output:
        "data/reads/raw/{run}.fastq.gz"
    params:
        out = "data/reads/raw"
    shell:
        "fasterq-dump -O {params.out} {wildcards.run}"

rule reads_trimmed:
    input:
        "data/reads/raw/{run}.fastq.gz"
    output:
        "data/reads/trimmed/{run}.fastq.gz"
    shell:
        "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -o {output} {input}"
