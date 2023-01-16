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


categorize_wells <- function(start, end, nwells = 48, direction = "LR"){
  assertthat::assert_that(direction %in% c("LR", "TB"),
                          msg = "The direction must be LR (left-to-right), or TB (top-to-bottom).")

  assertthat::assert_that(typeof(nwells) == "double",
                          msg = "`nwells` should be a number.")

  assertthat::assert_that(nwells%%12 == 0, # or: should be either 12, 24, 48 or 96?
                          msg = "The total number of wells on the plate (`nwells`) does not seem correct.")

  startcol = stringr::str_extract(start, "[:alpha:]")
  startrow = stringr::str_extract(start, "[:digit:]")
  endcol = stringr::str_extract(end, "[:alpha:]")
  endrow = stringr::str_extract(end, "[:digit:]")

  #

  #return(wells)
}
