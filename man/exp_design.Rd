% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exp_design.R
\name{exp_design}
\alias{exp_design}
\title{Generate experimental design file}
\usage{
exp_design(
  path = "./design.txt",
  date = readline(prompt = "What is the date of the experiment? (YYYYMMDD) "),
  expID = readline(prompt = "What is the experiment ID? ")
)
}
\arguments{
\item{path}{path to the design file (dir/name.txt)}

\item{date}{date (string, preferably formatted as YYYYMMDD), default is prompted}

\item{expID}{identifier for the experiment (string), default is prompted}
}
\description{
With information provided by the user, a file is created
that formalizes the experimental design so it can be used to
analyse the MEA file.
}
