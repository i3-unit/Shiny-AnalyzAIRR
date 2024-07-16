[![](https://img.shields.io/static/v1?label=AIRR-C%20sw-tools%20v1&message=compliant&color=008AFF&labelColor=000000&style=plastic)]()

# Shiny-AnalyzAIRR

**Shiny-AnalyzAIRR** is a Shiny web application developed for the [AnalyzAIRR package](https://github.com/vanessajmh/AnalyzAIRR), making it user-friendly for biologists with little or no background in bioinformatics.

**Shiny-AnalyzAIRR** can be download from the Github repository and run locally on any device.
Alternatively, it was deployed on the Web and can thus be directly used at this [link](https://i3lab.shinyapps.io/shiny-analyzairr/).


# Package installation

The latest release of **AnalyzAIRR** can be installed from Github using devtools:

```
# AnalyzAIRR installation
devtools::install_github("vanessajmh/AnalyzAIRR")

```

**Shiny-AnalyzAIRR** should be cloned as follow:
```
# Clone the repository in commande line:
git clone https://github.com/vanessajmh/Shiny-AnalyzAIRR
```


# Getting started

**Shiny-AnalyzAIRR** can be launched from the terminal:
```
# Go to the Shiny-AnalyzAIRR folder
cd Shiny-AnalyzAIRR
# Launch R and shiny
R -e 'shiny::runApp("./")'
```

Alternatively, it can be run through Rstudio:
```
# Open global.R and run
shiny::runApp("./")
```
The interface can be opened in a web browser using the displayed hyper link address.


# Data loading

**Shiny-AnalyzAIRR** proposes two different data loading processes.

**1. Upload a RepSeqExperiment object**

A **RepSeqExperiment** object generated using the **AnalyzAIRR** R package and saved in an rds format can be used.

**2. Upload alignment files in AnalyzAIRR-compliant formats**

More details on how to prepare the input data can be found [here](https://vanessajmh.github.io/AnalyzAIRR.github.io/)

<br>
<video width="920" height="520" controls>
  <source src="/Users/vanessamhanna/Github/Shiny-AnalyzAIRR/video.mp4" type="video/mp4">
</video>

