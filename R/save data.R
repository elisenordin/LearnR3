#Deleated from quarto

## Importing raw data
```{r}
# user_1_info_file <- here("data-raw/mmash/user_1/user_info.csv")
# user_1_info_data <- vroom(user_1_info_file)
# # vroom first pga need to first import the data
# # sepc show what is imported
# # use vroom to  show the data, easier for people to read
# spec(user_1_info_data) # get info of type of data
# # To check with dataform, and possibility to change
# user_1_info_data <- vroom(user_1_info_file, # limit messages that pop up
#   col_select = -1, # or use cols_only
#   # col_types= can write only import file X and Y
#   col_types = cols(
#     col_skip(),
#     gender = col_character(),
#     weight = col_double(),
#     height = col_double(),
#     age = col_double()
#   ),
#   .name_repair = snakecase::to_snake_case # remove a message
# )
# spec(user_1_info_data)
```


## Exercise: Import the saliva data
```{r}
# user_1_saliva_file <- here("data-raw/mmash/user_1/saliva.csv")
# user_1_saliva_data_prep <- vroom(
#   user_1_saliva_file,
#   col_select = -1,
#   .name_repair = snakecase::to_snake_case
# )
# spec(user_1_saliva_data_prep)
#
# user_1_saliva_data <- vroom(
#   user_1_saliva_file,
#   col_select = -1,
#   col_types = cols(
#     col_skip(),
#     samples = col_character(),
#     cortisol_norm = col_double(),
#     melatonin_norm = col_double()
#   ),
#   .name_repair = snakecase::to_snake_case
# )
```



## Importing longer datasets -->

```{r}
# user_1_rr_file <- here("data-raw/mmash/user_1/RR.csv")
# user_1_rr_data_prep <- vroom(
#   user_1_rr_file,
#   col_select = -1,
#   n_max = 100, # import max 100 rows
#   .name_repair = snakecase::to_snake_case
# )
# spec(user_1_rr_data_prep)
#
# import_rr <- function(file_path) {
#     rr_data <- vroom::vroom(
#         file_path,
#   col_select = -1,
#   col_types = cols(
#   col_skip(),
#   ibi_s = col_double(),
#   day = col_double(),
#   time = col_time(format = "")
# ),
#   .name_repair = snakecase::to_snake_case
# )
#     return(rr_data)
# }

import_rr (here::here("data-raw/mmash/user_1/rr.csv"))

```


## Exercise: Import the Actigraph data, test another dataset
```{r}
# user_1_actigraph_file <- here("data-raw/mmash/user_1/Actigraph.csv")
# user_1_actigraph_data_prep <- vroom(
#   user_1_actigraph_file,
#   col_select = -1,
#   n_max = 100, # import max 100 rows
#   .name_repair = snakecase::to_snake_case
# )
# spec(user_1_actigraph_data_prep)



import_actigraph(here::here("data-raw/mmash/user_1/actigraph.csv"))
```


## Making a function

```{r}

add_numbers(1, 2)
```


# user_info data function

```{r}

import_user_info(here::here("data-raw/mmash/user_1/user_info.csv"))

```



## Exercise for importing the saliva data as a function

```{r}
#' Saliva dataset


import_saliva(here::here("data-raw/mmash/user_2/saliva.csv"))

```


## rr data as function
```{r}
import_rr(here::here("data-raw/mmash/user_2/rr.csv"))
```


