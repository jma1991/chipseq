rule pooling:
    input:
        lambda wildcards: expand("results/alignments/filtered/{sample}.bam", sample = config["groups"][wildcards.group])
    output:
        "results/alignments/pooled/{group}.bam"
    shell:
        "samtools merge {output} {input}"

rule pseudo1:
    input:
        "results/alignments/filtered/{base}.bam"
    output:
        "results/alignments/pseudo/{base}.pr1.bam"
    shell:
        "samtools view -s 1.5 {input} > {output}"

rule pseudo2:
    input:
        "results/alignments/filtered/{base}.bam"
    output:
        "results/alignments/pseudo/{base}.pr2.bam"
    shell:
        "samtools view -s 2.5 {input} > {output}"
