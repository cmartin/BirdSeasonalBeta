rm(list = ls())
load("data/US_Diversity.RData")

m <- lm(beta~sqrt(var_alpha), data = res)

hist(resid(m))

plot(
  res$beta~sqrt(res$var_alpha),
  xlab = "Richness SD",
  ylab = "Seasonal beta"
)
abline(m)
summary(m)

cor(
  res$beta,
  sqrt(res$var_alpha),
  method = "spearman"
)
