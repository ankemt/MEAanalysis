parse_MEA_data <- function(exposurefile, baselinefile){
  exposure <- parse_MEA_file(exposurefile)
  baseline <- readr::read_csv(baselinefile)

  df <- exposure
  return(df)
}

# Helpers
parse_MEA_file <- function(path){
  no_col <- max(count.fields(path, sep = ","))
  file <- read.csv(path,sep=",",fill=TRUE,header = F,col.names=1:no_col)

  # select header info
  header <- extract_header(file)

  # select well info and flip axes *transpose

  return(header)
}

extract_header <- function(file){
  # what row number has "Well Averages"? This is the first data row.
  # extract all data above this row
  n_data <- grep(pattern = "Well Averages", x = dplyr::pull(file, 1))
  header <- file[1:n_data-1,]
  # remove empty columns
  header <- Filter(function(x)!all(x == ""), header)
  # unite all content of last columns to one
  header <- tidyr::unite(header, col = "info", -X1, sep = " ")
  # split first column into two (based on whether there are spaces or not)
  header <- split_based_on_space(header)
  # re-sort and rename columns
  header <- dplyr::select(header, level_1, level_2, info)
  header <- dplyr::rename(header, type_1 = level_1, type_2 = level_2)
  # remove rows without data in info
  header <- header[grepl("[[:alnum:]]+", header$info), ]
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

df <- parse_MEA_data(
  exposurefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_exposure_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv",
  baselinefile = "~/Projects/MEA/200814_LvM_256062_1293-05_MEA_rCortex_Permethrin_baseline_female_DIV11_Spike Detector (7 x STD)_neuralMetrics.csv")
