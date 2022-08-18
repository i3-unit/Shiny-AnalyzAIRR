---
title: "Report session"
author:
- name: V. Mhanna, G. Pires, N. Tchitchek, D. Klatzmann, A. Six, E. Mariotti-Ferrandiz
  affiliation: Sorbonne Université, INSERM, Immunology-Immunopathology-Immunotherapy (i3), Paris, France
- name: H. P. Pham
  affiliation: Parean Biotechnologies
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
</style>




This file is generated automatically, this is a summary report of your actions on Shiny AnalyzAIRR.

# Data manipulation

## Filtering


**Filter out a repertoire level count**

<table class="table" style="font-size: 10px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> history </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> data directory=/mnt/mukkuri/RepSeq/RS_Analysis/GPI/AnalyzAIRR/extdata/mixcr </td>
  </tr>
  <tr>
   <td style="text-align:left;"> readAIRRSet; cores=2; fileFormat=MiXCR; chain=TRA; ambiguous FALSE; unprod FALSE; filter.singletons TRUE; aa threshold=8; raretab FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 114783 clonotype were filtered using filterCount: n= 1 and group= </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 0 CDR3nt were filtered using filterCount: n= 1 and group= cell_subset </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 0 CDR3nt were filtered using filterCount: n= 1 and group= amTreg </td>
  </tr>
</tbody>
</table>












































# Exploratory statistics


## Basic statistics


### Metadata statistics

![plot of chunk metadata stats](figure/metadata stats-1.png)


### Detailed repertoire level statistics

<table class="table" style="font-size: 10px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> J </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-30-813 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-30-815 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-31-846 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-31-848 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-35-970 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-35-972 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-36-1003 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> tripod-36-1005 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> TRAJ11 </td>
   <td style="text-align:right;"> 0.0084494 </td>
   <td style="text-align:right;"> 0.0109075 </td>
   <td style="text-align:right;"> 0.0084581 </td>
   <td style="text-align:right;"> 0.0111792 </td>
   <td style="text-align:right;"> 0.0110723 </td>
   <td style="text-align:right;"> 0.0107598 </td>
   <td style="text-align:right;"> 0.0112040 </td>
   <td style="text-align:right;"> 0.0101257 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAJ12 </td>
   <td style="text-align:right;"> 0.0434363 </td>
   <td style="text-align:right;"> 0.0467086 </td>
   <td style="text-align:right;"> 0.0392006 </td>
   <td style="text-align:right;"> 0.0462095 </td>
   <td style="text-align:right;"> 0.0403199 </td>
   <td style="text-align:right;"> 0.0430802 </td>
   <td style="text-align:right;"> 0.0437467 </td>
   <td style="text-align:right;"> 0.0461757 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAJ13 </td>
   <td style="text-align:right;"> 0.0248964 </td>
   <td style="text-align:right;"> 0.0265830 </td>
   <td style="text-align:right;"> 0.0226640 </td>
   <td style="text-align:right;"> 0.0267398 </td>
   <td style="text-align:right;"> 0.0276702 </td>
   <td style="text-align:right;"> 0.0248721 </td>
   <td style="text-align:right;"> 0.0264250 </td>
   <td style="text-align:right;"> 0.0233273 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAJ15 </td>
   <td style="text-align:right;"> 0.0361764 </td>
   <td style="text-align:right;"> 0.0470729 </td>
   <td style="text-align:right;"> 0.0400716 </td>
   <td style="text-align:right;"> 0.0490207 </td>
   <td style="text-align:right;"> 0.0367642 </td>
   <td style="text-align:right;"> 0.0459912 </td>
   <td style="text-align:right;"> 0.0447048 </td>
   <td style="text-align:right;"> 0.0373860 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAJ16 </td>
   <td style="text-align:right;"> 0.0181176 </td>
   <td style="text-align:right;"> 0.0138362 </td>
   <td style="text-align:right;"> 0.0118903 </td>
   <td style="text-align:right;"> 0.0132596 </td>
   <td style="text-align:right;"> 0.0122879 </td>
   <td style="text-align:right;"> 0.0132949 </td>
   <td style="text-align:right;"> 0.0136481 </td>
   <td style="text-align:right;"> 0.0136188 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAJ17 </td>
   <td style="text-align:right;"> 0.0254176 </td>
   <td style="text-align:right;"> 0.0262187 </td>
   <td style="text-align:right;"> 0.0229026 </td>
   <td style="text-align:right;"> 0.0265330 </td>
   <td style="text-align:right;"> 0.0272798 </td>
   <td style="text-align:right;"> 0.0278149 </td>
   <td style="text-align:right;"> 0.0288202 </td>
   <td style="text-align:right;"> 0.0248371 </td>
  </tr>
</tbody>
</table>


## Diversity estimation 

### Rarefaction analysis

![plot of chunk rarefaction](figure/rarefaction-1.png)




### Diversity indices

![plot of chunk div ind](figure/div ind-1.png)


























# One-sample analysis


### Clonal distribution per count intervals

![plot of chunk IndCountInt](figure/IndCountInt-1.png)


### V/J usage

![plot of chunk VJUsage](figure/VJUsage-1.png)







### Stacked spectratyping

![plot of chunk cd3 spectra](figure/cd3 spectra-1.png)


### Individual spectratyping

![plot of chunk cd3 spectra ind](figure/cd3 spectra ind-1.png)




































 
















































