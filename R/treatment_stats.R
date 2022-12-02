#' Generate statistics for a treatment dataframe
#'
#' @param ratio_df resulting dataframe of the `treatment_ratio` function
#'
#' @return dataframe with summary statistics
#' @export
treatment_stats <- function(ratio_df){

  df <- ratio_df |>
    dplyr::group_by(Group, Metric_type, Parameter) |>
    dplyr::summarize(Ratio_avg = mean(Treatment_ratio),
                     Ratio_stdv = stats::sd(Treatment_ratio))
  return(df)
}
