# Shiny-AnalyzAIRR

Shiny-AnalyzAIRR is a Shiny web application developed for the [AnalyzAIRR package](https://github.com/vanessajmh/AnalyzAIRR), making it user-friendly for biologists with little or no background in bioinformatics.

The application can be either download from the Github repository or used directly at this [link](https://analyzairr.shinyapps.io/shiny-analyzairr/).


# Package installation
R should be installed with the following packages:
* shiny
* shinydashboard
* shinysky
* shinyjs
* shinythemes
* shinyWidgets
* AnalyzAIRR
* rmarkdown
* markdown
* BiocStyle

```
#Install package dependencies



```

# Getting started

Clone the repository in commande line:
```
git clone https://github.com/vanessajmh/Shiny-AnalyzAIRR
```

Launch the Shiny application in commande line
```
# Change to Shiny-AnalyzAIRR folder
cd Shiny-AnalyzAIRR
# launch R and shiny
R -e 'shiny::runApp("./")'
```

Launch the Shiny application in Rstudio
```
# Open global.R and run
shiny::runApp("./")
```


and copy/paste the hyper link address (http://120.0.0.1:port_number) into a web browser address bar.

# Data loading

## Upload a RepSeqExperiment object

A **RepSeqExperiment** object generated using the AnalyzAIRR R package and saved in an rds format can be used.

## Upload alignment files in AnalyzAIRR-compliant formats

**1. Specify an alignment file format**

  * **MiXCR**: https://github.com/milaboratory/mixcr

  * **immunoSEQ**: https://www.immunoseq.com/

  * **MiAIRR**: https://docs.airr-community.org/en/latest/datarep/rearrangements.html 
  
  * **Other**: Alignment files should contain the following required column names:

      - **sample_id**: Sample names
      
      - **CDR3nt**: CDR3 nucleotide sequence
      
      - **CDR3aa**: CDR3 amino acid sequence
      
      - **V**: Variable gene name (IMGT nomenclature)
      
      - **J**: Joining gene name (IMGT nomenclature)
      
      - **count**: the occurrence of each sequence within the sample
      
      **Note**: The order of the columns must be respected. Input files can contain           additional columns that will not be taken into account during the loading process.

**2. Specify the chain type to be analyzed (only one chain can be loaded at once)**

**3. Specify the paths to input files**

**4. Load the metadata**

  It is possible to provide a metadata if users wish to perform inter-group comparative analyses. 
  
  The metadata should be provided as a dataframe containing:

  * a column with the sample names that match the name of the alignment files and their order in the list.
  
  * any additional columns with relevant information for the analyses. Columns could encompass the experimental conditions, clinical variables, etc... 
  
  No specific column names nor order are required.

**5. Download the RepSeqExperiment object**

Once files are successfully downloaded, a RepSeqExperiment object is built which can downloaded in a rds format for subsequent usage.
