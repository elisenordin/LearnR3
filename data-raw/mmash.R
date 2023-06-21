## code to prepare `mmash` dataset goes here
library(tidyverse)
library(fs)
# usethis::use_data(mmash, overwrite = TRUE)
library(here)
source(here("R/functions.R"))
# To print the file list.
# fs::dir_tree("C:/Users/elisen/OneDrive - Chalmers/Documents/Desktop/LearnR/LearnR3", recurse = 1)

# mmash_link <- "https://physionet.org/static/published-projects/mmash/multilevel-monitoring-of-activity-and-sleep-in-healthy-people-1.0.0.zip"
# download.file(mmash_link, destfile = here("data-raw/mmash-data.zip"))
# #
# # usethis::use_git_ignore("data-raw/mmash-data.zip")
# #
# #
# # unzip(here("data-raw/mmash-data.zip"),
# #       exdir = here("data-raw"),
# #       junkpaths = TRUE
# # )
# # unzip(here("data-raw/MMASH.zip"),
# #       exdir = here("data-raw")
# # )
# #
# # # NOTE: You don't need to run this code,
# # # its here to show how we got the file list.
# # fs::dir_tree("data-raw", recurse = 1)
# #

# file_delete(here(c(
#     "data-raw/MMASH.zip",
#     "data-raw/SHA256SUMS.txt",
#     "data-raw/LICENSE.txt"
# )))
# file_move(here("data-raw/DataPaper"), here("data-raw/mmash"))
# usethis::use_git_ignore("data-raw/mmash/")
#
# r3::check_project_setup()

# regular expression
# x <- use_info_df$user_id[1] # file_path_id
# x_numbers <- regmatches(x, gregexpr("[[:digit:]]+", x))  # Apply gregexpr & regmatches
# x_numbers


user_info_df <- import_multiple_files(
  "user_info.csv",
  import_user_info
)

saliva_df <- import_multiple_files(
  "saliva.csv",
  import_saliva
)

rr_df <- import_multiple_files(
    "RR.csv", import_rr)

actigraph_df <- import_multiple_files(
    "Actigraph.csv", import_actigraph)

rr_df %>%
  group_by(user_id, day) %>%
  summarise(across(ibi_s, list(mean = mean)))

summarised_rr_df <- rr_df %>%
  group_by(user_id, day) %>%
  summarise(across(ibi_s, list(
    mean = ~ mean(.x, na.rm = TRUE),
    sd = ~ sd(.x, na.rm = TRUE)
  ))) %>%
  ungroup()

summarised_actigraph_df <- actigraph_df %>%
  group_by(user_id, day) %>%
  # These statistics will probably be different for you
  summarise(across(c(hr, steps), list(
    mean = ~ mean(.x, na.rm = TRUE),
    sd = ~ sd(.x, na.rm = TRUE)
  ))) %>%
  ungroup()


saliva_with_day_df <- saliva_df %>%
  mutate(day = case_when(
    samples == "before sleep" ~ 1,
    samples == "wake up" ~ 2,
  ))
mmash <- list(
  user_info_df,
  saliva_with_day_df,
  summarised_rr_df,
  summarised_actigraph_df
) %>%
  reduce(full_join)


usethis::use_data(mmash, overwrite = TRUE) # use_data - save it as a rda file in fodler 'data'
