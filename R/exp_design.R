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
#' @export
exp_design <- function(date = readline(prompt="What is the date of the experiment? "),
                       expID = readline(prompt="What is the experiment ID? "),
                       path="./design.txt"){
  nwells <- 48 # TODO make this a question also

  write_meta(date, expID, nwells, path)

  # TODO make this a while loop where wells are scored instead of a Q/A
  continue <- TRUE
  while(continue){
    write_category(nwells=nwells, path=path)
    check_cont <- readline(prompt = "Do you want to add another group? (y/n) ")
    continue <- stringr::str_detect(check_cont, "y|Y")
  }
}


write_meta <- function(date, expID, nwells, path){
  meta <- paste0("Date: ", date, "\n",
                 "ExperimentID: ", expID, "\n",
                 "Total_wells: ", nwells, "\n",
                 "Groups:")
  write(meta, file=path)
}

write_category <- function(
    group = readline(prompt="What is the group name? "),
    start = readline(prompt="What is the first well in this category? "),
    end = readline(prompt="What is the last well in this category? "),
    dirx = readline(
      prompt="In what direction ('LR' for left-to-right or 'TB' for top-to-bottom) is the sequence of wells? "),
    nwells, path){
  groupname <- paste0(group, ":") # hacky way to make sure the group question is asked first
  wells <- categorize_wells(start, end, nwells, direction=dirx)
  write(paste(groupname, wells), file=path, append=TRUE)
}


#' Create well ranges for a design file
#'
#' @param start First well ID (e.g. "A1")
#' @param end Last well ID (e.g "B7")
#' @param nwells Total number of wells on the plate (currently only 48)
#' @param direction TB for top-to-bottom or LR for left-to-right
#'
#' @return string with a range of well IDs
#' @export
#'
#' @examples
#' # Wells from left to right, starting at A1 and ending at B4
#' categorize_wells("A1", "B4")
#' # Wells from top to bottom, starting at A1 and ending at B4
#' categorize_wells("A1", "B4", direction="TB")
categorize_wells <- function(start, end, nwells, direction = "LR"){
  assertthat::assert_that(direction %in% c("LR", "TB"),
                          msg = "The direction must be LR (left-to-right), or TB (top-to-bottom).")

  nwells <- as.integer(nwells)
  assertthat::assert_that(nwells %in% c(48), #TODO: add other options like c(6, 12, 24, 48, 96),
                          msg = "The total number of wells on the plate (`nwells`) is incorrect.")

  rowtotal <- 6
  coltotal <- 8
  allcols <- 1:coltotal
  allrows <- LETTERS[1:rowtotal]

  startrow = stringr::str_extract(start, "[:alpha:]")
  startcol = as.numeric(stringr::str_extract(start, "[:digit:]"))
  endrow = stringr::str_extract(end, "[:alpha:]")
  endcol = as.numeric(stringr::str_extract(end, "[:digit:]"))

  rows <- LETTERS[letter_as_number(startrow):letter_as_number(endrow)]
  cols <- startcol:endcol

  wells <- NULL

  if(direction == "LR"){
    for(row in rows) wells <- c(wells, paste0(row, allcols))
    removecols <- length(wells) - (max(allcols) - endcol)
    wells <- wells[startcol:removecols]
  } else if(direction == "TB"){
    for(col in cols) wells <- c(wells, paste0(allrows, col))
    maxrow <- max(letter_as_number(allrows))
    removerows <- length(wells) - (maxrow - letter_as_number(endrow))
    wells <- wells[letter_as_number(startrow):removerows]
  }

  wells <- paste(wells, collapse = " ")
  return(wells)
}

letter_as_number <- function(letter) as.numeric(stats::setNames(1:26, LETTERS)[letter])


