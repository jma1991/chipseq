rule coverage_raw:
    input:
        bam = "results/alignments/filtered/{sample}.bam"
    output:
        wig = "results/coverage/raw/{sample}.bw"
    shell:
        "bamCoverage -b {input.bam} -o {output.wig} --normalizeUsing None --ignoreForNormalization chrX chrM --extendReads 146"

rule coverage_cpm:
    input:
        bam = "results/alignments/filtered/{sample}.bam"
    output:
        wig = "results/coverage/cpm/{sample}.bw"
    shell:
        "bamCoverage -b {input.bam} -o {output.wig} --normalizeUsing CPM --ignoreForNormalization chrX chrM --extendReads 146"        

rule coverage_log2:
    input:
        bw1 = lambda wildcards: expand("results/coverage/cpm/{sample}.bw", sample = config["contrasts"][wildcards.contrast][0]),
        bw2 = lambda wildcards: expand("results/coverage/cpm/{sample}.bw", sample = config["contrasts"][wildcards.contrast][1])
    output:
        bw0 = "results/coverage/log2/{contrast}.bw"
    shell:
        "bigwigCompare -b1 {input.bw1} -b2 {input.bw2} --pseudoCount 0.01 --operation log2 -p {threads} -o {output.bw0}"

rule coverage_ratio:
    input:
        bw1 = lambda wildcards: expand("results/coverage/cpm/{sample}.bw", sample = config["contrasts"][wildcards.contrast][0]),
        bw2 = lambda wildcards: expand("results/coverage/cpm/{sample}.bw", sample = config["contrasts"][wildcards.contrast][1])
    output:
        bw0 = "results/coverage/ratio/{contrast}.bw"
    shell:
        "bigwigCompare -b1 {input.bw1} -b2 {input.bw2} --pseudoCount 0.01 --operation log2 -p {threads} -o {output.bw0}"

rule coverage_subtract:
    input:
        bw1 = lambda wildcards: expand("results/coverage/cpm/{sample}.bw", sample = config["contrasts"][wildcards.contrast][0]),
        bw2 = lambda wildcards: expand("results/coverage/cpm/{sample}.bw", sample = config["contrasts"][wildcards.contrast][1])
    output:
        bw0 = "results/coverage/subtract/{contrast}.bw"
    shell:
        "bigwigCompare -b1 {input.bw1} -b2 {input.bw2} --operation subtract -p {threads} -o {output.bw0}"
