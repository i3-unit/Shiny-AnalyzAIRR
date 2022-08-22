# DiversiTR

DiversiTR is a web-based interface developped with shiny tools that allows exploring an RepSeqExperiment object. ```RepSeqExperiment``` is a **R** **S4** class provided by the package ```RepSeq``` (cf https://github.com/ph-pham/RepSeq for more details). 

# Prerequisites
## R
R should be installed with the following packages:
* shiny
* shinyjs
* shinydashboard
* shinysky
* DT
* RepSeq

## File in RDS format
a RepSeqExperiment object in ```rds``` format. Clonotype tables obtained from aligners could be pre-processed using the function ```readClonotypeSet``` of the package ```RepSeq``` and saved under the ```.rds```format.

Example
```r
# load library in memory
library(AnalyzAIRR)
# list of aligner output files (suppose to be stored in /MiXCR_output/) 
inputFolder <- list.files("/MiXCR_output/", full.name = TRUE, pattern = ".tsv")
# Create an object of class RepSeqExperiment using the wrapper function readClonotypeSet
datatab <- readClonotypeSet(inputFolder, cores=2L, aligner="MiXCR", chain="A", sampleinfo=NULL, keep.ambiguous=FALSE, keep.unproductive=FALSE, aa.th=8) 
saveRDS(datatab, file="~/datatab.rds")
```

## Tab-delimited clonotype tables
in development

# Getting started

Clone the repository in commande line:
```r
git clone https://github.com/ph-pham/DiversiTR
```

Launch the Shiny application in commande line
```
# Change to DiversiTR folder
cd DiversiTR
# launch R and shiny
R -e 'shiny::runApp("./")'
```
and copy/paste the hyper link address (http://120.0.0.1:port_number) into a web browser address bar.
