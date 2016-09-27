library(rebird)
library(vegan)
#res <- ebirdfreq("states","CA-QC", long = FALSE)
# Montreal test data
res <- ebirdfreq("counties","CA-QC-MR", long = FALSE)
res

freqs <- as.matrix(
  res[-1,-1]
)

colnames(freqs) <- colnames(res)[-1]
rownames(freqs) <- res$comName[-1]

sim_obs <- t(matrix(
  data = rbinom(length(freqs),8,freqs),
  ncol = ncol(freqs),
  nrow = nrow(freqs),
  dimnames = list(rownames(freqs), colnames(freqs))
))

(alpha <- mean(specnumber(sim_obs)))
(gamma <- specnumber(sim_obs, c(1)))
(beta <- gamma / alpha)
(absolute_turnover <- gamma - alpha)
(whittaker <- gamma / alpha - 1)
(proportional <- 1 - alpha / gamma)
