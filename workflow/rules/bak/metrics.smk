rule alignments:
    input:
        bam = "results/alignments/{dir}/{run}.bam"
    output:
        ""
    shell:
        "samtools flagstat {input} > {output}"

rule complexity:
    input:
        ""
    output:
        ""
    


        
rule reads:
    input:
        fqz = expand("data/reads/{dir}/{run}.fastq.gz", run = config["runs"], dir = ["raw", "trimmed"])
    output:
        tab = "results/metrics/reads.tab"
    shell:
        "seqkit stats {input} > {output}"

rule peaks:
    input:
        fqz = expand("data/reads/{dir}/{run}.fastq.gz", run = config["runs"], dir = ["raw", "trimmed"])
    output:
        tab = "results/metrics/reads.tab"
    shell:
        "seqkit stats {input} > {output}"
