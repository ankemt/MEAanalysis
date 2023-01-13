exp_design <- function(dir="."){
  path <- paste0(dir, "/", "design.txt")
  date <- "20220109"
  expID <- "DyonHeeftScherpeNagels"
  nwells <- 48
  meta <- paste0("Date: ", date, "\n",
                "ExperimentID: ", expID, "\n",
                "Total_wells:", nwells, "\n",
                "Groups:\n")
  writeLines(meta, con=path)
}
