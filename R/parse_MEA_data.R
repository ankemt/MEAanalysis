#' @import magrittr
NULL

parse_MEA_data <- function(exposurefile, baselinefile){
  exposure <- parse_MEA_file(exposurefile)
  baseline <- parse_MEA_file(baselinefile)

  # TODO calculate differences
  return(exposure)
}

# Helper functions
parse_MEA_file <- function(path){
  # how many columns does the longest row have?
  # if this is not indicated, only the first two columns are parsed by R
  no_col <- max(count.fields(path, sep = ","))
  file <- read.csv(path, sep=",", fill=TRUE, header = F, col.names=1:no_col)

  # select header values
  header <- extract_header(file)

  # select well info and flip axes *transpose
  content_wells <- extract_content(file, type = "well")
  content_electrodes <- extract_content(file, type = "electrode")

  # combine all data to a single list
  file <- list(header,content_wells,content_electrodes)
  return(file)
}

extract_header <- function(file){
  # what row number has "Well Averages"? This is the first data row.
  # extract all data above this row
  n_data <- grep(pattern = "Well Averages", x = dplyr::pull(file, 1))
  header <- file[1:(n_data-1),]

  # remove empty columns
  header <- Filter(function(x)!all(x == ""), header)

  # unite all content of last columns to one
  header <- tidyr::unite(header, col = "Value", -X1, sep = " ")

  # split first column into two (based on whether there are spaces or not)
  header <- split_based_on_space(header)

  # re-sort and rename columns
  header <- dplyr::select(header, level_1, level_2, Value)
  header <- dplyr::rename(header, Setting = level_1, `Sub-setting` = level_2)

  # remove rows without data in Value
  header <- header[grepl("[[:alnum:]]+", header$Value), ]

  return(header)
}

split_based_on_space <- function(df){
  # move both levels to their own column
  df <- dplyr::rename(df, type = 1)
  df$level_1 <- ifelse(!grepl("[[:space:]]{3}", df$type), df$type, NA)
  df$level_2 <- ifelse(grepl("[[:space:]]{3}", df$type), df$type, NA)

  # remove spaces from level2
  df$level_2 <- gsub("[[:space:]]{1}[[:space:]]+", "", df$level_2)

  # add level1 content to empty cells below
  level1_index <- grep("[[:space:]]{3}", df$type, invert = T)
  level2_index <- grep("[[:space:]]{3}", df$type)

  for(i in level2_index){
    k <- i
    while(!k %in% level1_index){k <- k - 1}
    level1_content <- df$type[k]
    df[i,"level_1"] <- level1_content
  }
  return(df)
}

clean_content <- function(df){
  # turn first column into two, and merge them to a single parameter
  df <- split_based_on_space(df)
  df$Parameter <- paste(df$level_1, df$level_2, sep=": ")

  # reorder and remove superfluous columns
  df <- df %>%
    dplyr::select(Parameter, everything()) %>%
    dplyr::select(-type, -starts_with("level_"))

  # replace empty cells and spaces with NA
  df[df==" "] <- NA
  df[df==""] <- NA
  # assume that we need to have more than one non-empty cell in a row
  # clear out empty rows and columns
  df <- df[!rowSums(!is.na(df)) < 2,!colSums(!is.na(df)) < 2]

  # transpose and clean up
  df <- t(df) %>%
    as.data.frame()
  names(df) <- df[1,]
  df <- df[2:nrow(df),]
  df <- dplyr::rename(df, ID = 1)

  # make the data numeric
  cols_to_convert = 2:ncol(df)
  df[cols_to_convert]  <- lapply(df[cols_to_convert], as.numeric)

  return(df)
}

extract_content <- function(file, type = "well"){
  # what row number has "Well Averages"?
  # This is the first data row for wells.
  n_wa <- grep(pattern = "Well Averages", x = dplyr::pull(file, 1))
  # what row number has "Measurement"?
  # This is the first row with electrode measurements.
  n_ms <- grep(pattern = "Measurement", x = dplyr::pull(file, 1))

  if(type == "well"){
    df <- file[n_wa:(n_ms-1),] %>% clean_content()
  }
  if(type == "electrode"){
    df <- file[n_ms:nrow(file),] %>% clean_content()
  }

  return(df)
}


testcontent <- parse_MEA_data(
  exposurefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_exposure_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv",
  baselinefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_baseline_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv"
)
