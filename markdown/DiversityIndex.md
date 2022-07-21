---
title: "DiversityIndex"
author: "Grégoire Bohl"
date: "12 septembre 2018"
output: html_fragment
---
<div style="margin-top:100px;">

$n$ clonotypes and $p=\{p_1, p_2, ..., p_n\}$ a vector of proportion of clonotypes in a repertoire.

### Shannon
Shannon's diversity index quantifies the entropy of a repertoire
 within a repertoire, the Shannon's index ($H_S$) is defined as:
\[
H_S = \sum_{i=1}^n p_i\ln p_i
\]
with $\ln$, natural logarithm function (neperien)

### Simpson

Simpson's diversity Index  measures the probability that two individuals randomly selected from a sample will belong to the same species.

$$D = 1 - \sum_{i=1}^n p_{i}^2$$

The diversity is mininmum when $D =0$ and increases as $D$ approaches 1.

### Invsimpson

$$D = \frac{1}{\sum_{i=1}^n p_{i}^2}$$
The diversity is minimum when $D=1$  and increases as $D$ approaches the total number of species $n$.

### Gini

Gini's index is a meaure of statistical dispersion or equality.

$$G = \frac{n+1}{n} -\frac{2}{n}\sum_{i=1}^n i*p_i$$
where $\{p_1, p_2, \dots p_n\}$ is in increasing order.

An index nearing 0 means that a group of a few species greatly outnumber the rest (inequality), and an index of 1 means that $p_1 = p_2 = \dots = p_n$ (equality).



