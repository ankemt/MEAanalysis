#' Parse design file
#'
#' Parses a text file containing the design of the experiment.
#'
#' @param path the location of the design file on the path
#'
#' @return list with two objects: `metadata`, containing information on the experiment
#' and `design`, containing a dataframe with wells and corresponding groups.
#'
#' @export
parse_designfile <- function(path){
  info <- brio::readLines(path)

  metadata_names <- c("Date", "ExperimentID", "Total_wells")

  # make objects to fill
  designlist <- NULL
  metadata <- NULL
  design <- NULL

  for(i in info){
    if(stringr::str_starts(i, "#")){next} # remove any lines that start with #

    i <- stringr::str_split(i, " ", simplify=TRUE)

    # get date, experimentID, total_wells
    if(i[1] %in% metadata_names){
      metadata <- rbind(metadata,i)
    } else{
      if(length(i) > 2){
        design <- rbind(design, i)
      }
    }
    # get groups

  }

  metadata <- rotate_to_df(metadata)
  design <- make_design_df(design)

  designlist <- list("metadata" = metadata,
                     "design" = design)
  return(designlist)
}


rotate_to_df <- function(df){
  df <- t(df)
  df <- as.data.frame(df)
  names(df) <- df[1,]
  df <- df[-1,]
  row.names(df) <- NULL # otherwise the row number is 2
  #TODO type of date and number is a character, fix this?
  return(df)
}


make_design_df <- function(df){
  # ensure the first two columns are empty, before removing them
  if(paste(df[,1],collapse="") != "" |
     paste(df[,2],collapse="") != ""){
    stop("Experimental design is unclear. Ensure that every group is preceded by two spaces.")
  }
  df <- df[,-c(1,2)]

  df <- rotate_to_df(df)

  # pivot to two columns and sort
  df <- tidyr::pivot_longer(df,
                            cols = tidyr::everything(),
                            names_to = "Group",
                            values_to = "Well")
  #TODO: make_design_df: no visible binding for global variable ‘Well’
  #TODO: make_design_df: no visible binding for global variable ‘Group’
  df <- dplyr::select(df, Well, Group)
  df <- dplyr::arrange(df, Well)

  return(df)
}


