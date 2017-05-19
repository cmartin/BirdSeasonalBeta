---
output:
  html_document:
    highlight: haddock
    theme: readable
---

# Companion code for *Bird seasonal beta-diversity in the contiguous United States*.

Author : Charles A. Martin

Contact : charles.martin1@uqtr.ca

Affiliation : Université du Québec à Trois-Rivières

## About
This repository contains all code necessary to reproduce the results from *Bird seasonal beta-diversity in the contiguous United States*, as published in Journal of Ornithology

## Structure
All analysis code is in the `scripts` folder, along with the database preparation script (the latest database, as of the publication of the paper, is already in the `data` folder).

## Necessary environment
The code provided was developed and tested under the following R environment : 
```
> sessionInfo()
R version 3.3.2 (2016-10-31)
Platform: x86_64-apple-darwin13.4.0 (64-bit)
Running under: macOS Sierra 10.12.4

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods  
[8] base     

other attached packages:
 [1] maps_3.1.1      egg_0.1.0       gridExtra_2.2.1 modelr_0.1.0   
 [5] testthat_1.0.2  raster_2.5-8    sp_1.2-4        betapart_1.4-1 
 [9] vegan_2.4-2     lattice_0.20-34 permute_0.9-4   stringr_1.2.0  
[13] rebird_0.4.0    memoise_1.1.0   MuMIn_1.15.6    dplyr_0.5.0    
[17] purrr_0.2.2     readr_1.0.0     tidyr_0.6.1     tibble_1.2     
[21] ggplot2_2.2.1   tidyverse_1.1.1

loaded via a namespace (and not attached):
 [1] reshape2_1.4.2   haven_1.0.0      colorspace_1.3-2 geometry_0.3-6  
 [5] stats4_3.3.2     mgcv_1.8-17      foreign_0.8-67   DBI_0.5-1       
 [9] readxl_0.1.1     plyr_1.8.4       munsell_0.4.3    gtable_0.2.0    
[13] rvest_0.3.2      psych_1.6.12     labeling_0.3     forcats_0.2.0   
[17] magic_1.5-6      rcdd_1.1-13      parallel_3.3.2   broom_0.4.2     
[21] Rcpp_0.12.9      scales_0.4.1     jsonlite_1.3     picante_1.6-2   
[25] mnormt_1.5-5     hms_0.3          digest_0.6.12    stringi_1.1.2   
[29] rgdal_1.2-5      tools_3.3.2      magrittr_1.5     lazyeval_0.2.0  
[33] cluster_2.0.5    crayon_1.3.2     ape_4.1          MASS_7.3-45     
[37] Matrix_1.2-8     xml2_1.1.1       lubridate_1.6.0  assertthat_0.1  
[41] httr_1.2.1       R6_2.2.0         nlme_3.1-131    
```

# Additional acknowledgements

As this paper was published as a short communication with a maximum of 15 references, it was not possible to ackowledge the quality of the R developers involved with the development and maintenance of all these wonderful packages with citations.

Nevertheless, without your dedicated work, none of this would have been possible.
