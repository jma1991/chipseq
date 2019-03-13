rule preseq_c_curve:
    input:
        "data/samples/{sample}_filtered.bam"
    output:
        "results/quality/preseq/{sample}_c_curve.txt"
    conda:
        "envs/preseq.yaml"
    shell:
        "preseq c_curve -B {input} 1> {output} 2> {log}"

rule preseq_lc_extrap:
    input:
        "data/samples/{sample}_filtered.bam"
    output:
        "results/quality/preseq/{sample}_lc_extrap.txt"
    conda:
        "envs/preseq.yaml"
    shell:
        "preseq lc_extrap -B {input} 1> {output} 2> {log}"
