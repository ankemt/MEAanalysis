#' Find and label outliers
#'
#' Detect outliers with the adjusted box plot function
#' that takes skewed data into account. Label outliers
#' in a separate column and return the dataframe.
#'
#' @param df Input data frame
#' @param col_parameter Name of the column (as a string) that contains parameters
#' @param col_measurement Name of the column (as a string) that contains (normalized) measurements
#' @param col_concentration Name of the column (as a string) that contains concentration values
#' @export
find_outliers <- function(df,
                          col_parameter = "Parameter",
                          col_measurement = "Measurement_normalized",
                          col_concentration = "Concentration"){
  # add column for outliers, set to False
  df <- dplyr::mutate(df, Outlier = F)

  # check per different concentration what the outliers are
  all_concentrations <- levels(as.factor(df[[col_concentration]]))
  all_parameters<- levels(as.factor(df[[col_parameter]]))

  for(conc in all_concentrations){
    for(param in all_parameters){
      # select the data for the plot and make a vector
      condition <- df[[col_concentration]] == conc & df[[col_parameter]] == param
      column <- df[condition,col_measurement]
      # calculate outliers using the adjusted box plot function, that takes skewed data into account
      adjstat <- robustbase::adjbox(column, plot = FALSE)
      outliers_all <- adjstat$out
      df <- dplyr::mutate(df,
        Outlier = dplyr::case_when(
          (
            get(col_concentration)==conc &
              get(col_parameter)==param &
              get(col_measurement)%in%outliers_all
          ) ~ T,
          TRUE ~ Outlier
        ))
    }
  }
  return(df)
}
