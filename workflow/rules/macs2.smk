# raw
# filtered
# reproducible
# conservative
# optimal

rule peaks_raw:
    input:
        b1 = lambda wildcards: expand("results/alignments/filtered/{treatment}.bam", treatment = config["contrasts"][wildcards.contrast][0]),
        b2 = lambda wildcards: expand("results/alignments/filtered/{control}.bam", control = config["contrasts"][wildcards.contrast][1])
    output:
        "results/peaks/raw/{contrast}_peaks.narrowPeak",
        "results/peaks/raw/{contrast}_summits.bed"
    params:
        out = "results/peaks/raw"
    shell:
        "macs2 callpeak -t {input.b1} -c {input.b2} -g hs --keep-dup all --outdir {params.out} --n {wildcards.contrast} -p 0.01"

rule peaks_filtered:
    input:
        "results/peaks/raw/{contrast}_peaks.narrowPeak"
    output:
        "results/peaks/filtered/{contrast}_peaks.narrowPeak"
    shell:
        "awk '$9 > 1.30103 { print $0 }' {input} > {output}"
        
def peaks_replicates(wildcards):
  print(wildcards)
  str = wildcards.permutation
  idx = [idx for idx, chr in enumerate(str) if chr == "1"]
  src = config["groups"][wildcards.group]
  np0 = "results/peaks/raw/{group}_peaks.narrowPeak".format(group = wildcards.group)
  np1 = "results/peaks/raw/{sample}_peaks.narrowPeak".format(sample = src[idx[0]])
  np2 = "results/peaks/raw/{sample}_peaks.narrowPeak".format(sample = src[idx[1]])
  dct = {"np0": np0, "np1": np1, "np2": np2}
  return dct

rule peaks_reproducible:
    input:
        unpack(peaks_replicates)
    output:
        np0 = "results/peaks/replicated/{group}_peaks.{permutation}.narrowPeak"
    shell:
        "idr -s {input.np1} {input.np2} -p {input.np0} -o {output.np0} -i 0.05"

rule peaks_reproduced:
    input:
        np0 = "results/peaks/raw/{contrast}_peaks.narrowPeak",
        np1 = "results/peaks/raw/{contrast}_peaks.01.narrowPeak",
        np2 = "results/peaks/raw/{contrast}_peaks.02.narrowPeak"
    output:
        np0 = "results/peaks/reproduced/{contrast}_peaks.narrowPeak"
    shell:
        "idr -s {input.np1} {input.np2} -p {input.np0} -o {output.np0} -i 0.05"
        
def peaks_test(wildcards):
  con = config["groups"][wildcards.group]
  num = len(con)
  itr = "11" + "0" * (num - 2)
  prm = itertools.permutations(itr)
  lst = [list(s) for s in set(prm)]
  str = ["".join(l) for l in lst]
  fls = expand("results/peaks/replicated/{group}_peaks.{permutation}.narrowPeak", group = wildcards.group, permutation = str) 
  return fls

rule peaks_conservative:
    input:
        np0 = peaks_test
    output:
        np0 = "results/peaks/conservative/{group}_peaks.narrowPeak"
    shell:
        "echo HELLO"

rule peaks_optimal:
    input:
        np1 = "results/peaks/conservative/{group}_peaks.narrowPeak",
        np2 = "results/peaks/pooled/{group}_peaks.narrowPeak"
    output:
        np0 = "results/peaks/optimal/{group}_peaks.narrowPeak"
    shell:
        ""
