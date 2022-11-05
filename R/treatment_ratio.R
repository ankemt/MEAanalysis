#' Calculate the treatment ratio between exposure and baseline of MEA output files
#' (Currently incomplete)
#'
#' @param exposurepath Path to file with exposure data
#' @param baselinepath Path to file with baseline data
#' @param designpath Path to file with treatment lay-out
#' @param save Boolean to indicate whether result should be saved
#' @param path Path where file should be saved
#' @return data frame with treatment ratio per parameter per well (only if `save` is false)
#' @export
treatment_ratio <- function(exposurepath, baselinepath, designpath, save=F, path="."){
  baseline <- parse_MEA_file(baselinepath)
  exposure <- parse_MEA_file(exposurepath)
  design <- parse_designfile(designpath)

  # check from headers whether baseline and exposure can be compared
  match_MEA_files(exposure$Header, baseline$Header)

  # check whether the baseline and exposure match with design
  match_MEA_design(design$metadata, baseline)
  match_MEA_design(design$metadata, exposure)

  df_base <- tidyr::pivot_longer(baseline$`Well averages`,
                                 cols = tidyr::contains("Metrics"),
                                 names_to = "Parameter",
                                 values_to = "Baseline_value")
  df_expo <- tidyr::pivot_longer(exposure$`Well averages`,
                                 cols = tidyr::contains("Metrics"),
                                 names_to = "Parameter",
                                 values_to = "Exposure_value")
  df <- dplyr::full_join(df_base, df_expo, by = c("ID", "Parameter"))
  df <- tidyr::separate(df,
                        col = "Parameter",
                        sep = " Metrics: ",
                        into = c("Metric_type", "Parameter"))

  df <- dplyr::right_join(design$design, df, by = c("Well" = "ID"))

  df <- dplyr::mutate(df,
                      Treatment_ratio = Exposure_value / Baseline_value,
                      Treatment_ratio_percentage = Treatment_ratio * 100)



  if(save){
    # If save is T, the file should be saved under the path given; default is working dir
    # The name can be generated as follows
    fname <- paste(design$metadata$ExperimentID, design$metadata$Date, sep="_")
    path <- create_path(path)
    fullname <- paste0(path, "/", fname,".csv")
    if(!file.exists(fullname)){
      utils::write.csv(df, fullname, row.names = F)
      # TODO report back to user that file has been saved
    } else{
        stop(paste("A file with the name", fname, "already exists in the location provided.\nThe result was not saved."))
    }

  } else{
      return(df)
      # TODO report metadata
  }


}


create_path <- function(path){
  path_vector <- stringr::str_split(path, "[\\\\/]")[[1]]
  lv <- length(path_vector)
  if(path_vector[lv] == ""){
    path_vector <- path_vector[1:lv-1]
  }
  path <- paste(path_vector, collapse = .Platform$file.sep)
  # TODO check that path exists
  return(path)
}
