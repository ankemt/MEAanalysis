match_MEA_files <- function(header1, header2){
  header1 <- header1[complete.cases(header1),] # removes rows with NAs
  header2 <- header2[complete.cases(header2),]

  return(all(header1 == header2))
}

match_MEA_design <- function(designmeta, file){
  n_wells <- as.numeric(designmeta$Total_wells)
  n_wells_file <- length(unique(file$`Well averages`$ID))

  if(n_wells_file > n_wells){
    stop("The design file has fewer wells than the MEA file(s) provided. Please check the files and try again.")
  } else if(n_wells_file < n_wells){
    warning("Not all wells in the design file have corresponding data. Are you sure the files are correct?")
  }
}
