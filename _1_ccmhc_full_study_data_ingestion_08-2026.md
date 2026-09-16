SMITH-STUDY: Updated Data Processing; STRESS-Scale and Self-Efficacy
Scale (EIPSES)
================
2026-09-16

# 1. Setup & Data Ingestion

## 1.1 Libraries

``` r
library(dplyr)       # Data manipulation
library(stringr)     # String manipulation
library(tidyr)       # Data pivoting
library(readr)       # Reading data
library(kableExtra)  # HTML Table formatting
library(ggplot2)     # Visualizations
library(ggpubr)      # Publication-ready plots
library(rstatix)     # T-tests and effect sizes
library(broom)       # Tidy statistical outputs
library(forcats)     # Factor manipulation
library(effectsize)  # effect size & omega squared
```

## 1.2 Load Data

### 1.2.0 !! Updated Data File:

- **UPDATED DATA FILE** - SEFF_Updated…
  - Both Surveys are connected to a single participant ID (Pre and Post)
    and collated in one spreadsheet
  - Will separate each into its own table, for clarity/checks and file
    write out.
  - Rejoin and save data files for analysis scripts.
- **Structure**
  - Study_ID (Joined ID across pre and post, unique to participant)
  - Group Assignment (Control or Intervention)
  - Stress Scale: **PSS** - *Perceived Stress Scale* - 10 Questions
  - SEFF Scale: **EFF** - *Eearly Intervention Parent Self Efficacy* -
    14 Questions
  - Columns as Pre –\> Post

### 1.2.01 Read Data File

- From Email: T.Smith –\> `stress and SE ALL blind.csv`

``` r
# Read in raw dataset
ALL_DATA.raw <- read_csv("../_data/stress and SE ALL blind.csv", col_names = TRUE)

string_stub <- function(x){paste0(str_sub(x,1,17), "...", str_sub(x,-2,-1))}
#string_stub("In the past month... How often have you felt that you were unable to control the important things in your life?...6")

ALL_DATA.raw %>% 
  arrange(`Group Assignment`, `Study ID`) %>% 
  rename_with( ~ifelse(str_length(.) > 30, yes = string_stub(.), .)) %>% 
  kable(caption="All Survey Data - Linked to Study ID (Anon) - Shortened Column Names") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

All Survey Data - Linked to Study ID (Anon) - Shortened Column Names
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

Pre Record ID
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

Study ID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group Assignment
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Pre scores
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month….5
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month….6
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month….7
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month….8
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month….9
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…10
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…11
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…12
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…13
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…14
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Pre stress score
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

If my child is ha…16
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

When my child sho…17
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

When it comes rig…18
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

If one of my chil…19
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Children will mak…20
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Even a good paren…21
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

I feel that I can…22
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Because there is …23
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

If my child learn…24
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

The amount that a…25
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

On most days, I c…26
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

I worry that I am…27
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

When my child is …28
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Over the past yea…29
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

No matter how har…30
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

The traits that a…31
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Pre SE score
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Post scores
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…34
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…35
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…36
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…37
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…38
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…39
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…40
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…41
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…42
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

In the past month…43
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Post Stress score
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

If my child is ha…45
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

When my child sho…46
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

When it comes rig…47
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

If one of my chil…48
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Children will mak…49
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Even a good paren…50
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

I feel that I can…51
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Because there is …52
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

If my child learn…53
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

The amount that a…54
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

On most days, I c…55
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

I worry that I am…56
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

When my child is …57
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Over the past yea…58
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

No matter how har…59
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

The traits that a…60
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Post SE Score
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

15
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

52
</td>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

54
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

49
</td>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Not applicable
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

34
</td>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

35
</td>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

37
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

46
</td>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

47
</td>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Very Often
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Sometimes
</td>

<td style="text-align:left;">

Fairly Often
</td>

<td style="text-align:left;">

Never
</td>

<td style="text-align:left;">

Almost Never
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Neutral
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Strongly Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Somewhat Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Strongly Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Agree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

Disagree
</td>

<td style="text-align:left;">

NA
</td>

</tr>

</tbody>

</table>

</div>

### 1.2.1 Pre PSS

``` r
## Split to Pre and Post & Select only Study ID, Group Assignment and Questions:
pre.PSS.named <- 
  ALL_DATA.raw %>% 
    select("Study ID", "Group Assignment", 5:14) %>%
    rename("StudyID" = "Study ID", "Group_Assignment" = "Group Assignment") %>% 
    rename_with(~paste0("PSS.PRE_Q", (as.numeric(str_extract(., "\\d+$"))-4)), .cols = 3:12) %>% 
    mutate(across(contains("_Q"), tolower)) #ALL QUESTION TEXT tolower, as earlier data file had capitalization issues; "Agree / agree"

pre.PSS.named %>% kable(caption="STRESS - Pre Intervention Data") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

STRESS - Pre Intervention Data
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

StudyID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q1
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q2
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q3
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q4
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q5
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q6
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q7
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q8
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q9
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.PRE_Q10
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

</tr>

</tbody>

</table>

</div>

### 1.2.2 Pre EFF

``` r
#split to pre and select SEFF cols
pre.EFF.named <- 
  ALL_DATA.raw %>% 
    select("Study ID", "Group Assignment", 16:31) %>% 
    rename("StudyID" = "Study ID", "Group_Assignment" = "Group Assignment") %>% 
    rename_with(~paste0("EFF.PRE_Q", (as.numeric(str_extract(., "\\d+$"))-15)), .cols = 3:18) %>% 
    mutate(across(contains("_Q"), tolower)) #ALL QUESTION TEXT tolower, as earlier data file had capitalization issues; "Agree / agree"

pre.EFF.named %>% kable(caption="SEFF - Pre Intervention Data") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%    scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

SEFF - Pre Intervention Data
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

StudyID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q1
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q2
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q3
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q4
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q5
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q6
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q7
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q8
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q9
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q10
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q11
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q12
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q13
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q14
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q15
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.PRE_Q16
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

not applicable
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

</tbody>

</table>

</div>

### 1.2.3 Post PSS

``` r
#Split Post & Select only Study ID, Group Assignment and Questions:
post.PSS.named <- 
  ALL_DATA.raw %>% 
  select("Study ID", "Group Assignment", 34:43) %>% 
    rename("StudyID" = "Study ID", "Group_Assignment" = "Group Assignment") %>% 
  rename_with(~paste0("PSS.POST_Q", (as.numeric(str_extract(., "\\d+$"))-33)), .cols = 3:12) %>% 
    mutate(across(contains("_Q"), tolower)) #ALL QUESTION TEXT tolower, as earlier data file had capitalization issues; "Agree / agree"

post.PSS.named %>% kable(caption="STRESS - Post Intervention Data") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

STRESS - Post Intervention Data
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

StudyID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q1
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q2
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q3
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q4
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q5
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q6
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q7
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q8
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q9
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

PSS.POST_Q10
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

never
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

very often
</td>

</tr>

<tr>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

</tr>

<tr>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

very often
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

fairly often
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

sometimes
</td>

<td style="text-align:left;">

fairly often
</td>

<td style="text-align:left;">

never
</td>

<td style="text-align:left;">

almost never
</td>

</tr>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

</tbody>

</table>

</div>

### 1.2.4 Post EFF

``` r
#split to pre and select SEFF cols
post.EFF.named  <- 
  ALL_DATA.raw %>% 
    select("Study ID", "Group Assignment", 45:60) %>% 
    rename("StudyID" = "Study ID", "Group_Assignment" = "Group Assignment") %>% 
    rename_with(~paste0("EFF.POST_Q", (as.numeric(str_extract(., "\\d+$"))-44)), .cols = 3:18) %>% 
    mutate(across(contains("_Q"), tolower)) #ALL QUESTION TEXT tolower, as earlier data file had capitalization issues; "Agree / agree"

post.EFF.named %>% kable(caption="SEFF - Post Intervention Data") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

SEFF - Post Intervention Data
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

StudyID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q1
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q2
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q3
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q4
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q5
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q6
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q7
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q8
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q9
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q10
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q11
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q12
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q13
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q14
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q15
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

EFF.POST_Q16
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

</tr>

<tr>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

neutral
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

strongly agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

somewhat agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

strongly disagree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

agree
</td>

<td style="text-align:left;">

disagree
</td>

<td style="text-align:left;">

disagree
</td>

</tr>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:left;">

NA
</td>

</tr>

</tbody>

</table>

</div>

## 1.3 Joins & Item Checks

- Join the pre and post tables for each survey
- Using `StudyID`(this is the column created by `T.Smith` which links
  participants via masked PII
- PSS and EFF each have their own tables now.
- *Check Responses for consistency, typos etc…*

### 1.3.1 PSS Join & Response Checks

``` r
#join tables
all.PSS.named <- left_join(pre.PSS.named, post.PSS.named, by = c("StudyID", "Group_Assignment"))

#check all unique strings in questions
PSS.uniques <- all.PSS.named %>%  
  select(contains("_Q")) %>% 
  summarise(across(everything(), ~list(unique(.)))) %>% 
    pivot_longer(everything(), names_to = "Question", values_to = "Unique_Responses") %>% 
    unnest(cols = c(Unique_Responses))

table(PSS.uniques$Unique_Responses)
```

    ## 
    ## almost never fairly often        never    sometimes   very often 
    ##           19           20           15           20           16

### 1.3.2 EFF Join & Response Checks

``` r
#join tables
all.EFF.named <- left_join(pre.EFF.named, post.EFF.named, by = c("StudyID", "Group_Assignment"))

#check all unique strings in questions
EFF.uniques <- 
  all.EFF.named %>% 
  select(contains("_Q")) %>% 
  summarise(across(everything(), ~list(unique(.)))) %>% 
    pivot_longer(everything(), names_to = "Question", values_to = "Unique_Responses") %>% 
    unnest(cols = c(Unique_Responses))

table(EFF.uniques$Unique_Responses)
```

    ## 
    ##             agree          disagree           neutral    not applicable 
    ##                28                22                25                 1 
    ##    somewhat agree somewhat disagree    strongly agree strongly disagree 
    ##                25                24                22                21

# 2. Scoring & Data Transformation

## 2.1 PSS-STRESS: Item Scoring and Reverse Coding

Scoring: PSS scores are obtained by reversing responses (e.g., 0 = 4, 1
= 3, 2 = 2, 3 = 1 & 4 = 0) to the four positively stated items (items 4,
5, 7, & 8) and then summing across all scale items. A short 4 item scale
can be made from questions 2, 4, 5 and 10 of the PSS 10 item scale.

``` r
PSS.mutated <- all.PSS.named %>% 
  # 1. Convert text responses to numeric scores
  mutate(across(contains("_Q"), ~case_when(
    . == "never" ~ 0,
    . == "almost never" ~ 1,
    . == "sometimes" ~ 2,
    . == "fairly often" ~ 3,
    . == "very often" ~ 4,
    TRUE ~ NA_real_
  ))) %>% 
  # 2. Reverse code specific items
  mutate(across(ends_with(c("Q4", "Q5", "Q7", "Q8")), ~case_when(
    . == 0 ~ 4,
    . == 1 ~ 3,
    . == 2 ~ 2,
    . == 3 ~ 1,
    . == 4 ~ 0,
    TRUE ~ NA_real_
  ))) %>% 
  rowwise() %>% #group rows (individual ID)
  # 3. Calculate total scores
  mutate(PRE_Stress.Total = sum(c_across(starts_with("PSS.PRE_Q")), na.rm = FALSE),
         POST_Stress.Total = sum(c_across(starts_with("PSS.POST_Q")), na.rm = FALSE),
         PRE_Stress.Mean = mean(c_across(starts_with("PSS.PRE_Q")), na.rm = FALSE),
         POST_Stress.Mean = mean(c_across(starts_with("PSS.POST_Q")), na.rm = FALSE),
         PRE_Stress.StDev = sd(c_across(starts_with("PSS.PRE_Q")), na.rm = FALSE),
         POST_Stress.StDev = sd(c_across(starts_with("PSS.POST_Q")), na.rm = FALSE)
         ) %>% 
    ungroup()

PSS.mutated %>% select(StudyID, Group_Assignment, contains("PRE_S"), contains("POST_S")) %>%
  kable(caption="PSS - Calculated Columns") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%    scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

PSS - Calculated Columns
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

StudyID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Stress.Total
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Stress.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Stress.StDev
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Stress.Total
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Stress.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Stress.StDev
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

0.876
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:right;">

1.4
</td>

<td style="text-align:right;">

0.699
</td>

</tr>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

2.0
</td>

<td style="text-align:right;">

0.816
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

2.2
</td>

<td style="text-align:right;">

0.422
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0.0
</td>

<td style="text-align:right;">

0.000
</td>

</tr>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

13
</td>

<td style="text-align:right;">

1.3
</td>

<td style="text-align:right;">

0.483
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

1.2
</td>

<td style="text-align:right;">

0.789
</td>

<td style="text-align:right;">

10
</td>

<td style="text-align:right;">

1.0
</td>

<td style="text-align:right;">

0.816
</td>

</tr>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

0.316
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.632
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.632
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

6
</td>

<td style="text-align:right;">

0.6
</td>

<td style="text-align:right;">

0.699
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

2.2
</td>

<td style="text-align:right;">

1.317
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

1.370
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

0.738
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.8
</td>

<td style="text-align:right;">

0.632
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.8
</td>

<td style="text-align:right;">

0.632
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

11
</td>

<td style="text-align:right;">

1.1
</td>

<td style="text-align:right;">

0.876
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.8
</td>

<td style="text-align:right;">

0.632
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

1.2
</td>

<td style="text-align:right;">

0.422
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.8
</td>

<td style="text-align:right;">

0.789
</td>

</tr>

<tr>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

0.568
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

0.568
</td>

</tr>

<tr>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

1.2
</td>

<td style="text-align:right;">

0.789
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

1.9
</td>

<td style="text-align:right;">

0.738
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

1.2
</td>

<td style="text-align:right;">

1.033
</td>

<td style="text-align:right;">

13
</td>

<td style="text-align:right;">

1.3
</td>

<td style="text-align:right;">

0.483
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.789
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.422
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

0.5
</td>

<td style="text-align:right;">

0.707
</td>

<td style="text-align:right;">

9
</td>

<td style="text-align:right;">

0.9
</td>

<td style="text-align:right;">

0.568
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.8
</td>

<td style="text-align:right;">

1.135
</td>

<td style="text-align:right;">

10
</td>

<td style="text-align:right;">

1.0
</td>

<td style="text-align:right;">

0.943
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.632
</td>

<td style="text-align:right;">

13
</td>

<td style="text-align:right;">

1.3
</td>

<td style="text-align:right;">

0.483
</td>

</tr>

<tr>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

2.7
</td>

<td style="text-align:right;">

0.823
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

1.7
</td>

<td style="text-align:right;">

0.675
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

2.5
</td>

<td style="text-align:right;">

0.707
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

2.0
</td>

<td style="text-align:right;">

1.491
</td>

</tr>

<tr>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

0.7
</td>

<td style="text-align:right;">

0.675
</td>

<td style="text-align:right;">

15
</td>

<td style="text-align:right;">

1.5
</td>

<td style="text-align:right;">

0.972
</td>

</tr>

<tr>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

2.5
</td>

<td style="text-align:right;">

0.707
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.632
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

1.7
</td>

<td style="text-align:right;">

0.483
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

0.632
</td>

</tr>

<tr>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

0.7
</td>

<td style="text-align:right;">

0.949
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.4
</td>

<td style="text-align:right;">

0.843
</td>

</tr>

<tr>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

2.0
</td>

<td style="text-align:right;">

0.667
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.4
</td>

<td style="text-align:right;">

0.699
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

2.7
</td>

<td style="text-align:right;">

0.823
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

1.9
</td>

<td style="text-align:right;">

0.568
</td>

</tr>

<tr>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

0.7
</td>

<td style="text-align:right;">

0.675
</td>

<td style="text-align:right;">

11
</td>

<td style="text-align:right;">

1.1
</td>

<td style="text-align:right;">

0.876
</td>

</tr>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.6
</td>

<td style="text-align:right;">

1.265
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

<td style="text-align:right;">

NA
</td>

</tr>

</tbody>

</table>

</div>

## 2.2 EFF-EFFICACY: Item Scoring

**Scoring Guidelines (Guimond et al., 2008):** - Mean/Total scores are
computed by aggregating all items of the specific scale. - Reverse
Scored Items: 3, 5, 6, 8, 10, 12, 13, 15, 16. - Parent Outcome
Expectations: 3, 4, 5, 6, 7, 8, 10, 12, 15, 16. - Parent Competence: 1,
2, 9, 14.

### Check Missing Data

``` r
if(is.na(all.EFF.named) %>% sum() > 0){
  # Check for any remaining NAs in the final scored dataset
  print("NA OR MISSING DATA - Flag!")
}
```

    ## [1] "NA OR MISSING DATA - Flag!"

``` r
EFF.mutated <- all.EFF.named %>% 
  # 1. Convert text to numeric Likert (1-7)
  mutate(across(contains("_Q"), ~case_match(.,
    "strongly disagree" ~ 1,
    "disagree" ~ 2,
    "somewhat disagree" ~ 3,
    "neutral" ~ 4,
    "somewhat agree" ~ 5,
    "agree" ~ 6,
    "strongly agree" ~ 7,
    .default = NA_real_
  ))) %>% 
  
  # 2. Reverse Code specific items
  mutate(across(ends_with(c("Q3", "Q5", "Q6", "Q8", "Q10", "Q12", "Q13", "Q15", "Q16")), 
                ~ 8 - .)) %>% #  For 1-7 reverse coding (8 - 1 = 7, 8 - 7 = 1)

  # 3. Mean replace NAs
  #mutate(across(contains("_Q"), ~ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
  
  # 4. Calculate Composite Totals
    # PRE Composites
  rowwise() %>% 
  mutate(
    PRE_Parent_Outcome_Expectations.Sum = sum(c_across(ends_with(c("PRE_Q3", "PRE_Q4", "PRE_Q5", "PRE_Q6", "PRE_Q7", "PRE_Q8", "PRE_Q10", "PRE_Q12", "PRE_Q15", "PRE_Q16"))), na.rm = TRUE),
    PRE_Parent_Competence.Sum = sum(c_across(ends_with(c("PRE_Q1", "PRE_Q2", "PRE_Q9", "PRE_Q14"))), na.rm = TRUE),
    PRE_Overall_SEFF.Sum = sum(c_across(contains("PRE_Q")), na.rm = TRUE),
    
    # POST Composites
    POST_Parent_Outcome_Expectations.Sum = 
      sum(c_across(ends_with(c("POST_Q3", "POST_Q4", "POST_Q5", "POST_Q6", "POST_Q7", "POST_Q8", "POST_Q10", "POST_Q12", "POST_Q15", "POST_Q16"))), na.rm = TRUE),
    POST_Parent_Competence.Sum = sum(c_across(ends_with(c("POST_Q1", "POST_Q2", "POST_Q9", "POST_Q14"))), na.rm = TRUE),
    POST_Overall_SEFF.Sum = sum(c_across(contains("POST_Q")), na.rm = TRUE)
  ) %>% 
  # 5. Calculate Composite MEANS
  mutate(
    # PRE Composites
    PRE_Parent_Outcome_Expectations.Mean = 
      mean(c_across(ends_with(c("PRE_Q3", "PRE_Q4", "PRE_Q5", "PRE_Q6", "PRE_Q7", "PRE_Q8", "PRE_Q10", "PRE_Q12", "PRE_Q15", "PRE_Q16"))), na.rm = TRUE),
    PRE_Parent_Competence.Mean = mean(c_across(ends_with(c("PRE_Q1", "PRE_Q2", "PRE_Q9", "PRE_Q14"))), na.rm = TRUE),
    PRE_Overall_SEFF.Mean = mean(c_across(contains("PRE_Q")), na.rm = TRUE),
    
    # POST Composites
    POST_Parent_Outcome_Expectations.Mean = 
      mean(c_across(ends_with(c("POST_Q3", "POST_Q4", "POST_Q5", "POST_Q6", "POST_Q7", "POST_Q8", "POST_Q10", "POST_Q12", "POST_Q15", "POST_Q16"))), na.rm = TRUE),
    POST_Parent_Competence.Mean = mean(c_across(ends_with(c("POST_Q1", "POST_Q2", "POST_Q9", "POST_Q14"))), na.rm = TRUE),
    POST_Overall_SEFF.Mean = mean(c_across(contains("POST_Q")), na.rm = TRUE)
  ) %>% 
  ungroup()

EFF.mutated %>% select(contains(".Sum"))
```

    ## # A tibble: 31 × 6
    ##    PRE_Parent_Outcome_Expectations…¹ PRE_Parent_Competenc…² PRE_Overall_SEFF.Sum
    ##                                <dbl>                  <dbl>                <dbl>
    ##  1                                 0                      0                    0
    ##  2                                43                     19                   67
    ##  3                                52                     25                   89
    ##  4                                 4                      1                    5
    ##  5                                51                     23                   87
    ##  6                                 5                      7                   12
    ##  7                                 0                      0                    0
    ##  8                                13                      6                   19
    ##  9                                51                     22                   85
    ## 10                                56                     24                   92
    ## # ℹ 21 more rows
    ## # ℹ abbreviated names: ¹​PRE_Parent_Outcome_Expectations.Sum,
    ## #   ²​PRE_Parent_Competence.Sum
    ## # ℹ 3 more variables: POST_Parent_Outcome_Expectations.Sum <dbl>,
    ## #   POST_Parent_Competence.Sum <dbl>, POST_Overall_SEFF.Sum <dbl>

### Note!

- There are intervention participants that missed sections of the
  study - these will need to be treated as missing data, removed from
  tests (but can still be in the anlysis potentially).

``` r
EFF.mutated %>% select(StudyID, Group_Assignment, contains(c("Sum","Mean"))) %>%
  kable(caption="EFF - Calculated Columns") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%    scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

EFF - Calculated Columns
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

StudyID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Parent_Outcome_Expectations.Sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Parent_Competence.Sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Overall_SEFF.Sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Parent_Outcome_Expectations.Sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Parent_Competence.Sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Overall_SEFF.Sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Parent_Outcome_Expectations.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Parent_Competence.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE_Overall_SEFF.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Parent_Outcome_Expectations.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Parent_Competence.Mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST_Overall_SEFF.Mean
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

63
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

99
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

6.3
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

6.19
</td>

</tr>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

43
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

67
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

4.30
</td>

<td style="text-align:right;">

4.75
</td>

<td style="text-align:right;">

4.19
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

52
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

56
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

5.20
</td>

<td style="text-align:right;">

6.25
</td>

<td style="text-align:right;">

5.56
</td>

<td style="text-align:right;">

5.6
</td>

<td style="text-align:right;">

6.75
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

2.00
</td>

<td style="text-align:right;">

1.00
</td>

<td style="text-align:right;">

1.67
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

6
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

51
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

58
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.10
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

5.44
</td>

<td style="text-align:right;">

5.8
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.62
</td>

</tr>

<tr>

<td style="text-align:right;">

7
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

2.50
</td>

<td style="text-align:right;">

7.00
</td>

<td style="text-align:right;">

4.00
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

8
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

67
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

4.19
</td>

</tr>

<tr>

<td style="text-align:right;">

9
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

13
</td>

<td style="text-align:right;">

6
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

6.50
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

6.33
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

51
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

38
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

61
</td>

<td style="text-align:right;">

5.10
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

5.31
</td>

<td style="text-align:right;">

3.8
</td>

<td style="text-align:right;">

4.25
</td>

<td style="text-align:right;">

3.81
</td>

</tr>

<tr>

<td style="text-align:right;">

11
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

56
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

5.60
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

12
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

63
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

6.30
</td>

<td style="text-align:right;">

6.50
</td>

<td style="text-align:right;">

6.44
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

13
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

49
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

4.90
</td>

<td style="text-align:right;">

6.25
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

14
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

57
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

55
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.70
</td>

<td style="text-align:right;">

4.75
</td>

<td style="text-align:right;">

5.62
</td>

<td style="text-align:right;">

5.5
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

16
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

49
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

6.25
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

4.9
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

5.19
</td>

</tr>

<tr>

<td style="text-align:right;">

17
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

52
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

55
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.20
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

5.5
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

5.62
</td>

</tr>

<tr>

<td style="text-align:right;">

22
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

62
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

46
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

84
</td>

<td style="text-align:right;">

6.20
</td>

<td style="text-align:right;">

6.75
</td>

<td style="text-align:right;">

6.44
</td>

<td style="text-align:right;">

4.6
</td>

<td style="text-align:right;">

6.50
</td>

<td style="text-align:right;">

5.25
</td>

</tr>

<tr>

<td style="text-align:right;">

26
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

53
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

60
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

5.89
</td>

<td style="text-align:right;">

6.25
</td>

<td style="text-align:right;">

6.07
</td>

<td style="text-align:right;">

6.0
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

6.12
</td>

</tr>

<tr>

<td style="text-align:right;">

28
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

59
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

86
</td>

<td style="text-align:right;">

5.90
</td>

<td style="text-align:right;">

6.50
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.0
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.38
</td>

</tr>

<tr>

<td style="text-align:right;">

32
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

53
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

70
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

112
</td>

<td style="text-align:right;">

5.30
</td>

<td style="text-align:right;">

4.25
</td>

<td style="text-align:right;">

5.12
</td>

<td style="text-align:right;">

7.0
</td>

<td style="text-align:right;">

7.00
</td>

<td style="text-align:right;">

7.00
</td>

</tr>

<tr>

<td style="text-align:right;">

39
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

49
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

80
</td>

<td style="text-align:right;">

56
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

4.90
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

5.6
</td>

<td style="text-align:right;">

6.25
</td>

<td style="text-align:right;">

5.75
</td>

</tr>

<tr>

<td style="text-align:right;">

40
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

54
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

84
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

5.4
</td>

<td style="text-align:right;">

4.50
</td>

<td style="text-align:right;">

5.25
</td>

</tr>

<tr>

<td style="text-align:right;">

42
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

58
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

95
</td>

<td style="text-align:right;">

58
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

5.80
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.94
</td>

<td style="text-align:right;">

5.8
</td>

<td style="text-align:right;">

6.75
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

44
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

54
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

93
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

5.25
</td>

<td style="text-align:right;">

5.19
</td>

<td style="text-align:right;">

5.4
</td>

<td style="text-align:right;">

6.50
</td>

<td style="text-align:right;">

5.81
</td>

</tr>

<tr>

<td style="text-align:right;">

45
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

58
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

53
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.80
</td>

<td style="text-align:right;">

6.50
</td>

<td style="text-align:right;">

6.12
</td>

<td style="text-align:right;">

5.3
</td>

<td style="text-align:right;">

4.75
</td>

<td style="text-align:right;">

5.19
</td>

</tr>

<tr>

<td style="text-align:right;">

50
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

56
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

5.6
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

5.75
</td>

</tr>

<tr>

<td style="text-align:right;">

51
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

43
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

74
</td>

<td style="text-align:right;">

54
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

4.30
</td>

<td style="text-align:right;">

4.75
</td>

<td style="text-align:right;">

4.62
</td>

<td style="text-align:right;">

5.4
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

53
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

60
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

55
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

86
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

6.25
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

5.5
</td>

<td style="text-align:right;">

5.25
</td>

<td style="text-align:right;">

5.38
</td>

</tr>

<tr>

<td style="text-align:right;">

56
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

60
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

101
</td>

<td style="text-align:right;">

52
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

7.00
</td>

<td style="text-align:right;">

6.31
</td>

<td style="text-align:right;">

5.2
</td>

<td style="text-align:right;">

4.75
</td>

<td style="text-align:right;">

5.12
</td>

</tr>

<tr>

<td style="text-align:right;">

58
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

56
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

52
</td>

<td style="text-align:right;">

18
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.60
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

5.69
</td>

<td style="text-align:right;">

5.2
</td>

<td style="text-align:right;">

4.50
</td>

<td style="text-align:right;">

5.19
</td>

</tr>

<tr>

<td style="text-align:right;">

59
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

54
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

5.19
</td>

<td style="text-align:right;">

5.4
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

10
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

7.00
</td>

<td style="text-align:right;">

5.67
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

</tbody>

</table>

</div>

# 3. Save Analaysis Tables and Write File for Download/Use

``` r
EFF.scored <- EFF.mutated
PSS.scored <- PSS.mutated

analytic.files <- list(
  "EFF.scored" = EFF.scored,
  "PSS.Scored" = PSS.scored
  )

readr::write_rds(
  analytic.files,
  path = "../_output/analytic_files_scored_surveys.Rds" )

writexl::write_xlsx(
  analytic.files,
  path = "../_output/analytic_files_scored_surveys.xlsx",
  col_names = TRUE)
```
