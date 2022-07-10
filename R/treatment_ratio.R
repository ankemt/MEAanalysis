#' Calculate the treatment ratio between exposure and baseline of MEA output files
#' (Currently incomplete)
#'
#' @param exposurepath Path to file with exposure data
#' @param baselinepath Path to file with baseline data
#' @param treatmentpath Path to file with treatment lay-out
#' @return file with [1] treatment ratio per parameter per well
#' @export
treatment_ratio <- function(exposurepath, baselinepath, treatmentpath){
  exposure <- parse_MEA_file(exposurepath)
  baseline <- parse_MEA_file(baselinepath)

  # TODO calculate differences
  # TODO parse treatment information
  # write file
  # should this function create the file and return the path, or open the file?

  return(resultfile)
}

