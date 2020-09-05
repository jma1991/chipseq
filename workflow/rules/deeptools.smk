# Author: James Ashmore
# Copyright: Copyright 2020, James Ashmore
# Email: jashmore@ed.ac.uk
# License: MIT

rule deeptools_summary:
    input:
        bam = expand("results/bwa/{sample}.bam", sample = SAMPLES)
    output:
        npz = "results/deeptools/summary.npz",
        tab = "results/deeptools/summary.tab"
    conda:
        "../envs/deeptools.yaml"
    shell:
        "multiBamSummary bins --bamfiles {input.bam} --outFileName {output.npz} --outRawCounts {output.tab}"

rule deeptools_correlation:
    input:
        npz = "results/deeptools/summary.npz"
    output:
        pdf = "results/deeptools/correlation.pdf",
        tab = "results/deeptools/correlation.tab"
    conda:
        "../envs/deeptools.yaml"
    shell:
        "plotCorrelation --corData {input.npz} --plotFile {output.pdf} --outFileCorMatrix {output.tab}"

rule deeptools_coverage:
    input:
        bam = expand("results/bwa/{sample}.bam", sample = SAMPLES)
    output:
        pdf = "results/deeptools/coverage.pdf",
        tab = "results/deeptools/coverage.tab"
    conda:
        "../envs/deeptools.yaml"
    shell:
        "plotCoverage --bamfiles {input.bam} --plotFile {output.pdf} --outRawCounts {output.tab}"

rule deeptools_fingerprint:
    input:
        bam = expand("results/bwa/{sample}.bam", sample = SAMPLES)
    output:
        pdf = "results/deeptools/fingerprint.pdf",
        tab = "results/deeptools/fingerprint.tab"
    conda:
        "../envs/deeptools.yaml"
    shell:
        "plotFingerprint --bamfiles {input.bam} --plotFile {output.pdf} --outRawCounts {output.tab}"

rule deeptools_fragment:
    input:
        bam = expand("results/bwa/{sample}.bam", sample = SAMPLES)
    output:
        pdf = "results/deeptools/fragments.pdf",
        tab = "results/deeptools/fragment.tab"
    conda:
        "../envs/deeptools.yaml"
    shell:
        "bamPEFragmentSize --bamfiles {input.bam} --histogram {output.pdf} --outRawFragmentLengths {output.tab}"

rule deeptools_pca:
    input:
        npz = "results/deeptools/summary.npz"
    output:
        pdf = "results/deeptools/pca.pdf",
        tab = "results/deeptools/pca.tab"
    conda:
        "../envs/deeptools.yaml"
    shell:
        "plotPCA --corData {input.npz} --plotFile {output.pdf} --outFileNameData {output.tab}"