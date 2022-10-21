#' Match the headers of two MEA files to confirm that they can be compared
#'
#' @param header1 header of the first MEA parsed file
#' @param header2 header of the second MEA parsed file
#' @param designpath Path to file with treatment lay-out
#' @return boolean (TRUE/FALSE) that indicates whether files can be compared
#' @export
match_MEA_files <- function(header1, header2){
  header1 <- header1[complete.cases(header1),] # removes rows with NAs
  header2 <- header2[complete.cases(header2),]

  return(all(header1 == header2))
}

