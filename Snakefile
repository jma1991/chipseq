# Configuration
configfile: "config.yaml"

# Variables
import itertools
CONTRASTS = list(config["contrasts"].keys())
GROUPS = list(config["groups"].keys())
SAMPLES = list(config["samples"].keys())
RUNS = config["samples"].values()
RUNS = list(itertools.chain.from_iterable(RUNS))

# Wildcards
wildcard_constraints:
    contrasts = "|".join(CONTRASTS),
    groups = "|".join(GROUPS),
    sample = "|".join(SAMPLES),
    run = "|".join(RUNS)

# Targets
rule default:
    input:
        expand("data/reads/raw/{run}.fastq.gz", run = RUNS),
        expand("data/reads/trimmed/{run}.fastq.gz", run = RUNS),
        expand("results/alignments/raw/{run}.bam", run = RUNS),
        expand("results/alignments/merged/{sample}.bam", sample = SAMPLES),
        expand("results/alignments/markdup/{sample}.bam", sample = SAMPLES),
        expand("results/alignments/filtered/{sample}.bam", sample = SAMPLES),

# Rules
include: "workflow/rules/genomes.smk"
include: "workflow/rules/reads.smk"
include: "workflow/rules/alignments.smk"
include: "workflow/rules/quality.smk"
include: "workflow/rules/coverage.smk"
include: "workflow/rules/peaks.smk"
include: "workflow/rules/metrics.smk"
