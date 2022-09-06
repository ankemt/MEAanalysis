#' Parse designfile
#'
#' Parses a text file containing the design of the
#'
#' @param path the location of the design file on the path
#'
#' @return list with two objects: metadata, containing information on the experiment
#' and design, containing a dataframe with cells and corresponding groups.
#'
#' @export
parse_designfile <- function(path){
  info = brio::readLines(path)
  # prep metadata
  metadata <- NULL
  metadata_names <- c("Date", "ExperimentID", "Total_wells")

  for(i in info){
    # remove any lines that start with #
    if(stringr::str_starts(i, "#")){next}

    i <- stringr::str_split(i, " ")
    print(i[1]) #this does not work? why?
    i[1]%in%metadata_names
    # get date, experimentID, total_wells
    if(i[1] %in% metadata_names){
      rbind(metadata, i)
      print(metadata)
    }

    # get groups

  }


  design <- "1"

  designlist <- list(metadata, design)
  return(designlist)
}
