start_year = 2006
end_year = 2016

# Clean up ebird frequency matrix into a usable form
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

# Moising ebird calls for faster simulations
m_ebird_freqs <- memoise(
  ebirdfreq,
  cache = cache_filesystem("cache/freqs")
)

# Calculate (and clean) an ebird frequency matrix for a location
calculate_frequencies <- function(location) {
  res <- m_ebird_freqs(
    "states",
    paste0("US-",location),
    long = FALSE,
    startyear = start_year,
    endyear = end_year
  )
  clean_freqs(res)
}

# Calculate how frequent are each species at a location based on an ebird frequency matrix
calculate_species_frequencies <- function(location) {
  freqs <- calculate_frequencies(location)
  tibble(
    species = rownames(freqs),
    frequency = as.numeric(rowSums(freqs > 0)/48),
    location = location
  )

}
