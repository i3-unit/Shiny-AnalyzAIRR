---
title: "Report session"
author:
- name: V. Mhanna, G. Pires, N. Tchitchek, D. Klatzmann, A. Six, E. Mariotti-Ferrandiz
  affiliation: Sorbonne Université, INSERM, Immunology-Immunopathology-Immunotherapy (i3), Paris, France
- name: H. P. Pham
  affiliation: Parean Biotechnologies
runtime: shiny  
output: 
   #html_document
    rmdformats::robobook:
    #toc: true
    toc_depth: 2
    #theme: cerulean
    highlight: tango
    use_bookdown: true
    css: styles.css
---

<style type="text/css">
<!-- div#TOC li { -->
<!--     list-style:none; -->
<!--     background-image:none; -->
<!--     background-repeat:none; -->
<!--     background-position:0;  -->
<!-- } -->
 .book .book-body .page-inner  { 
    max-width: 1400px; 
 <!-- width: 120%;  -->
 } 
 .column-left {
  float: left;
  width: 49.7%;
}
.column-right{
 float: right;
  width: 49.7%;
}
.col2 {
    columns: 2 200px;         /* number of columns and width in pixels*/
    -webkit-columns: 2 200px; /* chrome, safari */
    -moz-columns: 2 200px;    /* firefox */
  }
h1 {
  color: #033c73;
   font-size: 30px;
}
h1.title {
  color: #033c73;
}
h2 {
  color: #033c73;
  font-size: 24px;
}
h3 {
   color: #033c73;
   font-size: 18px;
}
h4 {
   color: #022f5a;
}
h5 {
  color: #033c73;
}
h6 {
   color: #033c73;
}
body{ 
  font-size: 14px;
}
p.caption {
  font-size: 0.9em;
  font-style: italic;
  color: grey;
  margin-right: 10%;
  margin-left: 10%;  
  text-align: justify;
} 
#renderedReport p{
  color: white;
}

</style>




<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="title-label" for="title">Enter title</label>
<input id="title" type="text" class="form-control" value="Analysis report"/>
</div>
</p>
</body><!--/html_preserve-->


<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="authors-label" for="authors">Enter authors</label>
<input id="authors" type="text" class="form-control" value=""/>
</div>
</p>
</body><!--/html_preserve-->


# Data manipulation


## Filtering







**Filter out a sequence**

<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> history </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> data directory=/Users/vanessamhanna/Nextcloud/AnalyzAIRR/data </td>
  </tr>
  <tr>
   <td style="text-align:left;"> readAIRRSet; cores=2; fileFormat=MiXCR; chain=TRA; ambiguous FALSE; unprod FALSE; filter.singletons TRUE; aa threshold=8; raretab FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 345841 ntClone were filtered using filterCount: n= 1 and group= </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 33 aaClone were filtered using filterSequence: name= TRAV11 CVVGDRGSALGRLHF TRAJ18 group1= cell_subset and group2= Teff </td>
  </tr>
</tbody>
</table>
















































# Exploratory statistics


## Basic statistics









### Detailed repertoire level statistics

<!-- ```{r count features, echo=FALSE, warning=FALSE, message=FALSE, error=TRUE, fig.width=17, fig.height=6, fig.align='center'} -->
<!-- if(input$countLevel != "" && !is.null(input$countScale)){ -->
<!--    countfeatures <- countFeatures(x=dataFilt(), level = input$countLevel, scale = input$countScale, group = NULL) -->
<!--    knitr::kable(head(countfeatures)) %>% -->
<!--     kableExtra::kable_styling( -->
<!--                     full_width = FALSE, -->
<!--                     position = "center", -->
<!--                     font_size = 10) %>% -->
<!--     kableExtra::row_spec(0, color="#022f5a", font_size = 12)       -->
<!-- } -->

<!-- ``` -->

<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="countfeaturesText-label" for="countfeaturesText">Enter text</label>
<input id="countfeaturesText" type="text" class="form-control" value=""/>
</div>
</p>
</body><!--/html_preserve-->


## Diversity estimation 

### Rarefaction analysis



<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="rarefactionText-label" for="rarefactionText">Enter text</label>
<input id="rarefactionText" type="text" class="form-control" value=""/>
</div>
</p>
</body><!--/html_preserve-->


<!-- ```{r rarefaction tab,  echo=FALSE, warning=FALSE, message=FALSE, error=TRUE, fig.width=17, fig.height=6, fig.align='center'} -->
<!-- if(!is.null(input$plotRare)){ -->
<!--    raretab <- rarefactionTab(x = dataFilt()) -->
<!--    knitr::kable(head(raretab)) %>% -->
<!--             kableExtra::kable_styling( -->
<!--                     full_width = FALSE, -->
<!--                     position = "center", -->
<!--                     font_size = 10) %>% -->
<!--             kableExtra::row_spec(0, color="#022f5a", font_size = 12) -->
<!-- } -->

<!-- ``` -->









<!-- ```{r div ind tab,  echo=FALSE, warning=FALSE, message=FALSE, error=TRUE, fig.width=17, fig.height=6, fig.align='center'} -->
<!-- if(input$divLevel != ""){ -->
<!--    divind <- diversityIndices(x=dataFilt(), level = input$divLevel) -->
<!--    knitr::kable(head(divind)) %>% -->
<!--             kableExtra::kable_styling( -->
<!--                     full_width = FALSE, -->
<!--                     position = "center", -->
<!--                     font_size = 10) %>% -->
<!--             kableExtra::row_spec(0, color="#022f5a", font_size = 12)  -->
<!-- } -->

<!-- ``` -->


### Renyi index

<img src="figure/renyi ind-1.png" alt="plot of chunk renyi ind" style="display: block; margin: auto;" />

<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="renyiindText-label" for="renyiindText">Enter text</label>
<input id="renyiindText" type="text" class="form-control" value=""/>
</div>
</p>
</body><!--/html_preserve-->


<!-- ```{r renyi ind tab,  echo=FALSE, warning=FALSE, message=FALSE, error=TRUE, fig.width=17, fig.height=6, fig.align='center'} -->
<!-- if(input$renyiLevel != ""){ -->
<!--    renind <- renyiIndex(x=dataFilt(), level = input$renyiLevel) -->
<!--    knitr::kable(head(renind)) %>% -->
<!--             kableExtra::kable_styling( -->
<!--                     full_width = FALSE, -->
<!--                     position = "center", -->
<!--                     font_size = 10) %>% -->
<!--             kableExtra::row_spec(0, color="#022f5a", font_size = 12)  -->
<!-- } -->

<!-- ``` -->

























































# Multi-sample analysis


## Comparison of basic statistics









### Diversity indices

<img src="figure/div-1.png" alt="plot of chunk div" style="display: block; margin: auto;" />

<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="divText-label" for="divText">Enter text</label>
<input id="divText" type="text" class="form-control" value=""/>
</div>
</p>
</body><!--/html_preserve-->






























## Similarity analysis
















### Hierarchical clustering

<img src="figure/disHM-1.png" alt="plot of chunk disHM" style="display: block; margin: auto;" />

<!--html_preserve--><body style="color: white;">
<p style="color: white;">
<div class="form-group shiny-input-container">
<label class="control-label" id="disHMText-label" for="disHMText">Enter text</label>
<input id="disHMText" type="text" class="form-control" value=""/>
</div>
</p>
</body><!--/html_preserve-->


















<!-- ```{r diffExpGroup, echo=FALSE, warning=FALSE, message=FALSE, error=TRUE, fig.width=17, fig.height=6, fig.align='center'} -->
<!-- if(!is.null(input$diffGroup) && !is.null(input$diffLevel)){ -->
<!--     diffexp <- diffExpGroup(x = dataFilt(), colGrp = input$diffGroup[[1]], level = input$diffLevel, group = input$diffGroup) -->
<!--     knitr::kable(head(diffexp)) %>% -->
<!--             kableExtra::kable_styling( -->
<!--                     full_width = FALSE, -->
<!--                     position = "center", -->
<!--                     font_size = 10) %>% -->
<!--             kableExtra::row_spec(0, color="#022f5a", font_size = 12)  -->
<!-- } -->

<!-- ``` -->









<!-- ```{r spectratyping comparison table, echo=FALSE, warning=FALSE, message=FALSE, error=TRUE, fig.width=17, fig.height=6, fig.align='center'} -->
<!-- if(!is.null(input$PertGroupSelected) && !is.null(input$CtrlGroup) && !is.null(input$pertDist) && !is.null(input$pertOrder) && input$doHm == 1){ -->
<!--     sampleinfo <- mData(dataFilt()) -->
<!--     ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)] -->
<!--     pertscore <- perturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, p = 2) -->
<!--     knitr::kable(head(pertscore)) %>% -->
<!--             kableExtra::kable_styling( -->
<!--                     full_width = FALSE, -->
<!--                     position = "center", -->
<!--                     font_size = 10) %>% -->
<!--             kableExtra::row_spec(0, color="#022f5a", font_size = 12) -->
<!-- } -->

<!-- ``` -->


