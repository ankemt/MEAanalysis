#' Calculate the treatment ratio between exposure and baseline of MEA output files
#' (Currently incomplete)
#'
#' @param exposurepath Path to file with exposure data
#' @param baselinepath Path to file with baseline data
#' @param designpath Path to file with treatment lay-out
#' @return data frame with treatment ratio per parameter per well
#' @export
treatment_ratio <- function(exposurepath, baselinepath, designpath){
  baseline <- parse_MEA_file(baselinepath)
  exposure <- parse_MEA_file(exposurepath)
  design <- parse_designfile(designpath)

  # check from headers whether baseline and exposure can be compared
  if(!match_MEA_files(exposure$Header, baseline$Header)){
    stop("The MEA files provided have different metadata attributes and cannot be compared.\
    Did you provide the correct baseline and exposure files?")
  }

  # TODO design metadata _ what do we do?

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
                      # TODO, this is not absolute v ratio, I think?
                      Treatment_ratio = Exposure_value / Baseline_value,
                      Treatment_ratio_percentage = Treatment_ratio * 100)

  # TODO should this function create the file and return the path, or open the file?

  return(df)
}

