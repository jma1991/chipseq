# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule samtools_idxstats:
    input:
        bam = "results/bwa/{sample}.bam"
    output:
        txt = "results/samtools/{sample}_idxstats.txt"
    log:
        log = "results/samtools/{sample}_idxstats.log"
    message:
        "[samtools]"
    shell:
        "samtools idxstats {input.bam} 1> {output.txt} 2> {log}"

rule samtools_flagstat:
    input:
        bam = "results/bwa/{sample}.bam"
    output:
        txt = "results/samtools/{sample}_flagstat.txt"
    log:
        log = "results/samtools/{sample}_flagstat.log"
    message:
        "[samtools]"
    shell:
        "samtools flagstat {input.bam} 1> {output.txt} 2> {log}"

rule samtools_stats:
    input:
        bam = "results/bwa/{sample}.bam"
    output:
        txt = "results/samtools/{sample}_stats.txt"
    log:
        log = "results/samtools/{sample}_stats.log"
    message:
        "[samtools]"
    shell:
        "samtools stats {input.bam} 1> {output.txt} 2> {log}"