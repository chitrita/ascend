% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ascend_plots.R
\name{plotAverageGeneCount}
\alias{plotAverageGeneCount}
\title{plotAverageGeneCount}
\usage{
plotAverageGeneCount(object, metric = c("average", "log2", "log10"))
}
\arguments{
\item{object}{An \linkS4class{EMSet} object.}

\item{metric}{Scale to plot data by - average (DEFAULT), log2 or log10.}
}
\value{
A ggplot2 glob containing the histogram.
}
\description{
Generates a histogram of average counts for each gene.
}
\examples{
\dontrun{
# Plot average gene count
average_genes <- plotAverageGeneCount(EMSet, metric = "average")

# Plot log2 average gene count
average_gene_2 <- plotAverageGeneCount(EMSet, metric = "log2")

# Plot log10 average gene count
average_gene_10 <- plotAverageGeneCount(EMSet, metric = "log10")

}
}
