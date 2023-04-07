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
  data <- utils::read.csv(path, header=F, sep=":")

  # remove hashed lines, and trim spaces before and after the text
  data <- data[grep("^#", data$V1, invert=T),]
  data$V1<- stringr::str_trim(data$V1, side = "both")
  data$V2 <- stringr::str_trim(data$V2, side = "both")

  # the groups start after Groups
  groups_start <- grep("Groups", data$V1)
  design <- data[(groups_start+1):nrow(data),]

  # metadata is everything before Groups
  metadata <- data[(1:groups_start-1),]

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
  cat_wells <- stringr::str_split(df$V2, '[:blank:]*[:punct:]+[:blank:]*|[:blank:]+')
  #names(cat_wells) <- df$V1

  allwells <- NULL
  allcats <- NULL

  for(n in 1:length(cat_wells)){
    wells <- cat_wells[[n]]
    allwells <- c(allwells, wells)
    cats <- rep(df$V1[n], length(wells))
    allcats <- c(allcats, cats)
  }

  df <- data.frame(Well = allwells, Group = allcats)

  if(anyDuplicated(df$Well)>0){
    stop("Duplicate well names are not allowed.")
  }

  #TODO: make_design_df: no visible binding for global variable ‘Well’
  #TODO: make_design_df: no visible binding for global variable ‘Group’
  df <- dplyr::select(df, Well, Group)
  df <- dplyr::arrange(df, Well)

  return(df)
}


