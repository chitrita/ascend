![alt text](ascend_banner.png?raw=true "ascend - Analysis of Single Cell Expression, Normalisation and Differential expression")
### Workflow Summary
![alt text](workflow.png?raw=true "ascend workflow summary")

### 1. Introduction
`ascend` (Analysis of Single Cell Expression, Normalisation and Differential expression) is a user-friendly scRNA-seq analysis toolkit implemented in R. Using pre-existing and novel methods, `ascend` offers quick and robust tools for quality control, normalisation, dimensionality reduction, clustering and differential expression.

### 2. Preparing data for 'ascend'
`ascend` takes transcript counts, either as read counts or UMI counts that are
loaded into a gene-cell expression matrix. In an expression matrix, rows
represent each gene or transcript, while columns represent cells. These matrices
are generally produced by most scRNA-seq pipelines. `ascend` was developed using
data from Chromium, but has been tested with data generated by other platforms
such as DropSeq and inDrop.

The expression matrix is loaded into a container object known as an Expression
and Metadata Set (EMSet). This object is also capable of storing metadata
related to cells and genes.

Please refer to the vignettes (browseVignettes("ascend") in R) for more information on how to use this package.


### 2.1 Updating EMSets created with older versions of `ascend`
If you have created an EMSet using older versions of the package (< 0.6.0),
please update your old objects as follows:

```{r}
# Import old EMSet stored in RDS file
legacy_EMSet <- readRDS("legacy_EMSet.rds")

# Update EMSet, please make sure you overwrite your old object
legacy_EMSet <- updateObject(legacy_EMSet)

```

This function will repackage your data into the new SingleCellExperiment-based
EMSet. If your data has been normalised, it will load your data into both the
`counts` and `normcounts` slots.

### 3. Installation
#### 3.1 Preparing the R Environment
Feel free to skip some steps if you have already done those steps.

##### 3.1.1 R installation
Please follow the R installation instructions [here](https://mirror.aarnet.edu.au/pub/CRAN/).
If you are a Windows user, make sure you install Rtools. Please note the `ascend`
package requires R version >= 3.5.0. The latest version of R version 3.5.1 is
best.

##### 3.1.2 R programming environment
The workshop will be done in [RStudio](https://www.rstudio.com/products/rstudio/download/),
but feel free to set up your own R workspace.

#### 3.2 Package Installations
You will need to install the following packages to run the development version
of `ascend`. Feel free to skip these steps if you already have these packages.

##### 3.2.1 Packages from CRAN
You can use the install.packages() to install the packages described in this
section. The pcakages you require from this repository are as follows:

1. [devtools](https://cran.r-project.org/web/packages/devtools/index.html): This
package will be used to load the development version of `ascend`.
2. [tidyverse](https://www.tidyverse.org/): This is a series of R packages
for data science and visualisation. This will install packages such as dplyr,
ggplot2 and tidyr.
3. [data.table](https://github.com/Rdatatable/data.table/wiki/Installation):
Please follow the instructions on this page for your operating system.

Remaining packages can be installed as follows:

```r
# List of packages to install
cran_packages <- c("reshape2", "fields", "ggbeeswarm", "gridExtra",
                   "dynamicTreeCut", "dendextend", "RColorBrewer",
                   "locfit", "KernSmooth")

# Easy command to install all at once
install.packages(cran_packages)
```

Note:
There may be issues for some users related to the R package "stringi". This package is a dependancy for some of the packages from Bioconductor. Try installing this package from this website https://cran.r-project.org/web/packages/stringi/index.html.

##### 3.2.2 Packages from Bioconductor
Bioconductor is a repository for R packages  related to the analysis and
comprehension of high-throughput genomic data. It uses a separate set of
commands for the installation of packages.

###### 3.2.2.1 Setting up Bioconductor
Use the following code to retrieve the latest installer from Bioconductor.

```r
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite()
```

You can then install the Bioconductor packages using `biocLite`.

```r
bioconductor_packages <- c("Biobase", "BiocGenerics", "BiocParallel",
                           "SingleCellExperiment", "GenomeInfoDb", "GenomeInfoDbData")
biocLite(bioconductor_packages)
```

##### 3.2.2.2 scater/scran package installation
[scater](https://bioconductor.org/packages/devel/bioc/html/scater.html) and [scran](https://bioconductor.org/packages/devel/bioc/html/scran.html) are scRNA-seq analysis toolboxes that provide more in-depth methods for QC and filtering. You may choose to install these packages if you wish to take advantage of the wrappers provided for these packages.

##### 3.2.2.3 Differential expression packages
`ascend` provides wrappers for [DESeq](https://bioconductor.org/packages/release/bioc/html/DESeq.html)
and [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html),
so you may choose to add them to your installation. However, we will only be
using DESeq for the workshop as DESeq2 will require more time than allocated
for the workshop.

### 3.4 Installing 'ascend' via devtools
As `ascend` is still under development, we will use devtools to install the
package.

```r
# Load devtools package
library(devtools)

# Use devtools to install the package
install_github("IMB-Computational-Genomics-Lab/ascend")

# Load the package in R
library(ascend)
```

#### 3.5 Configuring BiocParallel
This package makes extensive use of [BiocParallel](http://bioconductor.org/packages/release/bioc/html/BiocParallel.html), enabling `ascend` to make the most of your computer's hardware. As each system is different, BiocParallel needs to be configured by the user. Here are some example configurations.

#### 3.5.1 Unix/Linux/MacOS (Single Machine)
```r
library(BiocParallel)
ncores <- parallel::detectCores() - 1
register(MulticoreParam(workers = ncores, progressbar=TRUE), default = TRUE)
```

#### 3.5.2 Windows (Single Machine - Quad-core system)
The following commands allows Windows to parallelise functions via BiocParallel.
Unlike multicore processing in *nix systems, Snow creates additional R sessions
to export tasks to. This requires additional computational resources to run and
manage the tasks.

We recomend you bypass this step if your machine has lower specs.

```r
library(BiocParallel)
workers <- 3 # Number of cores on your machine - 1
register(SnowParam(workers = workers,
                   type = "SOCK",
                   progressbar = TRUE), default = TRUE)
```

### 4. Contact
Please report any bugs on the Issues tracker of this repository. Feel free to send any other queries to a.senabouth@imb.uq.edu.au.
