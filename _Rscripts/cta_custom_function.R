#cta custom functions

# 
# ## crr_html table - uses BROOM (installed) and GT(req install??)
# crr_html_tb <- function(crr_model){
#   require(broom) #preinstalled
#   require(gt) #preinstalled
#   tidy_crr <- tidy(crr_model, exponentiate = TRUE, conf.int = TRUE) %>%
#   mutate(
#     conf.low = round(conf.low, 2),
#     conf.high = round(conf.high, 2),
#     ci_string = paste0("(", conf.low, ", ", conf.high, ")")
#   )

# # Replace the generic "cohort" names with your original labels
# # Note: The first level (e.g., "Control") is the reference and is not included as a coefficient
# # in the model output. The coefficients correspond to levels 2, 3, etc.
#   #cohort_labels = c("Control", "Treatment")
#   cohort_labels = c("Darzalex-IV", "Darzalex-FASPRO")
#   tidy_crr$term <- c(cohort_labels[-1])
  
# # Create the gtsummary table
# gt_out <- tidy_crr %>%
#   gt() %>%
#   gt::tab_spanner(
#     label = "Subdistribution Hazard Ratio",
#     columns = c(estimate, ci_string)
#   )
# return(gt_out)
# }

binary_rescale <- 
  function(x){
    rng <- range(x, na.rm = TRUE)
    (x - rng[1]) / (rng[2] - rng[1])
  }

psuedo_id <- 
  create_unique_ids <- function(n, seed_no = 1, char_len = 5){
    set.seed(seed_no)
    pool <- c(letters, LETTERS, 0:9)
    
    res <- character(n) # pre-allocating vector is much faster than growing it
    for(i in seq(n)){
      this_res <- paste0(sample(pool, char_len, replace = TRUE), collapse = "")
      while(this_res %in% res){ # if there was a duplicate, redo
        this_res <- paste0(sample(pool, char_len, replace = TRUE), collapse = "")
      }
      res[i] <- this_res
    }
    res
  }
# 
# set_cohort_levels <- function(input_df, cohort_col=cohort, levels=c("DARZALEX IV ONLY", "DARZALEX FASPRO ONLY")) {
# if ((select(input_df, {{cohort_col}}) %>% unlist() %>% class())=="character") {
#   return (mutate(input_df, {{cohort_col}}:=factor({{cohort_col}}, levels={{levels}})))
# }
# return (mutate(input_df, {{cohort_col}}:=factor({{levels}}[{{cohort_col}}+1], levels={{levels}})))
# }
# 
# #### alt versions
# set_cohort_levels_new_col <- function(
#     input_df, 
#     cohort_col=cohort,
#     cohort_new=cohort_new,
#     levels=c("DARZALEX IV ONLY", "DARZALEX FASPRO ONLY")
# ) 
# {if ((select(input_df, {{cohort_col}}) %>% unlist() %>% class())=="character") {
#   print("TRUE ROUTE >> CHANGE TO FACTOR")
#   return (mutate(input_df, {{cohort_new}}:=factor({{cohort_col}}, levels={{levels}})))
# }
#   print("FALSE ROUTE >> B")
#   return (mutate(input_df, {{cohort_new}}:=factor({{levels}}[{{cohort_col}}+1], levels={{levels}})))
# }
# 
# ex_dynamic_recode <- function(input_df, cohort_col=cohort, num_var){
#   return (
#     mutate(input_df, {{num_var}}:= ifelse({{cohort_col}}=="DARZALEX FASPRO ONLY", {{num_var}}+7.5, {{num_var}}))
#   )
# }


#### NEW VERSION
# set.cohort.lev <- function(input_df, cohort_col=cohort, levels=c("DARZALEX IV ONLY", "DARZALEX FASPRO ONLY")) {
#   
#   # Determine the variable type using case_when
#   input_df <- input_df %>%
#     mutate(cohort_type := case_when(
#       is.factor({{cohort_col}}) ~ "factor",
#       is.character({{cohort_col}}) ~ "character",
#       is.numeric({{cohort_col}}) ~ "numeric",
#       TRUE ~ "other"  # Handle other cases explicitly
#     ))
#   
#   # Use the switch variable to determine the correct action
#   result_df <- switch(unique(input_df$cohort_type),
#                       "factor" = {
#                         current_levels <- input_df %>% select({{cohort_col}}) %>% unlist %>% levels()
#                         if (identical(current_levels, levels)) {
#                           # Already correct, return as is
#                           input_df
#                         } else {
#                           # Factor but levels are incorrect, recreate factor with specified levels
#                           input_df %>%
#                             mutate({{cohort_col}} := factor({{cohort_col}}, levels = levels))
#                         }
#                       },
#                       "numeric" = {
#                         input_df %>%
#                           mutate({{ cohort_col }} := case_when(
#                             {{ cohort_col }} == 0 ~ levels[1],  # levels[1] is "DARZALEX IV ONLY"
#                             {{ cohort_col }} == 1 ~ levels[2],  # levels[2] is "DARZALEX FASPRO ONLY"
#                             TRUE ~ NA  # Handle other numeric values as NA
#                           ) %>%
#                             factor(levels = levels) # Convert to factor with specified levels
#                           )
#                       },
#                       "character" = {
#                         input_df %>%
#                           mutate({{cohort_col}} := case_when(
#                             {{cohort_col}} == "DARZALEX IV ONLY" ~ levels[1],  # Use levels[1] for clarity
#                             {{cohort_col}} == "DARZALEX FASPRO ONLY" ~ levels[2], # Use levels[2] for clarity
#                             {{cohort_col}} == "0" ~ levels[1],  # Use levels[1] for clarity
#                             {{cohort_col}} == "1" ~ levels[2], # Use levels[2] for clarity
#                             TRUE ~ NA  # Handle unexpected values explicitly
#                           ) %>%
#                             factor(levels = levels) # ensure levels are correct
#                           )
#                       },
#                       # Default case if none of the above match
#                       {
#                         warning("Unexpected cohort type.  Returning input data frame unchanged.")
#                         input_df # Return the original data frame
#                       }
#   )
#   # Check, clean up and return the result
#   if(any(result_df %>% select({{cohort_col}}) %>% is.na())){
#     warning("NAs in cohort values - check data")
#   } #else
#   return(result_df %>% select(-cohort_type))
# }

# 
# ### census regions
# #
# #tt <- sample(tidycensus::fips_code %>% mutate(fips5 = paste0(state_code,county_code)) %>% select(fips5), 50)
# #quoted <- function(x){paste0("'",x,"'")}
# #cat(sep = ",", ,quoted(unlist((tt))))
# #rm(tt)
# 
# .census_regions_sample = c('01027','47033','08059','36047','28091','18141','06091','48199','51117','21145','17007','01085','26127','31025','40131','22097','16023','37071','05063','21219','09005','13227','40015','47085','51119','39117','41071','16043','26079','48075','20141','22087','20209','48331','01025','17125','55009','16083','01015','48233','72099','29189','17069','46019','26121','16035','18173','21091','21127','33005')
# 
