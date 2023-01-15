#' Generate experimental design file
#'
#' With information provided by the user, a file is created
#' that formalizes the experimental design so it can be used to
#' analyse the MEA file.
#'
#' @param date date (string, preferably formatted as YYYYMMDD)
#' @param expID identifier for the experiment (string)
#' @param dir directory where the file should be saved
#'
#' @return
#' @export
exp_design <- function(date, expID, dir="."){
  path <- paste0(dir, "/", "design.txt")
  nwells <- 48
  meta <- paste0("Date: ", date, "\n",
                "ExperimentID: ", expID, "\n",
                "Total_wells:", nwells, "\n",
                "Groups:\n")
  writeLines(meta, con=path)
}
