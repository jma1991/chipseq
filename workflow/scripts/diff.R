#!/usr/bin/env Rscript

main <- function(snakemake) {

  pkg <- c("DiffBind")
  lib <- lapply(pkg, library, character.only = TRUE)

  obj <- dba(sampleSheet = tsv)
  obj <- dba.count(obj)
  obj <- dba.contrast(obj, minMembers = 2, categories = DBA_GROUP)
  obj <- dba.analyze(obj)

  rng <- dba.report(obj)

}