# Implementation of the Horn index of dissimilarity

library(testthat)
# Testing calculation with data from : http://www.zoology.ubc.ca/~krebs/downloads/krebs_chapter_12_2014.pdf

nelson <- matrix(
  data = c(53.3,0.9,18.8,20.7,10.5,14.2,9.8,5.2,9.6,17.9,2.9,13.0,2.0,3.7,1.5,6.9),
  byrow = TRUE,
  ncol = 2
)
rownames(nelson) <- c("Chestnut", "Hickory", "Chestnut oak", "Northern red oak", "Black oak", "Yellow poplar", "Red maple", "Scarlet oak")
colnames(nelson) <- c("1934", "1953")
colSums(nelson)

# Implementation of the Horn index of similarity
horn <- function(site1, site2) {

#  site1 <- nelson[,1]
#  site2 <- nelson[,2]

  a <- sum((site1 + site2) * log10(site1 + site2))
  b <- sum(site1*log10(site1))
  c <- sum(site2*log10(site2))

  d2 <- sum(site1) + sum(site2)

  d <- d2  * log10(d2)
  e <- sum(site1)*log10(sum(site1))
  f <- sum(site2)*log10(sum(site2))

  (a - b - c) / (d - e - f)

}

expect_equal(horn(nelson[,1], nelson[,2]), 0.7, tolerance = 0.001)
