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

<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
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

<img src="figure/metadata stats-1.png" title="plot of chunk metadata stats" alt="plot of chunk metadata stats" style="display: block; margin: auto;" />


### Detailed repertoire level statistics

<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
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

<img src="figure/rarefaction-1.png" title="plot of chunk rarefaction" alt="plot of chunk rarefaction" style="display: block; margin: auto;" />

<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> sample_id </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> x </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> y </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 5000 </td>
   <td style="text-align:right;"> 3932.034 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 10000 </td>
   <td style="text-align:right;"> 6949.143 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 15000 </td>
   <td style="text-align:right;"> 9508.853 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 20000 </td>
   <td style="text-align:right;"> 11758.099 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 25000 </td>
   <td style="text-align:right;"> 13773.018 </td>
  </tr>
</tbody>
</table>


### Diversity indices

<img src="figure/div ind-1.png" title="plot of chunk div ind" alt="plot of chunk div ind" style="display: block; margin: auto;" />

<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> sample_id </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> shannon </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> simpson </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> invsimpson </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> bergerparker </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> gini </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> chao1 </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> chao1.se </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> iChao </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:right;"> 3.58 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 31.34 </td>
   <td style="text-align:right;"> 2.73 </td>
   <td style="text-align:right;"> 0.34 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> NaN </td>
   <td style="text-align:right;"> 43 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-815 </td>
   <td style="text-align:right;"> 3.56 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 30.11 </td>
   <td style="text-align:right;"> 2.74 </td>
   <td style="text-align:right;"> 0.37 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> NaN </td>
   <td style="text-align:right;"> 44 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-31-846 </td>
   <td style="text-align:right;"> 3.58 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 31.62 </td>
   <td style="text-align:right;"> 2.76 </td>
   <td style="text-align:right;"> 0.34 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> NaN </td>
   <td style="text-align:right;"> 43 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-31-848 </td>
   <td style="text-align:right;"> 3.56 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 30.43 </td>
   <td style="text-align:right;"> 2.75 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> NaN </td>
   <td style="text-align:right;"> 43 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-35-970 </td>
   <td style="text-align:right;"> 3.58 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 31.48 </td>
   <td style="text-align:right;"> 2.72 </td>
   <td style="text-align:right;"> 0.35 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 44 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-35-972 </td>
   <td style="text-align:right;"> 3.56 </td>
   <td style="text-align:right;"> 0.97 </td>
   <td style="text-align:right;"> 29.93 </td>
   <td style="text-align:right;"> 2.70 </td>
   <td style="text-align:right;"> 0.38 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 44 </td>
  </tr>
</tbody>
</table>
























# One-sample analysis


### Clonal distribution per count intervals

<img src="figure/IndCountInt-1.png" title="plot of chunk IndCountInt" alt="plot of chunk IndCountInt" style="display: block; margin: auto;" />


### V/J usage

<img src="figure/VJUsage-1.png" title="plot of chunk VJUsage" alt="plot of chunk VJUsage" style="display: block; margin: auto;" />







### Stacked spectratyping

<img src="figure/cd3 spectra-1.png" title="plot of chunk cd3 spectra" alt="plot of chunk cd3 spectra" style="display: block; margin: auto;" />


### Individual spectratyping

<img src="figure/cd3 spectra ind-1.png" title="plot of chunk cd3 spectra ind" alt="plot of chunk cd3 spectra ind" style="display: block; margin: auto;" />


# Multi-sample analysis


## Comparison of basic statistics


### Metadata statistics

<img src="figure/stats-1.png" title="plot of chunk stats" alt="plot of chunk stats" style="display: block; margin: auto;" />

























 

## Similarity analysis


### Repertoire overlap

<img src="figure/eulerr-1.png" title="plot of chunk eulerr" alt="plot of chunk eulerr" style="display: block; margin: auto;" />


### Repertoire correlation

<img src="figure/scatter-1.png" title="plot of chunk scatter" alt="plot of chunk scatter" style="display: block; margin: auto;" />













## Differential analysis


### Volcano plot

<img src="figure/volcano-1.png" title="plot of chunk volcano" alt="plot of chunk volcano" style="display: block; margin: auto;" />


<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;">   </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> baseMean </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> log2FoldChange </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> lfcSE </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> stat </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> pvalue </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> padj </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> TRAV7-6 </td>
   <td style="text-align:right;"> 6251.744 </td>
   <td style="text-align:right;"> 0.9937186 </td>
   <td style="text-align:right;"> 0.1337337 </td>
   <td style="text-align:right;"> 7.430575 </td>
   <td style="text-align:right;"> 0.0e+00 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV12D-2 </td>
   <td style="text-align:right;"> 9116.894 </td>
   <td style="text-align:right;"> -0.5925154 </td>
   <td style="text-align:right;"> 0.0912763 </td>
   <td style="text-align:right;"> -6.491451 </td>
   <td style="text-align:right;"> 0.0e+00 </td>
   <td style="text-align:right;"> 0.0000000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV16N </td>
   <td style="text-align:right;"> 7339.963 </td>
   <td style="text-align:right;"> 0.3887531 </td>
   <td style="text-align:right;"> 0.0823287 </td>
   <td style="text-align:right;"> 4.721964 </td>
   <td style="text-align:right;"> 2.3e-06 </td>
   <td style="text-align:right;"> 0.0000833 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV12D-3 </td>
   <td style="text-align:right;"> 19660.901 </td>
   <td style="text-align:right;"> -0.5489695 </td>
   <td style="text-align:right;"> 0.1237422 </td>
   <td style="text-align:right;"> -4.436398 </td>
   <td style="text-align:right;"> 9.1e-06 </td>
   <td style="text-align:right;"> 0.0001958 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV6-1 </td>
   <td style="text-align:right;"> 1931.017 </td>
   <td style="text-align:right;"> -0.6503107 </td>
   <td style="text-align:right;"> 0.1461466 </td>
   <td style="text-align:right;"> -4.449716 </td>
   <td style="text-align:right;"> 8.6e-06 </td>
   <td style="text-align:right;"> 0.0001958 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV9-4 </td>
   <td style="text-align:right;"> 5263.095 </td>
   <td style="text-align:right;"> 0.7664754 </td>
   <td style="text-align:right;"> 0.1806185 </td>
   <td style="text-align:right;"> 4.243614 </td>
   <td style="text-align:right;"> 2.2e-05 </td>
   <td style="text-align:right;"> 0.0003922 </td>
  </tr>
</tbody>
</table>







## Spectractyping comparison

<img src="figure/spectratyping comparison HM-1.png" title="plot of chunk spectratyping comparison HM" alt="plot of chunk spectratyping comparison HM" style="display: block; margin: auto;" />

<table class="table" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;">   </th>
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
   <td style="text-align:left;"> TRAV1 </td>
   <td style="text-align:right;"> 0.1233174 </td>
   <td style="text-align:right;"> 0.2595676 </td>
   <td style="text-align:right;"> 0.1761656 </td>
   <td style="text-align:right;"> 0.2036673 </td>
   <td style="text-align:right;"> 0.2297684 </td>
   <td style="text-align:right;"> 0.2454485 </td>
   <td style="text-align:right;"> 0.2048730 </td>
   <td style="text-align:right;"> 0.2660465 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV10 </td>
   <td style="text-align:right;"> 0.0780131 </td>
   <td style="text-align:right;"> 0.1565013 </td>
   <td style="text-align:right;"> 0.1443946 </td>
   <td style="text-align:right;"> 0.1375075 </td>
   <td style="text-align:right;"> 0.2080023 </td>
   <td style="text-align:right;"> 0.1237649 </td>
   <td style="text-align:right;"> 0.1381364 </td>
   <td style="text-align:right;"> 0.0986161 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV10D </td>
   <td style="text-align:right;"> 0.2404412 </td>
   <td style="text-align:right;"> 0.1489279 </td>
   <td style="text-align:right;"> 0.2202294 </td>
   <td style="text-align:right;"> 0.1357081 </td>
   <td style="text-align:right;"> 0.4263890 </td>
   <td style="text-align:right;"> 0.2470745 </td>
   <td style="text-align:right;"> 0.1674991 </td>
   <td style="text-align:right;"> 0.2200544 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV10N </td>
   <td style="text-align:right;"> 0.2661125 </td>
   <td style="text-align:right;"> 0.2018136 </td>
   <td style="text-align:right;"> 0.1496481 </td>
   <td style="text-align:right;"> 0.2711086 </td>
   <td style="text-align:right;"> 0.2938385 </td>
   <td style="text-align:right;"> 0.3085668 </td>
   <td style="text-align:right;"> 0.1492038 </td>
   <td style="text-align:right;"> 0.2035064 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV11 </td>
   <td style="text-align:right;"> 0.1802109 </td>
   <td style="text-align:right;"> 0.1551112 </td>
   <td style="text-align:right;"> 0.2309464 </td>
   <td style="text-align:right;"> 0.2412830 </td>
   <td style="text-align:right;"> 0.1420020 </td>
   <td style="text-align:right;"> 0.1535469 </td>
   <td style="text-align:right;"> 0.2181467 </td>
   <td style="text-align:right;"> 0.1198002 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TRAV11N </td>
   <td style="text-align:right;"> 0.5213702 </td>
   <td style="text-align:right;"> 0.4436893 </td>
   <td style="text-align:right;"> 0.1981263 </td>
   <td style="text-align:right;"> 0.5674222 </td>
   <td style="text-align:right;"> 0.1651129 </td>
   <td style="text-align:right;"> 0.5353697 </td>
   <td style="text-align:right;"> 0.3580757 </td>
   <td style="text-align:right;"> 0.6886480 </td>
  </tr>
</tbody>
</table>


