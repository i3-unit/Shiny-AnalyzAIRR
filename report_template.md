---
title: "Report session"
author:
- name: V. Mhanna, G. Pires, N. Tchitchek, D. Klatzmann, A. Six, E. Mariotti-Ferrandiz
  affiliation: Sorbonne Université, INSERM, Immunology-Immunopathology-Immunotherapy (i3), Paris, France
- name: H. P. Pham
  affiliation: Parean Biotechnologies
output: html_document
---



This file is generated automatically, this is a summary report of your actions on Shiny AnalyzAIRR.

# Data manipulation
## Data extraction

**Assay data**
<table class="table" style="font-size: 10px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> sample_id </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> CDR3nt </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> CDR3aa </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> V </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> J </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> VJ </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> clone </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> clonotype </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> count </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> TGTGCAGCAAGTAGGGCTTCAAGTGGCCAGAAGCTGGTTTTT </td>
   <td style="text-align:left;"> CAASRASSGQKLVF </td>
   <td style="text-align:left;"> TRAV14N-3 </td>
   <td style="text-align:left;"> TRAJ16 </td>
   <td style="text-align:left;"> TRAV14N-3 TRAJ16 </td>
   <td style="text-align:left;"> TRAV14N-3 CAASRASSGQKLVF TRAJ16 </td>
   <td style="text-align:left;"> TGTGCAGCAAGTAGGGCTTCAAGTGGCCAGAAGCTGGTTTTT TRAV14N-3 CAASRASSGQKLVF TRAJ16 </td>
   <td style="text-align:right;"> 2002 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> TGTGCTACTGATGGAAGAGGTTCAGCCTTAGGGAGGCTGCATTTT </td>
   <td style="text-align:left;"> CATDGRGSALGRLHF </td>
   <td style="text-align:left;"> TRAV8-1 </td>
   <td style="text-align:left;"> TRAJ18 </td>
   <td style="text-align:left;"> TRAV8-1 TRAJ18 </td>
   <td style="text-align:left;"> TRAV8-1 CATDGRGSALGRLHF TRAJ18 </td>
   <td style="text-align:left;"> TGTGCTACTGATGGAAGAGGTTCAGCCTTAGGGAGGCTGCATTTT TRAV8-1 CATDGRGSALGRLHF TRAJ18 </td>
   <td style="text-align:right;"> 1619 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> TGTGCTGCAAGTAATAGCAATAACAGAATCTTCTTT </td>
   <td style="text-align:left;"> CAASNSNNRIFF </td>
   <td style="text-align:left;"> TRAV5-4 </td>
   <td style="text-align:left;"> TRAJ31 </td>
   <td style="text-align:left;"> TRAV5-4 TRAJ31 </td>
   <td style="text-align:left;"> TRAV5-4 CAASNSNNRIFF TRAJ31 </td>
   <td style="text-align:left;"> TGTGCTGCAAGTAATAGCAATAACAGAATCTTCTTT TRAV5-4 CAASNSNNRIFF TRAJ31 </td>
   <td style="text-align:right;"> 1446 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> TGTGCTGCAGCGGATTCTGGGACTTACCAGAGGTTT </td>
   <td style="text-align:left;"> CAAADSGTYQRF </td>
   <td style="text-align:left;"> TRAV5D-4 </td>
   <td style="text-align:left;"> TRAJ13 </td>
   <td style="text-align:left;"> TRAV5D-4 TRAJ13 </td>
   <td style="text-align:left;"> TRAV5D-4 CAAADSGTYQRF TRAJ13 </td>
   <td style="text-align:left;"> TGTGCTGCAGCGGATTCTGGGACTTACCAGAGGTTT TRAV5D-4 CAAADSGTYQRF TRAJ13 </td>
   <td style="text-align:right;"> 903 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> TGTGCTCTGGGTGAGCCTGGAGGCTATAAAGTGGTCTTT </td>
   <td style="text-align:left;"> CALGEPGGYKVVF </td>
   <td style="text-align:left;"> TRAV6-6 </td>
   <td style="text-align:left;"> TRAJ12 </td>
   <td style="text-align:left;"> TRAV6-6 TRAJ12 </td>
   <td style="text-align:left;"> TRAV6-6 CALGEPGGYKVVF TRAJ12 </td>
   <td style="text-align:left;"> TGTGCTCTGGGTGAGCCTGGAGGCTATAAAGTGGTCTTT TRAV6-6 CALGEPGGYKVVF TRAJ12 </td>
   <td style="text-align:right;"> 839 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> TGTGCAGCCAGGGGGAATTATAACCAGGGGAAGCTTATCTTT </td>
   <td style="text-align:left;"> CAARGNYNQGKLIF </td>
   <td style="text-align:left;"> TRAV7-2 </td>
   <td style="text-align:left;"> TRAJ23 </td>
   <td style="text-align:left;"> TRAV7-2 TRAJ23 </td>
   <td style="text-align:left;"> TRAV7-2 CAARGNYNQGKLIF TRAJ23 </td>
   <td style="text-align:left;"> TGTGCAGCCAGGGGGAATTATAACCAGGGGAAGCTTATCTTT TRAV7-2 CAARGNYNQGKLIF TRAJ23 </td>
   <td style="text-align:right;"> 788 </td>
  </tr>
</tbody>
</table>

**Metadata**
<table class="table" style="font-size: 10px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;">   </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> sample_id </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> cell_subset </th>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> sex </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> nSequences </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> CDR3nt </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> CDR3aa </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> V </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> J </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> VJ </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> clone </th>
   <th style="text-align:right;color: #022f5a !important;font-size: 12px;"> clonotype </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> tripod-30-813 </td>
   <td style="text-align:left;"> amTreg </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:right;"> 394022 </td>
   <td style="text-align:right;"> 63843 </td>
   <td style="text-align:right;"> 44113 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 3586 </td>
   <td style="text-align:right;"> 57506 </td>
   <td style="text-align:right;"> 63843 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-30-815 </td>
   <td style="text-align:left;"> tripod-30-815 </td>
   <td style="text-align:left;"> nTreg </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:right;"> 585691 </td>
   <td style="text-align:right;"> 110725 </td>
   <td style="text-align:right;"> 69281 </td>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 3748 </td>
   <td style="text-align:right;"> 97008 </td>
   <td style="text-align:right;"> 110725 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-31-846 </td>
   <td style="text-align:left;"> tripod-31-846 </td>
   <td style="text-align:left;"> amTreg </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 867579 </td>
   <td style="text-align:right;"> 83597 </td>
   <td style="text-align:right;"> 55706 </td>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 3692 </td>
   <td style="text-align:right;"> 74169 </td>
   <td style="text-align:right;"> 83597 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-31-848 </td>
   <td style="text-align:left;"> tripod-31-848 </td>
   <td style="text-align:left;"> nTreg </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:right;"> 606692 </td>
   <td style="text-align:right;"> 111273 </td>
   <td style="text-align:right;"> 69677 </td>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 3757 </td>
   <td style="text-align:right;"> 97504 </td>
   <td style="text-align:right;"> 111273 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-35-970 </td>
   <td style="text-align:left;"> tripod-35-970 </td>
   <td style="text-align:left;"> amTreg </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:right;"> 950774 </td>
   <td style="text-align:right;"> 42172 </td>
   <td style="text-align:right;"> 30754 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 3377 </td>
   <td style="text-align:right;"> 38342 </td>
   <td style="text-align:right;"> 42172 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tripod-35-972 </td>
   <td style="text-align:left;"> tripod-35-972 </td>
   <td style="text-align:left;"> nTreg </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:right;"> 988375 </td>
   <td style="text-align:right;"> 105737 </td>
   <td style="text-align:right;"> 66743 </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 3792 </td>
   <td style="text-align:right;"> 92848 </td>
   <td style="text-align:right;"> 105737 </td>
  </tr>
</tbody>
</table>






**History data**
<table class="table" style="font-size: 10px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;color: #022f5a !important;font-size: 12px;"> history </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> data directory=/home/GPI/R/x86_64-pc-linux-gnu-library/4.1/RepSeq/extdata/mixcr </td>
  </tr>
  <tr>
   <td style="text-align:left;"> readAIRRSet; cores=1; fileFormat=MiXCR; chain=TRA; ambiguous FALSE; unprod FALSE; filter.singletonsFALSE; aa threshold=8; raretabFALSE </td>
  </tr>
</tbody>
</table>








































































































































































 
















































