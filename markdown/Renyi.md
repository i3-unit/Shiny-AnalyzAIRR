---
title: "Renyi"
author: "Grégoire Bohl"
date: "12 septembre 2018"
output: html_fragment
---



### Renyi profiles
Renyi's entropy is a generalization of Shannon's entropy:

$$^{\alpha}H = \frac{1}{1-\alpha}\ln \left(\sum_{i=1}^{n}p_i^\alpha \right)$$


when $\alpha=0$, we have the species *evenness* $J$, 
when $\alpha=1$, Renyi index is equal to Shannon's index.

When varying $\alpha$ we obtained a Renyi's profile. We computed the Renyi's profiles for $\alpha \in [0, ..., Inf ]$.

 ### Eveness
Species evenness quantifies how close in number each clonotype in a repertoire, The evenness of a repertoire is  represented by the Pielou's index:
\[
J = \frac{H_S}{H_{max}}
\]
with $H_{max}=log(n)$ and $H_S$ the Shannon's index.
