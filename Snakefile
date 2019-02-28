# Configuration
configfile: "config.yml"

# Wildcards
wildcard_constraints:
    contrast = "|".join(CONTRASTS),
    group = "|".join(GROUPS),
    sample = "|".join(SAMPLES),
    run = "|".join(RUNS)

# Targets
rule default:
    input:
        expand("data/samples/{sample}/{sample}_filter.bam", sample = SAMPLES),
        expand("data/samples/{group}/{group}_filter.bam", group = GROUPS),
        expand("results/peaks/{contrast}/{contrast}_peaks.narrowPeak", contrast = CONTRASTS),
        expand("results/peaks/{contrast}/{contrast}_peaks.gappedPeak", contrast = CONTRASTS),
        expand("results/coverage/{contrast}/{contrast}_treatment.bigWig", contrast = CONTRASTS)

# Rules
include: "rules/genomes.smk"
include: "rules/indexes.smk"
include: "rules/samples.smk"
include: "rules/markdup.smk"
include: "rules/filter.smk"
include: "rules/groups.smk"
include: "rules/pseudo.smk"
include: "rules/peaks.smk"
include: "rules/coverage.smk"

# Reports
report: "reports/analysis.rst"
report: "reports/workflow.rst"
