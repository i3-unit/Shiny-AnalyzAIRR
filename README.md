# Shiny-AnalyzAIRR

Shiny-AnalyzAIRR is a web-based interface developped with shiny tools that allows exploring an RepSeqExperiment object. ```RepSeqExperiment``` is a **R** **S4** class provided by the package ```AnalyzAIRR``` (cf https://github.com/vanessajmh/AnalyzAIRR for more details). 

# Prerequisites
## R
R should be installed with the following packages:
* shiny
* shinyjs
* shinydashboard
* shinysky
* DT
* AnalyzAIRR

## File in RDS format
a RepSeqExperiment object in ```rds``` format. Clonotype tables obtained from aligners could be pre-processed using the function ```readClonotypeSet``` of the package ```AnalyzAIRR``` and saved under the ```.rds```format.

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
git clone https://github.com/vanessajmh/Shiny-AnalyzAIRR
```

Launch the Shiny application in commande line
```
# Change to DiversiTR folder
cd Shiny-AnalyzAIRR
# launch R and shiny
R -e 'shiny::runApp("./")'
```
and copy/paste the hyper link address (http://120.0.0.1:port_number) into a web browser address bar.
