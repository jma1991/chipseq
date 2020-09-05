rule motifs1:
    input:
        bed = "results/peaks/{contrast}_summits.bed"
        fai = "data/genomes/{genome}/{genome}.fa.fai"
    output:
        bed = pipe("results/motifs/{contrast}_slop.bed")
    shell:
        "bedtools slop -g {input.fai} -i {input.bed} -b 250 > {output.bed}"

rule motifs2:
    input:
        bed = "results/motifs/{contrast}_slop.bed",
        fas = "data/genomes/{genomes}/{genome}.fa.fai"
    output:
        fas = "results/motifs/{contrast}_slop.fa"
    shell:
        "bedtools getfasta -fi {input.fas} -bed {input.bed} > {output.fas}"

rule motifs3:
    input:
        db = "",
        fa = "results/motifs/{contrast}_slop.fa"
    output:
        expand("results/motifs/{contrast}/{file}", file = ["combined.meme", "meme-chip.html", "summary.tsv"])
    params:
        oc = "results/motifs/{contrast}"
    shell:
        "meme-chip -oc {params.oc} -db {input.db} {input.fa}"
