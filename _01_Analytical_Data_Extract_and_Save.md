\_01_Analytical_Data_Extract_and_Save
================
2026-10-28

# 0. Setup & Data Ingestion

## 0.1 Libraries

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

- **Structure**
  - **UPDATED DATA FILE** - SEFF_Updated…

    - Both Surveys are connected to a single participant ID (Pre and
      Post) and collated in one spreadsheet

  - Will separate each into its own table, for clarity/checks and file
    write out.

  - Rejoin and save data files for analysis scripts.

  - Study_ID (Joined ID across pre and post, unique to participant)

  - Group Assignment (Control == 2 or Intervention == 1)

  - Stress Scale: **PSS** - *Perceived Stress Scale* - 10 Questions

    - ***Reverse Score Items*** (Done automatically in RedCap Survey
      Software)
    - Scoring: PSS scores are obtained by reversing responses (e.g., 0 =
      4, 1 = 3, 2 = 2, 3 = 1 & 4 = 0) to the four positively stated
      items (items 4, 5, 7, & 8) and then summing across all scale
      items. A short 4 item scale can be made from questions 2, 4, 5 and
      10 of the PSS 10 item scale.

  - SEFF Scale: **EFF** - *Eearly Intervention Parent Self Efficacy* -
    16 Questions

    - **Scoring Guidelines (Guimond et al., 2008):**
    - Mean/Total scores are computed by aggregating all items of the
      specific scale.
    - Reverse Scored Items: 3, 5, 6, 8, 10, 12, 13, 15, 16.
    - Parent Outcome Expectations: 3, 4, 5, 6, 7, 8, 10, 12, 15, 16.
    - Parent Competence: 1, 2, 9, 14.

# 1. Ingest Files

## Participant Assignments

``` r
Participant_Assignments <- readxl::read_xlsx("../_data/Final participants.xlsx") %>% 
  # destructive rename and transform
  transmute(
    "Assigned_Study_ID_Number" = `ID Number`,
    "Group_Assignment" = `1 - AD; 2 - control`) %>% 
    # "Consent" = `Consent form?`,
    # "Pre_Survey" = `Pre surveys?`,
    # "Post_Survey" = `Post surveys?`,
    # "Study_Status" = `Study Status`,
    # "Number_Doula_Visits" = `Number of doula visits`
    #         )
#%>% 
  # filter for only included data
#filter(
#    Consent == "y",
#    Study_Status %in% c("finished","complete")) %>% 
  mutate(Group_Assignment = ifelse(Group_Assignment == 1, "Intervention", "Control"))
```

## PRE-TEST (Info and Scales)

``` r
info_and_pretest.sel <- 
  read_csv("../_data/FamilyInfoAndPreMeas_DATA_FINAL FOR COLIN.csv") %>% 
    rename("Assigned_Study_ID_Number" = `participant ID assigned by staff`) |> 
  ## Select
  select(
    Assigned_Study_ID_Number,
    autismdx,
    #PSS
    promis_sc001:promis_sc014, # promis_sc001 is ALREADY REVERSE coded
    sickchild:confidence_11 # efficacy, cols sickchild:confidence11 - not reverse coded
)

## Mutate
info_and_pre.mut <- info_and_pretest.sel |>
  rename_with(~ paste0("PRE.PSS_Q", 1:10), .cols = promis_sc001:promis_sc014) |> 
  rename_with(~ paste0("PRE.EFF_Q", 1:16), .cols = sickchild:confidence_11) |> 
  mutate(across(ends_with(c("EFF_Q3", "EFF_Q5", "EFF_Q6", "EFF_Q8", "EFF_Q10", "EFF_Q12", "EFF_Q13", "EFF_Q15", "EFF_Q16")), 
                ~ 8 - .)) #  For 1-7 reverse coding (8 - 1 = 7, 8 - 7 = 1)
  
## Join for finalized set
PRE_TEST <- left_join(
  x = info_and_pre.mut,
  y = Participant_Assignments,
  by = "Assigned_Study_ID_Number") |> 
    select("Study_ID" = Assigned_Study_ID_Number,
         autismdx, 
         Group_Assignment,
         contains("PRE.PSS"),
         contains("PRE.EFF"))

## Test Set (Calculated Scores only)

PRE_TEST.scores <- PRE_TEST |> 
  rowwise() |> 
  transmute(
    "Study_ID" = Study_ID,
    Group_Assignment,
    # CALC Scores
    "PRE.PSS.sum" = sum(c_across(contains("PRE.PSS_Q")), na.rm=TRUE),
    "PRE.PSS.mean" = mean(c_across(contains("PRE.PSS_Q")), na.rm=TRUE),
    "PRE.EFF.sum" = sum(c_across(contains("PRE.EFF_Q")), na.rm=TRUE),
    "PRE.EFF.mean" = mean(c_across(contains("PRE.EFF_Q")), na.rm=TRUE)) |> 
  ungroup()

## View
PRE_TEST.scores |> 
  kable(caption="PRETEST SCORES") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>%
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

PRETEST SCORES
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

Study_ID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.PSS.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.PSS.mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.EFF.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.EFF.mean
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.30
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

1.67
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

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

4.00
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

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

5.67
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

6.33
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

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.30
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

6.44
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.30
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

6.44
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.30
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

6.44
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.30
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

6.44
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

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

5.50
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

67
</td>

<td style="text-align:right;">

4.19
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
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

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

5.44
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

21
</td>

<td style="text-align:right;">

2.10
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

5.44
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
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

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

5.50
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
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

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
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

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

5.50
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:right;">

1.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:right;">

1.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:right;">

1.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:right;">

1.40
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
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

15
</td>

<td style="text-align:right;">

1.50
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

6.44
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

23
</td>

<td style="text-align:right;">

2.30
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
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

18
</td>

<td style="text-align:right;">

1.80
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
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

18
</td>

<td style="text-align:right;">

1.80
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
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

35
</td>

<td style="text-align:right;">

3.50
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

5.12
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

5.12
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

5.12
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

5.12
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

37
</td>

<td style="text-align:right;">

3.70
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

37
</td>

<td style="text-align:right;">

3.70
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

37
</td>

<td style="text-align:right;">

3.70
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

37
</td>

<td style="text-align:right;">

3.70
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
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

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

80
</td>

<td style="text-align:right;">

5.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

75
</td>

<td style="text-align:right;">

4.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

75
</td>

<td style="text-align:right;">

4.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

75
</td>

<td style="text-align:right;">

4.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

75
</td>

<td style="text-align:right;">

4.69
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

35
</td>

<td style="text-align:right;">

3.50
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
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

27
</td>

<td style="text-align:right;">

2.70
</td>

<td style="text-align:right;">

95
</td>

<td style="text-align:right;">

5.94
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

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

6.12
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

2.40
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

2.20
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
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

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

74
</td>

<td style="text-align:right;">

4.62
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
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

37
</td>

<td style="text-align:right;">

3.70
</td>

<td style="text-align:right;">

81
</td>

<td style="text-align:right;">

5.06
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

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

81
</td>

<td style="text-align:right;">

5.06
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

3.30
</td>

<td style="text-align:right;">

59
</td>

<td style="text-align:right;">

3.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

3.30
</td>

<td style="text-align:right;">

59
</td>

<td style="text-align:right;">

3.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

3.30
</td>

<td style="text-align:right;">

59
</td>

<td style="text-align:right;">

3.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

3.30
</td>

<td style="text-align:right;">

59
</td>

<td style="text-align:right;">

3.69
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

36
</td>

<td style="text-align:right;">

3.60
</td>

<td style="text-align:right;">

101
</td>

<td style="text-align:right;">

6.31
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

73
</td>

<td style="text-align:right;">

4.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

73
</td>

<td style="text-align:right;">

4.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

73
</td>

<td style="text-align:right;">

4.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

73
</td>

<td style="text-align:right;">

4.56
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

16
</td>

<td style="text-align:right;">

1.60
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

16
</td>

<td style="text-align:right;">

1.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

16
</td>

<td style="text-align:right;">

1.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

16
</td>

<td style="text-align:right;">

1.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

16
</td>

<td style="text-align:right;">

1.60
</td>

<td style="text-align:right;">

0
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

18
</td>

<td style="text-align:right;">

1.80
</td>

<td style="text-align:right;">

78
</td>

<td style="text-align:right;">

4.88
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

1.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

0
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

18
</td>

<td style="text-align:right;">

1.80
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

2.80
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

2.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

2.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

2.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

27
</td>

<td style="text-align:right;">

2.70
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

</tbody>

</table>

</div>

## POST-TEST (Scales)

Data Files: - Control Data - Post Data - Has Study ID Number
“participant number” - Survey Cols: - PSS
Stress:post_upset:post_piling_up - EFF Efficacy:
childproblems:difference15 \## RedCap Downloaded Files

``` r
## raw_data in CSV format... means we get the numbers (and also some added data - rather than LABELS (strongly agree etc...))
# read RAWS
control.csv <- readr::read_csv("../_data/CONTROLPostMeasuresA_DATA_2026-08-24_1126.csv", col_names = TRUE)
#pre.csv <- readr::read_csv("../_data/FamilyInfoAndPreMeas_DATA_2026-08-24_1122.csv", col_names = TRUE)
post.csv <- readr::read_csv("../_data/PostMeasuresAndSatis_DATA_2026-08-24_1123.csv", col_names = TRUE)
```

``` r
control.csv |> glimpse()
```

    ## Rows: 6
    ## Columns: 70
    ## $ record_id                <dbl> 1, 2, 3, 4, 5, 6
    ## $ redcap_survey_identifier <lgl> NA, NA, NA, NA, NA, NA
    ## $ form_1_timestamp         <dttm> 2025-12-16 10:28:59, 2025-12-16 10:34:17, 202…
    ## $ participant_number       <dbl> 60, 13, 12, 11, 9, NA
    ## $ post_upset               <dbl> 3, 3, 4, 3, 3, 3
    ## $ post_control             <dbl> 3, 2, 3, 3, 3, 2
    ## $ post_stress              <dbl> 3, 1, 3, 3, 4, 3
    ## $ post_personal_problems   <dbl> 3, 5, 3, 3, 4, 4
    ## $ post_going_your_way      <dbl> 4, 4, 3, 3, 3, 3
    ## $ post_cope                <dbl> 4, 2, 3, 3, 1, 2
    ## $ post_irritation          <dbl> 3, 4, 3, 4, 3, 2
    ## $ post_on_top_of_things    <dbl> 4, 5, 3, 3, 4, NA
    ## $ post_anger               <dbl> 3, 3, 3, 3, 3, 2
    ## $ post_piling_up           <dbl> 2, 2, 3, 3, 1, 2
    ## $ child_problems           <dbl> 7, 7, 6, 6, 7, 6
    ## $ difference               <dbl> 7, 7, 6, 6, 5, 6
    ## $ therapists               <dbl> 3, 1, 5, 3, 1, 1
    ## $ difference_3             <dbl> 2, 7, 6, 7, 7, 7
    ## $ difference_4             <dbl> 6, 2, 5, 2, 2, 7
    ## $ difference_5             <dbl> 2, 5, 6, 3, 4, 1
    ## $ difference_6             <dbl> 7, 6, 6, 7, 6, 7
    ## $ difference_7             <dbl> 3, 1, 6, 4, 5, 6
    ## $ difference_8             <dbl> 7, 4, 6, 5, 4, 6
    ## $ difference_9             <dbl> 5, 2, 6, 4, 2, 2
    ## $ difference_10            <dbl> 7, 7, 6, 7, 6, 7
    ## $ difference_11            <dbl> 2, 1, 4, 3, 6, 5
    ## $ difference_12            <dbl> 1, 1, 2, 2, 1, 2
    ## $ difference_13            <dbl> 7, 7, 5, 7, 7, 7
    ## $ difference_14            <dbl> 1, 2, 3, 5, 3, 4
    ## $ difference_15            <dbl> 4, 4, 4, 2, 3, 1
    ## $ medical_appts            <dbl> 1, 2, 5, 2, 3, 1
    ## $ medical_appts_2          <dbl> 1, 4, 5, 2, 2, 1
    ## $ medical_appts_3          <dbl> 2, 3, 5, 2, 1, 1
    ## $ medical_appts_4          <dbl> 2, 2, 5, 2, 2, 5
    ## $ medical_appts_5          <dbl> 2, 1, 5, 2, 4, 5
    ## $ medical_appts_6          <dbl> 4, 1, 5, 2, 2, 5
    ## $ medical_appts_7          <dbl> 4, 2, 5, 2, 3, 5
    ## $ medical_appts_8          <dbl> 4, 1, 5, 1, 2, 5
    ## $ medical_appts_9          <dbl> 3, 1, 5, 2, 2, 5
    ## $ medical_appts_10         <dbl> 1, 1, 5, 1, 2, 5
    ## $ medical_appts_11         <dbl> 1, 1, 5, 1, 2, 5
    ## $ medical_appts_12         <dbl> 4, 2, 5, 2, 2, 5
    ## $ medical_appts_13         <dbl> 1, 3, 5, 3, 3, 5
    ## $ medical_appts_14         <dbl> 1, 2, 5, 2, 2, 5
    ## $ medical_appts_15         <dbl> 1, 2, 5, 1, 2, 5
    ## $ medical_appts_16         <dbl> 1, 1, 5, 2, 3, 5
    ## $ medical_appts_17         <dbl> 1, 1, 5, 1, 2, 5
    ## $ medical_appts_18         <dbl> 1, 3, 5, 2, 4, 5
    ## $ medical_appts_19         <dbl> 1, 2, 5, 2, 2, 5
    ## $ medical_appts_20         <dbl> 1, 2, 5, 2, 2, 5
    ## $ medical_appts_21         <dbl> 1, 2, 5, 1, 3, 5
    ## $ medical_appts_22         <dbl> 1, 2, 5, 3, 3, 5
    ## $ medical_appts_23         <dbl> 1, 2, 5, 4, 3, 5
    ## $ medical_appts_24         <dbl> 1, 1, 5, 1, 3, 5
    ## $ medical_appts_25         <dbl> 1, 1, 5, 1, 3, 5
    ## $ medical_appts_26         <dbl> NA, 1, 5, 1, 3, 5
    ## $ medical_appts_28         <dbl> 2, 1, 5, 2, 3, 5
    ## $ talk_to                  <dbl> 5, 5, 6, 3, 5, 6
    ## $ talk_to_2                <dbl> 5, 5, 6, 4, 5, 6
    ## $ talk_to_3                <dbl> 5, 5, 6, 3, 4, 6
    ## $ talk_to_4                <dbl> 4, 3, 6, 2, 5, 6
    ## $ talk_to_5                <dbl> 5, 4, 6, 3, 3, 6
    ## $ talk_to_6                <dbl> 5, 5, 6, 4, 5, 6
    ## $ talk_to_7                <dbl> 5, 5, 6, 4, 2, 6
    ## $ talk_to_8                <dbl> 5, 5, 6, 3, 5, 6
    ## $ talk_to_9                <dbl> 1, 3, 6, 1, 1, 6
    ## $ talk_to_10               <dbl> 1, 4, 6, 3, 4, 6
    ## $ best_part                <chr> "Just giving me options and ways to help my s…
    ## $ best_part_2              <chr> "N/A", "N/A", "Not sure", "idk", "Nothing pe…
    ## $ form_1_complete          <dbl> 2, 2, 2, 2, 2, 2

``` r
## Post_TEST Data Ingestion & Combination

# 1. Combine Control and Intervention Post datasets
post_combined.raw <- bind_rows(control.csv, post.csv)

# 2. Select and standardise column names
post.sel <- post_combined.raw |> 
  rename("Assigned_Study_ID_Number" = participant_number) |> 
  select(
    Assigned_Study_ID_Number,
    # PSS Stress (10 items)
    post_upset:post_piling_up,
    # EFF Efficacy (16 items)
    child_problems:difference_15
  )

## Mutate & Reverse Code
post.mut <- post.sel |> 
  rename_with(~ paste0("POST.PSS_Q", 1:10), .cols = post_upset:post_piling_up) |> 
  rename_with(~ paste0("POST.EFF_Q", 1:16), .cols = child_problems:difference_15) |> 
  mutate(
    across(
      ends_with(c("EFF_Q3", "EFF_Q5", "EFF_Q6", "EFF_Q8", "EFF_Q10", "EFF_Q12", "EFF_Q13", "EFF_Q15", "EFF_Q16")), 
      ~ 8 - .
    ) # For 1-7 reverse coding (8 - 1 = 7, 8 - 7 = 1)
  )

## Join for finalized set
POST_TEST <- left_join(
  x = post.mut,
  y = Participant_Assignments,
  by = "Assigned_Study_ID_Number"
) |> 
  select(
    "Study_ID" = Assigned_Study_ID_Number,
    Group_Assignment,
    contains("POST.PSS"),
    contains("POST.EFF")
  )

## Test Set (Calculated Scores only)
POST_TEST.scores <- POST_TEST |> 
  rowwise() |> 
  transmute(
    "Study_ID" = Study_ID,
    Group_Assignment,
    # CALC Scores
    "POST.PSS.sum"  = sum(c_across(contains("POST.PSS_Q")), na.rm = TRUE),
    "POST.PSS.mean" = mean(c_across(contains("POST.PSS_Q")), na.rm = TRUE),
    "POST.EFF.sum"  = sum(c_across(contains("POST.EFF_Q")), na.rm = TRUE),
    "POST.EFF.mean" = mean(c_across(contains("POST.EFF_Q")), na.rm = TRUE)
  ) |> 
  ungroup()

## View
POST_TEST.scores |> 
  kable(caption = "POSTTEST SCORES") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = FALSE) %>% 
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

POSTTEST SCORES
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

Study_ID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.PSS.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.PSS.mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.EFF.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.EFF.mean
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

60
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

6.12
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

72
</td>

<td style="text-align:right;">

4.50
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

29
</td>

<td style="text-align:right;">

2.90
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

5.44
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.56
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

99
</td>

<td style="text-align:right;">

6.19
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

</tr>

<tr>

<td style="text-align:right;">

NA
</td>

<td style="text-align:left;">

NA
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

NaN
</td>

<td style="text-align:right;">

0
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

29
</td>

<td style="text-align:right;">

2.90
</td>

<td style="text-align:right;">

61
</td>

<td style="text-align:right;">

3.81
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

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
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

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
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

33
</td>

<td style="text-align:right;">

3.30
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
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

29
</td>

<td style="text-align:right;">

2.90
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

6.12
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

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
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

29
</td>

<td style="text-align:right;">

2.90
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
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

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
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

30
</td>

<td style="text-align:right;">

3.00
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
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

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

86
</td>

<td style="text-align:right;">

5.38
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

33
</td>

<td style="text-align:right;">

3.30
</td>

<td style="text-align:right;">

84
</td>

<td style="text-align:right;">

5.25
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

36
</td>

<td style="text-align:right;">

3.60
</td>

<td style="text-align:right;">

86
</td>

<td style="text-align:right;">

5.38
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

26
</td>

<td style="text-align:right;">

2.60
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

84
</td>

<td style="text-align:right;">

5.25
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

29
</td>

<td style="text-align:right;">

2.90
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
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

29
</td>

<td style="text-align:right;">

2.90
</td>

<td style="text-align:right;">

112
</td>

<td style="text-align:right;">

7.00
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

31
</td>

<td style="text-align:right;">

3.10
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
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

34
</td>

<td style="text-align:right;">

3.40
</td>

<td style="text-align:right;">

82
</td>

<td style="text-align:right;">

5.12
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

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

67
</td>

<td style="text-align:right;">

4.19
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

32
</td>

<td style="text-align:right;">

3.20
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

42
</td>

<td style="text-align:right;">

4.20
</td>

<td style="text-align:right;">

93
</td>

<td style="text-align:right;">

5.81
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

25
</td>

<td style="text-align:right;">

2.50
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

</tbody>

</table>

</div>

# Finalize and Write Files

``` r
CCMHC_Study_Data_Finalized <- left_join(
  PRE_TEST |> filter(!is.na(Study_ID)),
  POST_TEST |> filter(!is.na(Study_ID)),
  by = c("Study_ID", "Group_Assignment")
) 

CCMHC_Study_Scores_Finalized <- left_join(
  PRE_TEST.scores |> filter(!is.na(Study_ID)),
  POST_TEST.scores |> filter(!is.na(Study_ID)),
  by = c("Study_ID", "Group_Assignment")
) 

save(CCMHC_Study_Data_Finalized, CCMHC_Study_Scores_Finalized,
     file = "../_output/Analytic_Tables_Finalize_2026-10.Rdata")

write.csv(x = CCMHC_Study_Scores_Finalized, file = "../_output/CCMHC_Study_Scores_Finalized.csv")
```

``` r
CCMHC_Study_Scores_Finalized |> 
  arrange(Group_Assignment) |> 
  kable(caption = "Finalized Scores") %>% 
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = FALSE) %>% 
  scroll_box(height = "400px", width = "100%")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:100%; ">

<table class="table table-striped table-hover" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

Finalized Scores
</caption>

<thead>

<tr>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

Study_ID
</th>

<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">

Group_Assignment
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.PSS.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.PSS.mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.EFF.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

PRE.EFF.mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.PSS.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.PSS.mean
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.EFF.sum
</th>

<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">

POST.EFF.mean
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

Control
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

2.3
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

1.67
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

<td style="text-align:right;">

NA
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

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

<td style="text-align:right;">

NA
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

36
</td>

<td style="text-align:right;">

3.6
</td>

<td style="text-align:right;">

101
</td>

<td style="text-align:right;">

6.31
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

16
</td>

<td style="text-align:right;">

1.6
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

<td style="text-align:right;">

29
</td>

<td style="text-align:right;">

2.9
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

5.44
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

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
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

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

78
</td>

<td style="text-align:right;">

4.88
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

72
</td>

<td style="text-align:right;">

4.50
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

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

6.12
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

32
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

4.00
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.6
</td>

<td style="text-align:right;">

97
</td>

<td style="text-align:right;">

6.06
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

30
</td>

<td style="text-align:right;">

3.0
</td>

<td style="text-align:right;">

17
</td>

<td style="text-align:right;">

5.67
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

<td style="text-align:right;">

NA
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

Intervention
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

6.33
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.0
</td>

<td style="text-align:right;">

99
</td>

<td style="text-align:right;">

6.19
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

22
</td>

<td style="text-align:right;">

2.2
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.0
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
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

28
</td>

<td style="text-align:right;">

2.8
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

67
</td>

<td style="text-align:right;">

4.19
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

32
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

67
</td>

<td style="text-align:right;">

4.19
</td>

<td style="text-align:right;">

29
</td>

<td style="text-align:right;">

2.9
</td>

<td style="text-align:right;">

61
</td>

<td style="text-align:right;">

3.81
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

22
</td>

<td style="text-align:right;">

2.2
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

5.44
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.6
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
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

21
</td>

<td style="text-align:right;">

2.1
</td>

<td style="text-align:right;">

87
</td>

<td style="text-align:right;">

5.44
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.0
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
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

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

85
</td>

<td style="text-align:right;">

5.31
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

3.3
</td>

<td style="text-align:right;">

90
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

22
</td>

<td style="text-align:right;">

2.2
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

3.3
</td>

<td style="text-align:right;">

84
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

22
</td>

<td style="text-align:right;">

2.2
</td>

<td style="text-align:right;">

90
</td>

<td style="text-align:right;">

5.62
</td>

<td style="text-align:right;">

29
</td>

<td style="text-align:right;">

2.9
</td>

<td style="text-align:right;">

98
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

28
</td>

<td style="text-align:right;">

2.8
</td>

<td style="text-align:right;">

88
</td>

<td style="text-align:right;">

5.50
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

86
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

15
</td>

<td style="text-align:right;">

1.5
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

6.44
</td>

<td style="text-align:right;">

29
</td>

<td style="text-align:right;">

2.9
</td>

<td style="text-align:right;">

112
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

23
</td>

<td style="text-align:right;">

2.3
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.6
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
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

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

91
</td>

<td style="text-align:right;">

5.69
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.6
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
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

18
</td>

<td style="text-align:right;">

1.8
</td>

<td style="text-align:right;">

96
</td>

<td style="text-align:right;">

6.00
</td>

<td style="text-align:right;">

26
</td>

<td style="text-align:right;">

2.6
</td>

<td style="text-align:right;">

92
</td>

<td style="text-align:right;">

5.75
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

35
</td>

<td style="text-align:right;">

3.5
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

<td style="text-align:right;">

42
</td>

<td style="text-align:right;">

4.2
</td>

<td style="text-align:right;">

93
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

17
</td>

<td style="text-align:right;">

1.7
</td>

<td style="text-align:right;">

80
</td>

<td style="text-align:right;">

5.00
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

3.1
</td>

<td style="text-align:right;">

83
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

35
</td>

<td style="text-align:right;">

3.5
</td>

<td style="text-align:right;">

83
</td>

<td style="text-align:right;">

5.19
</td>

<td style="text-align:right;">

30
</td>

<td style="text-align:right;">

3.0
</td>

<td style="text-align:right;">

92
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

27
</td>

<td style="text-align:right;">

2.7
</td>

<td style="text-align:right;">

95
</td>

<td style="text-align:right;">

5.94
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

3.2
</td>

<td style="text-align:right;">

89
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

17
</td>

<td style="text-align:right;">

1.7
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

6.12
</td>

<td style="text-align:right;">

36
</td>

<td style="text-align:right;">

3.6
</td>

<td style="text-align:right;">

86
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

30
</td>

<td style="text-align:right;">

3.0
</td>

<td style="text-align:right;">

74
</td>

<td style="text-align:right;">

4.62
</td>

<td style="text-align:right;">

34
</td>

<td style="text-align:right;">

3.4
</td>

<td style="text-align:right;">

82
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

37
</td>

<td style="text-align:right;">

3.7
</td>

<td style="text-align:right;">

81
</td>

<td style="text-align:right;">

5.06
</td>

<td style="text-align:right;">

29
</td>

<td style="text-align:right;">

2.9
</td>

<td style="text-align:right;">

83
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

17
</td>

<td style="text-align:right;">

1.7
</td>

<td style="text-align:right;">

81
</td>

<td style="text-align:right;">

5.06
</td>

<td style="text-align:right;">

25
</td>

<td style="text-align:right;">

2.5
</td>

<td style="text-align:right;">

89
</td>

<td style="text-align:right;">

5.56
</td>

</tr>

</tbody>

</table>

</div>
