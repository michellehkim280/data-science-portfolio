# DS4002-Group9

## Section 1: Software and Platform

### Two main types of software were used to complete our Analysis

###   1) R Studio
####   Packages used: dplyr, ggplot2, tm, stringr
###   2) Python
####   Packages used: pandas, matplotlib.pyplot, seaborn

### Both Mac and Windows platforms were used to conduct our analysis

## Section 2: Map of Documentation
### In this repository, we have 3 main folders:
#### 1) SCRIPTS - This folder includes our source code for the project with detailed comments outlining the actions being taken to clean and analyze the dataset.

##### CleaningSentimentAnalysis: code to clean the data, calculate sentiment scores, and form datasets for analysis. Additionally includes code that generates graphs located in output.
##### InitialEDA: code to perform Exploratory Data Analysis using python. 

#### 2) DATA - This folder holds our raw data, as well as our finalized data that was used to drive analysis.

##### Data Appendix: description of sentimentdf variables and descriptive graphs. 
##### drugsComTest_raw: raw text data of drug reviews; intitial dataset from Kaggle.
##### lessbc: top 10 least reviewed birth control drug brands (over threshold of 20) separated from sentimentdf dataset.
##### sentimentdf: sentiment score added to initial dataset filtered by birth control. 
##### toptenbc: top 10 most reviewed birth control drug brands separated from sentimentdf dataset. 

#### 3) OUTPUT - This folder includes the output of our analysis, including charts and graphs to support or oppose our hypothesis. 

##### Project 1 Output: file holding graphs produced from CleaningSentimentAnalysis file.

## Section 3: Instructions for Reproducing Results

####  1. Download drugsComTest_raw and save locally. 
####  2. Set working directory in R to location of drugsComTest_raw.
####  3. To clean data and add sentiment analysis score columns, follow CleaningSentimentAnalysis file in SCRIPTS.
####  4. Resulting dataset should match sentimentdf file, if not, download sentiment df file and proceed.
####  5. Follow InitialEDA on python on sentimentdf file to perform EDA.
####  6. Create filtered lessbc and toptenbc by following sentimentdf file, results should match lessbc and toptenbc files located in DATA.
####  7. Save graphs created from CleaningSentimentAnalysis file into seperate pdf labeled Project 1 Output file.
