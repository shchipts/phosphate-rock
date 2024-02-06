library(dplyr)

mining_complexes <- read.csv("data-raw/general_properties.csv") %>%
  select(-c(USGS_Company, USGS_Year, Comment)) %>%
  left_join(
    read.csv("data-raw/classification country.csv") %>%
      select(-IFA) %>%
      rename(Country = USGS, Region = IFA_Region),
    by = c("Country")) %>%
  left_join(
    read.csv("data-raw/capacity.csv") %>%
      select(Name, Production_Capacity) %>%
      rename(Capacity = Production_Capacity),
    by = c("Name")) %>%
  select(
    Name,
    Region,
    Country,
    Subnational_Level,
    Company,
    Rock_type,
    Status,
    Capacity) %>%
  arrange(Region, desc(Capacity))

write.csv(
  mining_complexes, 
  file = "data-raw/mining_complexes.csv", 
  row.names = FALSE)

usethis::use_data(mining_complexes, overwrite = TRUE)
