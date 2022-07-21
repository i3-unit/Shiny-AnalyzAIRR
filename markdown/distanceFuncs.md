---
title: "DistanceFuncs.md"
author: "Gregoire Bohl"
date: "5 septembre 2018"
output: 
  html_fragment
    
---
<div style="margin-bottom:100px;">

*Uses vegdist from package vegan*

*Clustering tree performed using the Ward's method*

## Distance functions

$x_{ij}$ refers to the count of the species $i$ in the sample $j$

**euclidean**: $d_{jk} = \sqrt{\sum_{i=1}^{n}(x_{ij}-x_{ik})^2}$

**manhattan**:	$d_{jk} = \sum_{i=1}^{n}\mid x_{ij} - x_{ik}\mid$

**gower**:	$d_{jk} = \frac{1}{M} \sum_{i=1}^{n} \frac{\mid x_{ij}-x_{ik}\mid}{\max (x_{i})-\min (x_{i})}$
 where $M$ is the number of columns (excluding missing values)
 
**altGower**:	$d_{jk} = \frac{1}{NZ} \sum_{i=1}^{n} \mid x_{ij} - x_{ik} \mid$
 where $NZ$ is the number of non-zero columns excluding double-zeros (Anderson et al. 2006).

**canberra**:	$d_{jk} = \frac{1}{NZ} \sum_{i=1}^{n} \frac{\mid x_{ij}-x_{ik} \mid}{\mid x_{ij} \mid + \mid x_{ik} \mid}$
 where $NZ$ is the number of non-zero entries.
 
**clark**:	$d_{jk} = \sqrt{\frac{1}{NZ} \sum_{i=1}^{n} (\frac{x_{ij}-x_{ik}}{x_{ij}+x_{ik}})^2}$
 where $NZ$ is the number of non-zero entries.

**bray**:	$d_{jk} = \frac{\sum_{i=1}^{n} \mid x_{ij}-x_{ik} \mid}{\sum_{i=1}^{n} x_{ij}+x_{ik}}$

**kulczynski**:	$d_{jk} = 1 - 0.5*(\frac{\sum_{i=1}^{n} \min(x_{ij},x_{ik})}{\sum_{i=1}^{n} x_{ij}} + \frac{\sum_{i=1}^{n} \min(x_{ij},x_{ik})}{\sum_{i=1}^{n} x_{ik}})$

**morisita**:	$d_{jk} = 1 - 2*\frac{\sum_{i=1}^{n} x_{ij}*x_{ik}}{(\lambda_{j} + \lambda_{k}) * (\sum_{i=1}^{n} x_{ij}) * (\sum_{i=1}^{n} x_{ik})}$, where
$\lambda_{j} = \frac{\sum_{i=1}^{n} x_{ij}*(x_{ij}-1)}{(\sum_{i=1}^{n} x_{ij})*(\sum_{i=1}^{n} (x_{ij}-1))}$

**horn**:	 Like morisita, but $\lambda_{j} = \frac{\sum x_{ij}^2}{(\sum_{i=1}^{n} x_{ij})^2}$

**binomial**:	$d_{jk} = \sum_{i=1}^{n} (x_{ij}*\log (\frac{x_{ij}}{n_i}) + x_{ik}*\log(\frac{x_{ik}}{n_i}) + n_i*\frac{\log(2)}{n_i})$,
 where $n_i = x_{ij} + x_{ik}$

**cao**:	$d_{jk} = \frac{1}{S} * \sum_{i=1}^{n} (\log(\frac{n_i}{2}) - (x_{ij}*\log(x_{ik}) + x_{ik}*\frac{\log(x_{ij}))}{n[i]})$,
 where $S$ is the number of species in compared sites and $n_i = x_{ij} + x_{ik}$
