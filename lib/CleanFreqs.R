clean_freqs <- function(res) {
  freqs <- as.matrix(
    res[-1,-1]
  )

  colnames(freqs) <- colnames(res)[-1]
  rownames(freqs) <- res$comName[-1]

  to_remove <- "sp\\.|/|domestic|hybrid|Domestic"

  sp_names <- rownames(freqs)

  freqs <- freqs[!str_detect(sp_names,to_remove),]
}
