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

horn <- function(m) {
  0
}

expect_equal(horn(nelson), 0.7)
