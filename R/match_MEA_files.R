match_MEA_files <- function(header1, header2){
  header1 <- header1[stats::complete.cases(header1),] # removes rows with NAs
  header2 <- header2[stats::complete.cases(header2),]

  if(!all(header1 == header2)){
  stop("The MEA files provided have different metadata attributes and cannot be compared.\
    Did you provide the correct baseline and exposure files?")
  }
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
