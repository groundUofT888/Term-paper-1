#### Preamble ####
# Purpose: Get data on 2021 shelter usage and make table
# Author: Haoyu Wang
# Email: haoyuu.wang@mail.utoronto.ca
# Date: 22 January 2024
# Prerequisites: -

#### Workspace setup ####
install.packages("opendatatoronto")
install.packages("tidyverse")
install.packages("knitr")

library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
# Set seed for reproducibility
set.seed(853)

# Simulate data for one beach over the summer months (June 1 to September 1)
dates <- seq(as.Date("2023-06-01"), as.Date("2023-09-01"), by="day")
beach_names <- paste("Beach", LETTERS[1:10])  # Assume 10 beaches for simplicity
# Poisson-distributed counts
e_coli_counts <- rpois(length(dates) * length(beach_names), lambda = 200) 
# Threshold for swim advisory
swim_advisory <- ifelse(e_coli_counts > 100, "Unsafe", "Safe")  

# Combine into a data_frame
simulated_beach_data <- expand.grid(Date = dates, BeachName = beach_names)
simulated_beach_data$EcoliCount <- e_coli_counts[1:nrow(simulated_beach_data)]
simulated_beach_data$SwimAdvisory <- swim_advisory[1:nrow(simulated_beach_data)]

head(simulated_beach_data)

