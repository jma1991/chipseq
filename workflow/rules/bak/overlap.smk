rule name:
    input:
        np1 = lambda wildcards: expand("results/peaks/{sample}/{sample}_peaks.narrowPeak", sample = config["groups"][wildcards.group])
        np2 = lambda wildcards: expand("results/peaks/{sample}/{sample}_peaks.narrowPeak", sample = config["groups"][wildcards.group])
    output:
        np0 = "results/peaks/{group}/{group}_peaks.narrowPeak"
    shell:
        "bedtools intersect -a {input.np1} -b {input.np2} -wo > {output.np0}"
