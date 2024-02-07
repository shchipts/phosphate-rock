library(dplyr)

# %P2O5 content of phoshate-bearing mineral
#
# If phoshate-bearing mineral is francolite, francolite model (McClellan 1980) 
# is used based on a-cell value.
#
# Source:
# [1] Meija, J., Coplen, T., Berglund, M., et al. (2016). Atomic weights of
#     the elements 2013 (IUPAC Technical Report). Pure and Applied Chemistry,
#     88(3): 265-291. Retrieved 3 Oct. 2018, from doi:10.1515/pac-2015-0305
# [2] McClellan, G.H. (1980). Mineralogy of carbonite fluorapatites. Journal of
#     the Geological Society, 137: 675-681. 
#     https://doi.org/10.1144/gsjgs.137.6.0675
# [3] Khasawneh, F., & Doll, E. (1979). The use of phosphate rock for direct
#     application to soils. Advances in Agronomy, 30: 159-206. 
#     https://doi.org/10.1016/S0065-2113(08)60706-3
mineral_model <- function(model, value) {
  
  # Standard atomic weights of some elements (Meija et al. 2016)
  el_Ca <- 40.078
  el_Na <- 22.98976928
  el_Mg <- 24.305
  el_P <- 30.973762
  el_O <- 15.999
  el_C <- 12.011
  el_F	<- 18.99840316
  el_H	<- 1.008
  el_Al <- 26.9815385
  
  ox_PO4 <- el_P + 4 * el_O
  ox_P2O5 <- 2 * el_P + 5 * el_O
  ox_CaO <- el_Ca + el_O
  ox_CO3 <- el_C + 3 * el_O
  
  if (model == "Crandallite")
    return (ox_P2O5 / 
              (el_Ca + 
                 3 * el_Al +
                 2 * ox_PO4 + 
                 5 * (el_O + el_H) + 
                 (2 * el_H + el_O)))
  
  w_fluorapatite <- 10 * el_Ca + 6 * ox_PO4 + 2 * el_F
  
  if (model == "Fluorapatite")
    return (6 * ox_P2O5 / 2 / w_fluorapatite)
  
  # a-cell value of carbonate-fluorapatite end member (McClellan 1980)
  a_cell_fluorapatite <- 9.369
  # a-cell value for francolite end member (Khasawneh and Doll 1979)
  a_cell_francolite <- 9.3135
  
  if (model == "Francolite") {
    
    if (value < a_cell_francolite | value >  a_cell_fluorapatite)
      return (NA)
    
    a_cell <- a_cell_fluorapatite - value
    
    x <- 7.173 * a_cell
    y <- 2.784 * a_cell
    z <- 6 * a_cell / (0.185 + a_cell)
    
    w <- w_fluorapatite - 
      (- (ox_CO3 + 0.4 * el_F - ox_PO4) * z) -
      ((el_Ca - el_Na) * x) -
      ((el_Ca - el_Mg) * y)
    
    return ((6 - z) * ox_P2O5 / 2 / w)
  }
  
  return (NA)
}

order <- read.csv("data-raw/collected/mining processing parameters.csv") %>%
  filter(Parameter == "Ore_P2O5") %>%
  select(Name)
data <- order %>%
  left_join(
    read.csv("data-raw/collected/mining processing parameters.csv") %>%
      mutate(Type = "Primary") %>%
      group_by(Name) %>%
      group_modify(~ {
        
        ore_P2O5 <- .x %>% filter(Parameter == "Ore_P2O5") %>% pull(Value)
        pr_P2O5 <- .x %>% filter(Parameter == "PR_P2O5") %>% pull(Value)
        confidence_min <- case_when(
          "Low" %in% (.x %>% pull(Confidence)) ~ "Low",
          "Medium" %in% (.x %>% pull(Confidence)) ~ "Medium",
          TRUE ~ "High")
        
        s <- .x %>% 
          filter(Parameter %in% c("Recovery", "Recovery_P2O5")) %>%
          mutate(
            Parameter = case_when(
              Parameter == "Recovery" ~ "Recovery_P2O5",
              TRUE ~ "Recovery"),
            Confidence =  confidence_min,
            Value = case_when(
              Parameter == "Recovery" ~ Value * ore_P2O5 / pr_P2O5,
              TRUE ~ Value * pr_P2O5 / ore_P2O5),
            Type = "Secondary")
        
        return (
          .x %>% 
            rbind(s) %>%
            arrange(
              factor(
                Parameter, 
                levels = c(
                  "Ore_P2O5", 
                  "PR_P2O5", 
                  "Recovery", 
                  "Recovery_P2O5"))))
      }) %>%
      ungroup() %>%
        as.data.frame(),
    by = c("Name")) %>%
  rename(Reference = Source) %>%
  mutate(
    Source = paste("Plant_", row_number(), sep = ""),
    Note_Confidence = case_when(
      Type == "Secondary" & Parameter == "Recovery" ~ 
        paste(Confidence, ": set to lowest among ore, PR, and mineral recovery", sep = ""),
      Type == "Secondary" & Parameter == "Recovery_P2O5" ~ 
        paste(Confidence, ": set to lowest among ore, PR, and recovery", sep = ""),
      TRUE ~ Note_Confidence),
    Comment = case_when(
      Type == "Secondary" & Parameter == "Recovery" ~ 
        "Calculated from mineral recovery; same data source assigned",
      Type == "Secondary" & Parameter == "Recovery_P2O5" ~ 
        "Calculated from mass recovery; same data source assigned",
      TRUE ~ Comment))

data_mineral <- read.csv("data-raw/collected/minerals.csv") %>%
  rename(Reference = Source) %>%
  mutate(
    Year = NA,
    Source = paste("Mineral_", row_number(), sep = ""),
    Comment = paste(
      "model: ", 
      Model,
      ", type: ",
      Type,
      ", value: ",
      Value,
      ". ",
      Comment,
      sep = ""))

ore <- data %>%
  filter(Parameter == "Ore_P2O5") %>%
  select(Name, Confidence, Value, Source)

PR <- data %>%
  filter(Parameter == "PR_P2O5") %>%
  select(Name, Confidence, Value, Source)

recovery_mass <- data %>%
  filter(Parameter == "Recovery") %>%
  select(Name, Confidence, Value, Source)

recovery_mineral <- data %>%
  filter(Parameter == "Recovery_P2O5") %>%
  select(Name, Confidence, Value, Source)


mineral_series <- sapply(
  1 : nrow(data_mineral),
  function(idx) {
    
    row <- data_mineral %>% slice(idx)
    
    if (row %>% pull(Model) == "Data")
      return (row %>% pull(Value))
    
    return (100 * mineral_model(row %>% pull(Model), row %>% pull(Value)))
  })

mineral <- data_mineral %>%
  select(-Value) %>%
  cbind(Value = mineral_series) %>%
  select(Name, Confidence, Value, Source)


sources <- data %>% 
  select(Source, Reference, Year, Note_Confidence, Comment) %>%
  rbind(
    data_mineral %>%
      select(Source, Reference, Year, Note_Confidence, Comment))


write.csv(
  ore, 
  file = "data-raw/ore.csv", 
  row.names = FALSE)
write.csv(
  PR, 
  file = "data-raw/PR.csv", 
  row.names = FALSE)
write.csv(
  recovery_mass, 
  file = "data-raw/recovery_mass.csv", 
  row.names = FALSE)
write.csv(
  recovery_mineral, 
  file = "data-raw/recovery_mineral.csv", 
  row.names = FALSE)
write.csv(
  mineral, 
  file = "data-raw/mineral.csv", 
  row.names = FALSE)
write.csv(
  sources, 
  file = "data-raw/sources.csv", 
  row.names = FALSE)


usethis::use_data(ore, overwrite = TRUE)
usethis::use_data(PR, overwrite = TRUE)
usethis::use_data(recovery_mass, overwrite = TRUE)
usethis::use_data(recovery_mineral, overwrite = TRUE)
usethis::use_data(mineral, overwrite = TRUE)
usethis::use_data(sources, overwrite = TRUE)