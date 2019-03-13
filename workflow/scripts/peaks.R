#!/usr/bin/env Rscript

metrics <- function(file) {

    format <- strsplit(basename(file), split="\\.")[[1]][-1]

    ranges <- read.delim(file, header = FALSE)
    
    widths <- ranges[, 3] - ranges[, 2]

    metric <- data.frame(
        file = file,
        format = format,
        num_peaks = nrow(ranges),
        sum_len = sum(widths)
        min_len = min(widths),
        avg_len = mean(widths),
        max_len = max(widths)
    )

    metric

}

main <- function(snakemake) {

    files <- snakemake@input

    table <- do.call(rbind, lapply(files, metrics))

    write.table(
        x = table,
        file = snakemake@output,
        quote = FALSE,
        sep = "\t",
        row.names = FALSE,
        col.names = TRUE
    )

}

main(snakemake)