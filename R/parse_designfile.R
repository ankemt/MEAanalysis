#' Parse designfile
#'
#' Parses a text file containing the design of the experimental setup.
#'
#' @param path the location of the design file on the path
#'
#' @return list with two objects: metadata, containing information on the experiment
#' and design, containing a dataframe with cells and corresponding groups.
#'
#' @export
parse_designfile <- function(path){
  info <- brio::readLines(path)

  metadata_names <- c("Date", "ExperimentID", "Total_wells")

  # make objects to fill
  metadata <- NULL
  designlist <- NULL

  for(i in info){
    if(stringr::str_starts(i, "#")){next} # remove any lines that start with #

    i <- stringr::str_split(i, " ", simplify=TRUE)

    # get date, experimentID, total_wells
    if(i[1] %in% metadata_names){
      metadata <- rbind(metadata,i)
    }

    # get groups

  }

  metadata <- make_meta_df(metadata)

  designlist <- list("metadata" = metadata,
                     "design" = design)
  return(designlist)
}


make_meta_df <- function(df){
  df <- t(df)
  df <- as.data.frame(df)
  names(df) <- df[1,]
  df <- df[2,]
  row.names(df) <- NULL # otherwise the row number is 2
  #TODO type of date and number is a character, fix this?
  return(df)
}

