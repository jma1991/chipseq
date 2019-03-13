rule quality_correlation:
    input:
        npz = "results/quality/summary.npz"
    output:
        pdf = "results/quality/correlation.pdf",
        tab = "results/quality/correlation.tab"
    shell:
        "plotCorrelation --corData {input.npz} --plotFile {output.pdf} --outFileCorMatrix {output.tab}"

rule quality_coverage:
    input:
        bam = expand("results/alignments/filtered/{sample}.bam", sample = SAMPLES)
    output:
        pdf = "results/quality/coverage.pdf",
        tab = "results/quality/coverage.tab"
    shell:
        "plotCoverage --bamfiles {input.bam} --plotFile {output.pdf} --outRawCounts {output.tab}"

rule quality_fingerprint:
    input:
        bam = expand("results/alignments/filtered/{sample}.bam", sample = SAMPLES)
    output:
        pdf = "results/quality/fingerprint.pdf",
        tab = "results/quality/fingerprint.tab"
    shell:
        "plotFingerprint --bamfiles {input.bam} --plotFile {output.pdf} --outRawCounts {output.tab}"

rule quality_fragment:
    input:
        bam = expand("results/alignments/filtered/{sample}.bam", sample = SAMPLES)
    output:
        pdf = "results/quality/fragment.pdf",
        tab = "results/quality/fragment.tab"
    shell:
        "bamPEFragmentSize --bamfiles {input.bam} --histogram {output.pdf} --outRawFragmentLengths {output.tab}"

rule quality_pca:
    input:
        npz = "results/quality/summary.npz"
    output:
        pdf = "results/quality/pca.pdf",
        tab = "results/quality/pca.tab"
    shell:
        "plotPCA --corData {input.npz} --plotFile {output.pdf} --outFileNameData {output.tab}"

rule quality_summary:
    input:
        bam = expand("results/alignments/filtered/{sample}.bam", sample = SAMPLES)
    output:
        npz = "results/quality/summary.npz",
        tab = "results/quality/summary.tab"
    shell:
        "multiBamSummary bins --bamfiles {input.bam} --outFileName {output.npz} --outRawCounts {output.tab}"
