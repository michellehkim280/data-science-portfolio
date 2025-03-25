# DS4002_Project2

## Software and Platform
### Coding for this project was done in both R studio and Python.
- R Packages: dplyr, ggplot2, zoo, forecast
- Python Packages: pandas, matplotlib.pyplot, scipy
- Performed in both Windows and Mac.

## Documentation Map
### 1) SCRIPTS - This folder includes our source code for the project with detailed comments outlining the actions being taken to clean and analyze the dataset.
- ARIMA_modeling.R: This R code includes the ARIMA modelling method used to forecast changes in vaccinaiton coverage rate over time as a result of the COVID-19 pandemic.
- Intial_EDA.ipynb: This python code was used to produce the graphs in Initial EDA.pdf that served to provide preliminary information to guide further analysis. Additionally, the file includes statistical analysis comparing differences between influenza vaccination coverage before and after the COVID-19 Pandemic.
### 2) DATA - This folder holds our raw data, as well as our finalized data that was used to drive analysis.
- COVID-19_Case_Surveillance_Public_Use_Data_with_Geography_20241017.csv: Initial dataset containing COVID-19 total case count data over time.
- Influenza_Vaccination_Coverage_for_All_Ages__6__Months__20241016 (3).csv: Initial dataset containing influenza vaccination coverage % across the state of Virginia over time.
- Vaccination_and_cases.csv: Cleaned dataset containing both COVID-19 case count data and Influenza vaccinaiton coverage data over time.
### 3) OUTPUT - This folder includes the output of our analysis, including charts and graphs to support or oppose our hypothesis.
- Initial EDA.pdf: Includes graphs outlining vaccination coverage over time from Vaccination_and_cases.csv.
- Output.pdf: This file includes graphs collected through ARIMA model analysis and future forecasting of influenza vaccination coverage from ARIMA_modeling.R file.

## Reproducing Results
#### 1) Download both COVID-19_Case_Surveillance_Public_Use_Data_with_Geography_20241017.csv and Influenza_Vaccination_Coverage_for_All_Ages__6__Months__20241016 (3).csv.
#### 2) Combine datasets with same Date column in Excel, or download Vaccination_and_cases.csv for cleaned combined dataset. When creating the final dataset with the two intial datasets, we first filtered into just Virginia of the "Geography" column of the Influenza Vaccaination Coverage dataset and then combined the "Season/Survey Year" and "Month" columns into a single column with a concatenation formula. Next, we removed all columns except for Estimate (%), 95% CI (%), Sample Size, and the new Data column. Lastly, we copied over the "Cases" column from the second dataset of COVID-19 Cases and added it in as a new column in the final dataset.
#### 3) Run Initial_EDA.ipynb to perform Exploratory Data Analysis and produce graphs to be saved in Initial EDA.pdf, additionally, save statistical analysis output.
#### 4) Run ARIMA_modeling.R to perform analysis on both COVID-19 case data and influenza vaccination coverage data to produce forecasted projections for influenza vaccination coverage.
#### 5) Save forecasting graphs from ARIMA_modeling.R into Outputs.pdf file.


