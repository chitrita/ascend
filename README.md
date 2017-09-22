# ASCEND
## Analysis of Single Cell Expression, Normalisation and Differential expression
### Workflow Summary
<img src="ASCEND_workflow.png" width = "400", height = "500">

### Installation
#### Required Packages
- **BiocParallel**
- **dplyr**
- **data.table**
- **reshape2**
- **ggplot2**
- **RColorBrewer**
- **scater**
- **scran**
- **limSolve**
- **dynamicTreeCut**
- **dendextend**
- **Rtsne**
- **DESeq**

#### Installing ASCEND
As this package is still under development, please use devtools to load the package.

```{r}
devtools::load_all("/Path/To/ASCEND")
```

You can also use devtools' install_github function to install the package. You can then load the package as normal.

```{r}
devtools::install_github("MB-Computational-Genomics-Lab/ASCEND")
library(ASCEND)
```

### Getting started
#### System Requirements
The amount of computational power and time required to process and analyse a single-cell RNASeq dataset is dependant on its size. Generally, ASCEND can comfortably analyse datasets that consist of up to 10,000 cells on a single machine. A single machine is defined as a desktop or laptop with 8GB of memory and four CPUs.

#### Configuring BiocParallel
This package makes extensive use of [BiocParallel](http://bioconductor.org/packages/release/bioc/html/BiocParallel.html) for its functions. Before you begin, you should register a BiocParallel backend in order to get the best performance out of this package.

Here are some example configurations:

#### Unix/Linux/MacOS (Single Machine)
```{r SetupNix}
library(BiocParallel)
ncores <- parallel::detectCores() - 1
register(MulticoreParam(workers = ncores, progressbar=TRUE), default = TRUE)
```

#### Windows (Single Machine - Quad-core system)
```{r SetupWin, eval = FALSE}
library(BiocParallel)
workers <- 3 # Number of cores on your machine - 1
register(SnowParam(workers = workers, type = "SOCK", progressbar = TRUE), default = TRUE)
```

#### Cluster (Unix) (MPI)
```{r SetupCluster}

```
### Preparing your data
This package has been tested with scRNASeq data generated by Chromium and DropSeq/FlowSeq. Data generated by other systems can be used with this package, provided the input is in the form of an expression matrix. The following section will describe how the data should be formatted.

##### Expression Matrix
The main source of input is an expression matrix, or a gene/cell matrix containing transcript counts. They are usually produced at the end of single cell RNA-seq processing pipelines such as Cell Ranger and DropSeq.

In an expression matrix, each row represents a gene and each column represents a cell. The names of rows and columns will subsequently be named accordingly.

ASCEND is able to use any row and column names in the expression matrix, provided they abide by the following criteria:

1. Names should not repeat. If you have a list with repeats, you can make the names unique by using R's 'make.unique' function.
2. You should be able to identify which genes you would like to select as controls. This is why gene symbols or ENSEMBL transcript IDs should be used.
3. Cells from different batches, samples or sequencing runs should be given a numeric identifier at the end. eg. BARCODE-1, BARCODE-2, BARCODE-3.

##### Combining expression matrices from different batches
You can concatenate multiple expression matrices with the function *MergeExprsMtx*. Expression matrices generated with this method should then be normalised with the *NormaliseBatches* function. For pipelines such as Chromium's Cell Ranger, the native aggregation function should be used as it takes into account additional information such as individual reads.

#### Batch Information
Batch Information is a named list containing cell identifiers and their associated batch. ASCEND will automatically generate batch information for an expression matrix if none are provided. However, it will make the assumption that there is only one batch of cells in the expression matrix.

#### Gene Annotation
The Gene Annotation slot holds a data frame that contains the gene identifiers used in the expression matrix, in addition to their corresponding identifiers in other systems. This information is optional.

#### Controls
You must provide a list of gene identifiers linked to controls. Generally, mitochondrial and ribosomal genes are used as controls. Spike-ins are also used as controls if they were included in the study.

Controls should be organised into a named list, and identifiers used should be present in the expression matrix.

#### Loading the data into ASCEND
Follow the vignette [ASCEND_Tutorial.Rmd](vignettes/ASCEND_Tutorial.Rmd) to learn about how to load your prepared data for use with ASCEND.

#### Contact
Send your bug reports and questions to me please! I can be contacted at a.senabouth@imb.uq.edu.au
