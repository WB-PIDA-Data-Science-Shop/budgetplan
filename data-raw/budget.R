## code to prepare `budget` dataset goes here
library(dplyr)
library(readxl)
library(lubridate)
library(here)

budget_input <- read_xlsx(
  here("data-raw", "pigo_data.xlsx")
)

budget <- budget_input |>
  filter(!is.na(`Actual Amount ($)`)) |> 
  mutate(
    `Posting Date Clean` = mdy(`Posting Date`)
  )

usethis::use_data(budget, overwrite = TRUE)
