install.packages("opendatatoronto")
install.packages("tidyverse")
library(tidyverse)
library(opendatatoronto)

# get package
package <- show_package("92b0de8f-1ada-44a7-84cf-adc04868e990")
package
# get all resources for this package
resources <- list_package_resources("92b0de8f-1ada-44a7-84cf-adc04868e990")
# identify data_store resources; by default, Toronto Open Data sets data_store resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
# Load the first data_store resource as a sample
data <- filter(datastore_resources, row_number() == 1) %>% get_resource()
# Filter data to only include the year 2023
data_2023 <- data %>%
  filter(lubridate::year(collectionDate) == 2023)
write_csv(
  x = data_2023,
  file = "inputs/data/unedited_data_2023.csv"
)

head(data_2023)
