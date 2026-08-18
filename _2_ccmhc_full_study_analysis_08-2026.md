SMITH-STUDY: Updated_Data Process; STRESS-Scale and Self-Efficacy Scale
(EIPSES)
================
2026-08-17

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

#install.packages("skimr")
#install.packages("gtExtras") # testing: used for quick summaries and viz
```

## 1.2 Load Data

### 1.2.0 !! Updated Data File:

- **UPDATED DATA FILE** - SEFF_Updated…
  - Both Surveys are connected to a single participant ID (Pre and Post)
    and collated in one spreadsheet
  - Transformed to numeric, scored, and saved in
    [Autism_Doula_Study_data_ingestion.Rmd](SEFF_Updated_Data_File_08-2026.Rmd)
- **Structure**
  - Study_ID (Joined ID across pre and post, unique to participant)
  - Group Assignment (Control or Intervention)
  - Stress Scale: **PSS** - *Perceived Stress Scale* - 10 Questions
  - SEFF Scale: **EFF** - *Early Intervention Parent Self Efficacy* - 14
    Questions
  - Columns as Pre –\> Post

# 1. Load Analaysis Tables and Write File for Download/Use

``` r
analytic.files <- read_rds("../_data/analytic_files_scored_surveys.Rds")

EFF.scored <- analytic.files$EFF.scored
PSS.scored <- analytic.files$PSS.Scored
```

``` r
library(gtExtras)

PSS.scored %>% 
  mutate(StudyID = factor(StudyID), Group_Assignment = factor(Group_Assignment)) %>%  
  select(StudyID, Group_Assignment, contains("PRE_S"), contains("POST_S")) %>% 
  gt_plt_summary()
```

<div id="gjwchkeoom" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#gjwchkeoom table {
  font-family: Lato, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#gjwchkeoom thead, #gjwchkeoom tbody, #gjwchkeoom tfoot, #gjwchkeoom tr, #gjwchkeoom td, #gjwchkeoom th {
  border-style: none;
}
&#10;#gjwchkeoom p {
  margin: 0;
  padding: 0;
}
&#10;#gjwchkeoom .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 3px;
  border-top-color: #FFFFFF;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#gjwchkeoom .gt_title {
  color: #333333;
  font-size: 24px;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#gjwchkeoom .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#gjwchkeoom .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 0px;
  border-bottom-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_col_headings {
  border-top-style: solid;
  border-top-width: 0px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#gjwchkeoom .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#gjwchkeoom .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#gjwchkeoom .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#gjwchkeoom .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#gjwchkeoom .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#gjwchkeoom .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#gjwchkeoom .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#gjwchkeoom .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#gjwchkeoom .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#gjwchkeoom .gt_row {
  padding-top: 7px;
  padding-bottom: 7px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #F6F7F7;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#gjwchkeoom .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gjwchkeoom .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#gjwchkeoom .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#gjwchkeoom .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#gjwchkeoom .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gjwchkeoom .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#gjwchkeoom .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gjwchkeoom .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_striped {
  background-color: #FAFAFA;
}
&#10;#gjwchkeoom .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gjwchkeoom .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#gjwchkeoom .gt_sourcenote {
  font-size: 12px;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gjwchkeoom .gt_left {
  text-align: left;
}
&#10;#gjwchkeoom .gt_center {
  text-align: center;
}
&#10;#gjwchkeoom .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#gjwchkeoom .gt_font_normal {
  font-weight: normal;
}
&#10;#gjwchkeoom .gt_font_bold {
  font-weight: bold;
}
&#10;#gjwchkeoom .gt_font_italic {
  font-style: italic;
}
&#10;#gjwchkeoom .gt_super {
  font-size: 65%;
}
&#10;#gjwchkeoom .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#gjwchkeoom .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#gjwchkeoom .gt_indent_1 {
  text-indent: 5px;
}
&#10;#gjwchkeoom .gt_indent_2 {
  text-indent: 10px;
}
&#10;#gjwchkeoom .gt_indent_3 {
  text-indent: 15px;
}
&#10;#gjwchkeoom .gt_indent_4 {
  text-indent: 20px;
}
&#10;#gjwchkeoom .gt_indent_5 {
  text-indent: 25px;
}
&#10;#gjwchkeoom .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#gjwchkeoom div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="7" class="gt_heading gt_title gt_font_normal" style>.</td>
    </tr>
    <tr class="gt_heading">
      <td colspan="7" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>31 rows x 8 cols</td>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="type"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="name">Column</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="value">Plot Overview</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="n_missing">Missing</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Mean">Mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Median">Median</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="SD">SD</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="type" class="gt_row gt_left"><svg aria-hidden="true" role="img" viewBox="0 0 512 512" style="height:20px;width:20px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#4e79a7;overflow:visible;position:relative;"><path d="M40 48C26.7 48 16 58.7 16 72v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V72c0-13.3-10.7-24-24-24H40zM192 64c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zM16 232v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V232c0-13.3-10.7-24-24-24H40c-13.3 0-24 10.7-24 24zM40 368c-13.3 0-24 10.7-24 24v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V392c0-13.3-10.7-24-24-24H40z"/></svg></td>
<td headers="name" class="gt_row gt_left" style="font-weight: bold;"><div style='max-width: 150px;'>
    <details style='font-weight: normal !important;'>
    <summary style='font-weight: bold !important;'>StudyID</summary>
1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 22, 26, 28, 32, 39, 40, 42, 44, 45, 50, 51, 53, 56, 58, 59 and 60
</details></div></td>
<td headers="value" class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8Mi45OXwyMy42MQ=='>    <rect x='1.00' y='2.99' width='139.74' height='20.62' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8Mi45OXwyMy42MQ==)'><rect x='136.23' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #DDEAF7;' /><rect x='131.72' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #D8E6F5;' /><rect x='127.21' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #D3E3F3;' /><rect x='122.71' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #CEDFF1;' /><rect x='118.20' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #C9DBEF;' /><rect x='113.69' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #C4D8ED;' /><rect x='109.18' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #BFD4EB;' /><rect x='104.67' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #BAD0E9;' /><rect x='100.17' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #B5CDE8;' /><rect x='95.66' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #B0C9E6;' /><rect x='91.15' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #ABC6E4;' /><rect x='86.64' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #A5C2E2;' /><rect x='82.14' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #A0BEE0;' /><rect x='77.63' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #9BBBDE;' /><rect x='73.12' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #96B7DC;' /><rect x='68.61' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #91B4DA;' /><rect x='64.10' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #8BB0D8;' /><rect x='59.60' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #86ADD6;' /><rect x='55.09' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #80A9D4;' /><rect x='50.58' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #7BA6D2;' /><rect x='46.07' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #75A3D0;' /><rect x='41.57' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #709FCE;' /><rect x='37.06' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #6A9CCD;' /><rect x='32.55' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #6498CB;' /><rect x='28.04' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #5E95C9;' /><rect x='23.53' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #5792C7;' /><rect x='19.03' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #518EC5;' /><rect x='14.52' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #4A8BC3;' /><rect x='10.01' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #4288C1;' /><rect x='5.50' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #3A84BF;' /><rect x='1.00' y='3.93' width='4.51' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #3181BD;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><text x='1.00' y='30.18' style='font-size: 8.00px; font-family: "Arial";' textLength='48.06px' lengthAdjust='spacingAndGlyphs'>31 categories</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right">0.0%</td>
<td headers="Mean" class="gt_row gt_right">—</td>
<td headers="Median" class="gt_row gt_right">—</td>
<td headers="SD" class="gt_row gt_right">—</td></tr>
    <tr><td headers="type" class="gt_row gt_left gt_striped"><svg aria-hidden="true" role="img" viewBox="0 0 512 512" style="height:20px;width:20px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#4e79a7;overflow:visible;position:relative;"><path d="M40 48C26.7 48 16 58.7 16 72v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V72c0-13.3-10.7-24-24-24H40zM192 64c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zm0 160c-17.7 0-32 14.3-32 32s14.3 32 32 32H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H192zM16 232v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V232c0-13.3-10.7-24-24-24H40c-13.3 0-24 10.7-24 24zM40 368c-13.3 0-24 10.7-24 24v48c0 13.3 10.7 24 24 24H88c13.3 0 24-10.7 24-24V392c0-13.3-10.7-24-24-24H40z"/></svg></td>
<td headers="name" class="gt_row gt_left gt_striped" style="font-weight: bold;"><div style='max-width: 150px;'>
    <details style='font-weight: normal !important;'>
    <summary style='font-weight: bold !important;'>Group_Assignment</summary>
Intervention and Control
</details></div></td>
<td headers="value" class="gt_row gt_center gt_striped"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8Mi45OXwyMy42MQ=='>    <rect x='1.00' y='2.99' width='139.74' height='20.62' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8Mi45OXwyMy42MQ==)'><rect x='109.18' y='3.93' width='31.55' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #DDEAF7;' /><rect x='1.00' y='3.93' width='108.19' height='18.75' style='stroke-width: 1.07; stroke: none; stroke-linecap: butt; stroke-linejoin: miter; fill: #3181BD;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><text x='1.00' y='30.18' style='font-size: 8.00px; font-family: "Arial";' textLength='43.61px' lengthAdjust='spacingAndGlyphs'>2 categories</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right gt_striped">0.0%</td>
<td headers="Mean" class="gt_row gt_right gt_striped">—</td>
<td headers="Median" class="gt_row gt_right gt_striped">—</td>
<td headers="SD" class="gt_row gt_right gt_striped">—</td></tr>
    <tr><td headers="type" class="gt_row gt_left"><svg aria-hidden="true" role="img" viewBox="0 0 640 512" style="height:20px;width:25px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#f18e2c;overflow:visible;position:relative;"><path d="M576 0c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32c0-17.7 14.3-32 32-32zM448 96c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V128c0-17.7 14.3-32 32-32zM352 224V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V224c0-17.7 14.3-32 32-32s32 14.3 32 32zM192 288c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V320c0-17.7 14.3-32 32-32zM96 416v64c0 17.7-14.3 32-32 32s-32-14.3-32-32V416c0-17.7 14.3-32 32-32s32 14.3 32 32z"/></svg></td>
<td headers="name" class="gt_row gt_left" style="font-weight: bold;">PRE_Stress.Total</td>
<td headers="value" class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng=='>    <rect x='1.00' y='1.00' width='139.74' height='22.56' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng==)'><rect x='7.35' y='5.51' width='31.76' height='18.05' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='39.11' y='1.00' width='31.76' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='70.87' y='1.00' width='31.76' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='102.63' y='16.79' width='31.76' height='6.77' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><circle cx='12.20' cy='21.30' r='0.46' style='stroke-width: 0.71; stroke: none;' /><circle cx='12.20' cy='21.30' r='0.46' style='stroke-width: 0.71; stroke: none;' /><line x1='69.55' y1='23.56' x2='69.55' y2='1.00' style='stroke-width: 1.07; stroke-linecap: butt;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><polyline points='1.00,23.56 140.74,23.56 ' style='stroke-width: 0.75;' /><polyline points='13.16,26.39 13.16,23.56 ' style='stroke-width: 0.75;' /><polyline points='108.59,26.39 108.59,23.56 ' style='stroke-width: 0.75;' /><text x='13.16' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='21.56px' lengthAdjust='spacingAndGlyphs'>5 auto</text><text x='108.59' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='25.16px' lengthAdjust='spacingAndGlyphs'>27 auto</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right">0.0%</td>
<td headers="Mean" class="gt_row gt_right">16.0</td>
<td headers="Median" class="gt_row gt_right">18.0</td>
<td headers="SD" class="gt_row gt_right">7.0</td></tr>
    <tr><td headers="type" class="gt_row gt_left gt_striped"><svg aria-hidden="true" role="img" viewBox="0 0 640 512" style="height:20px;width:25px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#f18e2c;overflow:visible;position:relative;"><path d="M576 0c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32c0-17.7 14.3-32 32-32zM448 96c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V128c0-17.7 14.3-32 32-32zM352 224V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V224c0-17.7 14.3-32 32-32s32 14.3 32 32zM192 288c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V320c0-17.7 14.3-32 32-32zM96 416v64c0 17.7-14.3 32-32 32s-32-14.3-32-32V416c0-17.7 14.3-32 32-32s32 14.3 32 32z"/></svg></td>
<td headers="name" class="gt_row gt_left gt_striped" style="font-weight: bold;">PRE_Stress.Mean</td>
<td headers="value" class="gt_row gt_center gt_striped"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng=='>    <rect x='1.00' y='1.00' width='139.74' height='22.56' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng==)'><rect x='7.35' y='5.51' width='31.76' height='18.05' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='39.11' y='1.00' width='31.76' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='70.87' y='1.00' width='31.76' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='102.63' y='16.79' width='31.76' height='6.77' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><circle cx='12.20' cy='21.30' r='0.46' style='stroke-width: 0.71; stroke: none;' /><circle cx='12.20' cy='21.30' r='0.46' style='stroke-width: 0.71; stroke: none;' /><line x1='69.55' y1='23.56' x2='69.55' y2='1.00' style='stroke-width: 1.07; stroke-linecap: butt;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><polyline points='1.00,23.56 140.74,23.56 ' style='stroke-width: 0.75;' /><polyline points='13.16,26.39 13.16,23.56 ' style='stroke-width: 0.75;' /><polyline points='108.59,26.39 108.59,23.56 ' style='stroke-width: 0.75;' /><text x='13.16' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='32.34px' lengthAdjust='spacingAndGlyphs'>500 mauto</text><text x='108.59' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='21.56px' lengthAdjust='spacingAndGlyphs'>3 auto</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right gt_striped">0.0%</td>
<td headers="Mean" class="gt_row gt_right gt_striped">1.6</td>
<td headers="Median" class="gt_row gt_right gt_striped">1.8</td>
<td headers="SD" class="gt_row gt_right gt_striped">0.7</td></tr>
    <tr><td headers="type" class="gt_row gt_left"><svg aria-hidden="true" role="img" viewBox="0 0 640 512" style="height:20px;width:25px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#f18e2c;overflow:visible;position:relative;"><path d="M576 0c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32c0-17.7 14.3-32 32-32zM448 96c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V128c0-17.7 14.3-32 32-32zM352 224V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V224c0-17.7 14.3-32 32-32s32 14.3 32 32zM192 288c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V320c0-17.7 14.3-32 32-32zM96 416v64c0 17.7-14.3 32-32 32s-32-14.3-32-32V416c0-17.7 14.3-32 32-32s32 14.3 32 32z"/></svg></td>
<td headers="name" class="gt_row gt_left" style="font-weight: bold;">PRE_Stress.StDev</td>
<td headers="value" class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng=='>    <rect x='1.00' y='1.00' width='139.74' height='22.56' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng==)'><rect x='7.35' y='16.79' width='14.12' height='6.77' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='21.46' y='19.04' width='14.12' height='4.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='35.58' y='10.02' width='14.12' height='13.54' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='49.69' y='1.00' width='14.12' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='63.81' y='12.28' width='14.12' height='11.28' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='77.92' y='21.30' width='14.12' height='2.26' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='92.04' y='19.04' width='14.12' height='4.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='106.15' y='21.30' width='14.12' height='2.26' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='120.27' y='21.30' width='14.12' height='2.26' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><circle cx='7.64' cy='21.30' r='0.46' style='stroke-width: 0.71; stroke: none;' /><circle cx='7.64' cy='21.30' r='0.46' style='stroke-width: 0.71; stroke: none;' /><line x1='54.22' y1='23.56' x2='54.22' y2='1.00' style='stroke-width: 1.07; stroke-linecap: butt;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><polyline points='1.00,23.56 140.74,23.56 ' style='stroke-width: 0.75;' /><polyline points='8.80,26.39 8.80,23.56 ' style='stroke-width: 0.75;' /><polyline points='125.03,26.39 125.03,23.56 ' style='stroke-width: 0.75;' /><text x='8.80' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='32.34px' lengthAdjust='spacingAndGlyphs'>316 mauto</text><text x='125.03' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='21.56px' lengthAdjust='spacingAndGlyphs'>1 auto</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right">0.0%</td>
<td headers="Mean" class="gt_row gt_right">0.7</td>
<td headers="Median" class="gt_row gt_right">0.7</td>
<td headers="SD" class="gt_row gt_right">0.2</td></tr>
    <tr><td headers="type" class="gt_row gt_left gt_striped"><svg aria-hidden="true" role="img" viewBox="0 0 640 512" style="height:20px;width:25px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#f18e2c;overflow:visible;position:relative;"><path d="M576 0c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32c0-17.7 14.3-32 32-32zM448 96c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V128c0-17.7 14.3-32 32-32zM352 224V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V224c0-17.7 14.3-32 32-32s32 14.3 32 32zM192 288c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V320c0-17.7 14.3-32 32-32zM96 416v64c0 17.7-14.3 32-32 32s-32-14.3-32-32V416c0-17.7 14.3-32 32-32s32 14.3 32 32z"/></svg></td>
<td headers="name" class="gt_row gt_left gt_striped" style="font-weight: bold;">POST_Stress.Total</td>
<td headers="value" class="gt_row gt_center gt_striped"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng=='>    <rect x='1.00' y='1.00' width='139.74' height='22.56' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng==)'><rect x='7.35' y='21.05' width='25.41' height='2.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='32.76' y='18.54' width='25.41' height='5.01' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='58.16' y='6.01' width='25.41' height='17.55' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='83.57' y='1.00' width='25.41' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='108.98' y='13.53' width='25.41' height='10.03' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><circle cx='19.03' cy='21.05' r='0.46' style='stroke-width: 0.71; stroke: none;' /><circle cx='19.03' cy='21.05' r='0.46' style='stroke-width: 0.71; stroke: none;' /><line x1='92.31' y1='23.56' x2='92.31' y2='1.00' style='stroke-width: 1.07; stroke-linecap: butt;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><polyline points='1.00,23.56 140.74,23.56 ' style='stroke-width: 0.75;' /><polyline points='20.05,26.39 20.05,23.56 ' style='stroke-width: 0.75;' /><polyline points='122.06,26.39 122.06,23.56 ' style='stroke-width: 0.75;' /><text x='20.05' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='21.56px' lengthAdjust='spacingAndGlyphs'>0 auto</text><text x='122.06' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='25.16px' lengthAdjust='spacingAndGlyphs'>24 auto</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right gt_striped">25.8%</td>
<td headers="Mean" class="gt_row gt_right gt_striped">15.1</td>
<td headers="Median" class="gt_row gt_right gt_striped">17.0</td>
<td headers="SD" class="gt_row gt_right gt_striped">5.9</td></tr>
    <tr><td headers="type" class="gt_row gt_left"><svg aria-hidden="true" role="img" viewBox="0 0 640 512" style="height:20px;width:25px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#f18e2c;overflow:visible;position:relative;"><path d="M576 0c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32c0-17.7 14.3-32 32-32zM448 96c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V128c0-17.7 14.3-32 32-32zM352 224V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V224c0-17.7 14.3-32 32-32s32 14.3 32 32zM192 288c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V320c0-17.7 14.3-32 32-32zM96 416v64c0 17.7-14.3 32-32 32s-32-14.3-32-32V416c0-17.7 14.3-32 32-32s32 14.3 32 32z"/></svg></td>
<td headers="name" class="gt_row gt_left" style="font-weight: bold;">POST_Stress.Mean</td>
<td headers="value" class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng=='>    <rect x='1.00' y='1.00' width='139.74' height='22.56' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng==)'><rect x='7.35' y='21.05' width='25.41' height='2.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='32.76' y='18.54' width='25.41' height='5.01' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='58.16' y='6.01' width='25.41' height='17.55' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='83.57' y='1.00' width='25.41' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='108.98' y='13.53' width='25.41' height='10.03' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><circle cx='19.03' cy='21.05' r='0.46' style='stroke-width: 0.71; stroke: none;' /><circle cx='19.03' cy='21.05' r='0.46' style='stroke-width: 0.71; stroke: none;' /><line x1='92.31' y1='23.56' x2='92.31' y2='1.00' style='stroke-width: 1.07; stroke-linecap: butt;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><polyline points='1.00,23.56 140.74,23.56 ' style='stroke-width: 0.75;' /><polyline points='20.05,26.39 20.05,23.56 ' style='stroke-width: 0.75;' /><polyline points='122.06,26.39 122.06,23.56 ' style='stroke-width: 0.75;' /><text x='20.05' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='28.75px' lengthAdjust='spacingAndGlyphs'>0.0 auto</text><text x='122.06' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='28.75px' lengthAdjust='spacingAndGlyphs'>2.4 auto</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right">25.8%</td>
<td headers="Mean" class="gt_row gt_right">1.5</td>
<td headers="Median" class="gt_row gt_right">1.7</td>
<td headers="SD" class="gt_row gt_right">0.6</td></tr>
    <tr><td headers="type" class="gt_row gt_left gt_striped"><svg aria-hidden="true" role="img" viewBox="0 0 640 512" style="height:20px;width:25px;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#f18e2c;overflow:visible;position:relative;"><path d="M576 0c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V32c0-17.7 14.3-32 32-32zM448 96c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V128c0-17.7 14.3-32 32-32zM352 224V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V224c0-17.7 14.3-32 32-32s32 14.3 32 32zM192 288c17.7 0 32 14.3 32 32V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V320c0-17.7 14.3-32 32-32zM96 416v64c0 17.7-14.3 32-32 32s-32-14.3-32-32V416c0-17.7 14.3-32 32-32s32 14.3 32 32z"/></svg></td>
<td headers="name" class="gt_row gt_left gt_striped" style="font-weight: bold;">POST_Stress.StDev</td>
<td headers="value" class="gt_row gt_center gt_striped"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='141.73pt' height='34.02pt' viewBox='0 0 141.73 34.02'><g class='svglite'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }    .svglite g.glyphgroup path {      fill: inherit;      stroke: none;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg=='>    <rect x='0.00' y='0.00' width='141.73' height='34.02' />  </clipPath></defs><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><rect x='0.00' y='0.00' width='141.73' height='34.02' style='stroke-width: 0.00; stroke: none;' /></g><defs>  <clipPath id='cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng=='>    <rect x='1.00' y='1.00' width='139.74' height='22.56' />  </clipPath></defs><g clip-path='url(#cpMS4wMHwxNDAuNzR8MS4wMHwyMy41Ng==)'><rect x='7.35' y='21.05' width='14.12' height='2.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='21.46' y='23.56' width='14.12' height='0.00' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='35.58' y='21.05' width='14.12' height='2.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='49.69' y='1.00' width='14.12' height='22.56' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='63.81' y='8.52' width='14.12' height='15.04' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='77.92' y='13.53' width='14.12' height='10.03' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='92.04' y='23.56' width='14.12' height='0.00' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='106.15' y='21.05' width='14.12' height='2.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><rect x='120.27' y='21.05' width='14.12' height='2.51' style='stroke-width: 1.07; stroke: #FFFFFF; stroke-linecap: butt; stroke-linejoin: miter; fill: #F8BB87;' /><circle cx='13.26' cy='21.05' r='0.46' style='stroke-width: 0.71; stroke: none;' /><circle cx='13.26' cy='21.05' r='0.46' style='stroke-width: 0.71; stroke: none;' /><line x1='66.06' y1='23.56' x2='66.06' y2='1.00' style='stroke-width: 1.07; stroke-linecap: butt;' /></g><g clip-path='url(#cpMC4wMHwxNDEuNzN8MC4wMHwzNC4wMg==)'><polyline points='1.00,23.56 140.74,23.56 ' style='stroke-width: 0.75;' /><polyline points='14.41,26.39 14.41,23.56 ' style='stroke-width: 0.75;' /><polyline points='128.50,26.39 128.50,23.56 ' style='stroke-width: 0.75;' /><text x='14.41' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='28.75px' lengthAdjust='spacingAndGlyphs'>0.0 auto</text><text x='128.50' y='33.36' text-anchor='middle' style='font-size: 6.00px; font-weight: 0; font-family: "Courier";' textLength='28.75px' lengthAdjust='spacingAndGlyphs'>1.5 auto</text></g></g></svg></td>
<td headers="n_missing" class="gt_row gt_right gt_striped">25.8%</td>
<td headers="Mean" class="gt_row gt_right gt_striped">0.7</td>
<td headers="Median" class="gt_row gt_right gt_striped">0.7</td>
<td headers="SD" class="gt_row gt_right gt_striped">0.3</td></tr>
  </tbody>
  &#10;</table>
</div>

— OUTLINE — Descriptives and Participant Checks (Missing Data / NAs)
Basic Histo/Frequency Etc… Difference Scores Dot Plots

— Stats — Scale Validation

— Tests — Pre & Post

— Models — Pre/Post Linear Mixed Models Etc…

| Category               | N    | Mean | S.D.  |
|------------------------|------|------|-------|
| Gender<br>Male         | 926  | 12.1 | 5.9   |
| Gender<br>Female       | 1406 | 13.7 | 6.6   |
| Age<br>18-29           | 645  | 14.2 | 6.2   |
| Age<br>30-44           | 750  | 13.0 | 6.2   |
| Age<br>45-54           | 285  | 12.6 | 6.1   |
| Age<br>55-64           | 282  | 11.9 | 6.9   |
| Age<br>65 & older      | 296  | 12.0 | 6.3   |
| Race<br>White          | 1924 | 12.8 | 6.2   |
| Race<br>Hispanic       | 98   | 14.0 | 6.9   |
| Race<br>Black          | 176  | 14.7 | 7.2   |
| Race<br>Other Minority | 50   | 14.1 | 5.0e; |
