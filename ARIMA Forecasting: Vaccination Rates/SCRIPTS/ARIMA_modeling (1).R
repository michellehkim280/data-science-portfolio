# ARIMA Modeling Code
# The following R script encompasses the code for additional data cleaning, as
# well as ARIMA modeling to forecast values of both COVID-19 cases and flu 
# vaccination ratings after 2024. This script also includes ARIMA modeling for 
# flu vaccination estimates for 2021 to 2024 to investigate whether a 
# model forecasts values that resemble actual values. The following code allows
# us to investigate whether #COVID-19 case trends seem to inlfuence flu
# vaccination cases. 

# Set working directory to file location
# setwd("file path")

### INSTALL PACKAGES AND LIBRARIES ###

# If packages not yet installed, first use the code: install.packages("package name")
library(dplyr)
library(ggplot2)
library(zoo)
library(forecast) #ARIMA package

### CLEAN AND SEPARATE DATA INTO TWO DATASETS ###

data <- read.csv('Vaccination_and_cases.csv')

#FLU DATASET CLEANING ---------
# Renaming date and flu vaccination estimates variable names 
flu_data1 <- data.frame(date = data$Date, estimate = data$Estimate....)

# Check the column names
names(flu_data1)

# Replace rows where 'estimate' is 'NR' or 'NR †' to 0
clean_flu <- flu_data1 %>% 
  mutate(estimate = na_if(estimate, "NR"),   # Replace "NR" with NA
         estimate = na_if(estimate, "NR †")) %>%  # Replace "NR †" with NA
  mutate(estimate = ifelse(is.na(estimate), 0, estimate))
  
# Convert flu 'estimate' column to numeric 
clean_flu$estimate <- as.numeric(clean_flu$estimate)

# Convert flu 'date' column to yearmon format
clean_flu$date <- as.yearmon(clean_flu$date, format = "%Y-%m")

# COVID DATASET CLEANING -----------
covid_data2 <- data.frame(date = data$Date, covid = data$Cases)
# Filter out rows where 'covid' is 'NR'
clean_covid <- subset(covid_data2, covid != "NR")

# Convert 'covid' column to numeric
clean_covid$covid <- as.numeric(clean_covid$covid)

# Convert covid 'date' column to yearmon format
clean_covid$date <- as.yearmon(clean_covid$date, format = "%Y-%m")

# Verify the date conversion - both should be 'yearmon'
class(clean_flu$date)
class(clean_covid$date)

### PLOT INFLUENZA VACCINE COVERAGE OVER TIME ###

# Merge the datasets on the 'date' column
clean_combined <- merge(clean_flu, clean_covid, by = "date", all = TRUE)

# Plot the data using ggplot2
ggplot(clean_combined, aes(x = as.Date(date))) +
  geom_line(aes(y = estimate, color = "Flu Vaccination Estimates")) +
  geom_line(aes(y = covid / max(clean_combined$covid, na.rm = TRUE) * 100, color = "COVID-19 Cases")) +
  scale_y_continuous(
    name = "Flu Vaccination Estimates (%)",
    limits = c(0, 100),
    sec.axis = sec_axis(~ . * max(clean_combined$covid, na.rm = TRUE) / 100, name = "COVID-19 Cases")
  ) +
  labs(title = "Flu Vaccination Estimates and COVID-19 Cases Over Time",
       x = "Date") +
  theme_minimal() +
  scale_color_manual(values = c("Flu Vaccination Estimates" = "blue", "COVID-19 Cases" = "red")) +
  theme(legend.position = "bottom")

### ARIMA ANALYSIS AND FORECASTS ###

# Fit ARIMA model for flu vaccination data
# Creating a time series variable 
ts_flu <- ts(clean_flu$estimate, start = c(2013, 1), frequency = 12) # Freq = 12 periods in a cycle (monthly)
model_flu <- auto.arima(ts_flu)
# Forecasting values for next 36 months
forecasted_data_flu <- forecast(model_flu, h = 36) # Forecasting next 36 mo

# Fit ARIMA model for COVID-19 case data
# Creating a time series variable
ts_covid <- ts(clean_covid$covid, start = c(2013, 1), frequency = 12)
model_covid <- auto.arima(ts_covid)
forecasted_data_covid <- forecast(model_covid, h = 36)

# Create forecast data frames
forecast_dates <- seq(from = max(clean_flu$date) + 1/12, by = 1/12, length.out = 36)
forecasted_data_flu <- data.frame(date = forecast_dates, estimate = as.numeric(forecasted_data_flu$mean))
forecasted_data_covid <- data.frame(date = forecast_dates, covid = as.numeric(forecasted_data_covid$mean))

# Combine actual and forecasted data
combined_flu <- rbind(clean_flu, forecasted_data_flu)
combined_covid <- rbind(clean_covid, forecasted_data_covid)

# Merge datasets on 'date' column
combined_data <- merge(combined_flu, combined_covid, by = "date", all = TRUE)

# Remove NA values reintroduced in flu vaccination estimates (June, July)
combined_data <- combined_data[!is.na(combined_data$estimate), ]

# Plot the data
ggplot(combined_data, aes(x = as.Date(date))) +
  geom_line(aes(y = estimate, color = "Flu Vaccination Estimates")) +
  geom_line(aes(y = covid / max(combined_data$covid, na.rm = TRUE) * 100, color = "COVID-19 Cases")) +
  scale_y_continuous(
    name = "Flu Vaccination Estimates (%)",
    limits = c(0, 100),
    sec.axis = sec_axis(~ . * max(combined_data$covid, na.rm = TRUE) / 100, name = "COVID-19 Cases")
  ) +
  labs(title = "Flu Vaccination Estimates and COVID-19 Cases Over Time",
       x = "Date") +
  theme_minimal() +
  scale_color_manual(values = c("Flu Vaccination Estimates" = "blue", "COVID-19 Cases" = "red")) +
  theme(legend.position = "bottom")

# Plot the forecasted values only (zooming in on pattern)
# Flu forecasted values
ggplot(forecasted_data_flu, aes(x=date, y=estimate))+geom_line(color="blue")+
  labs(x="Date", y="Projected Vaccination Rate", title="Forecasting of Vaccination Coverage")

#Covid forecasted values
ggplot(forecasted_data_covid, aes(x=date, y=covid))+geom_line(color="red")+
  labs(x="Date", y="Projected Covid Cases", title="Forecasting of COVID-19 Cases")

# PART 2 ----------------------------------------------------------------
# COVID-19 cases reached a maximum of 419,355 in the US in Jan 2022.
# Do forecasted vaccination values resemble actual values following peak COVID-19 cases? ##
## Running same process, but restricting data to years before COVID-19 peak (Jan 2022).

# Remove dates >=2022
flu_2021<-clean_flu[1:108,] # Goes to Dec 2021

# ARIMA modeling
#Create time series variable
ts_flu21 <- ts(flu_2021$estimate, start = c(2013, 1), frequency = 12)
model_flu21 <- auto.arima(ts_flu21)
# Forecasting values for next 36 months
forecasted_flu21 <- forecast(model_flu21, h = 36)

# Create forecast dataframe
forecast_dates21 <- seq(from = max(flu_2021$date) + 1/12, by = 1/12, length.out = 36)
forecasted_flu21 <- data.frame(date = forecast_dates21, estimate = as.numeric(forecasted_flu21$mean))
  
# Plotted on top of actual values
# Dataset including 2022-2024
actual_flu <- clean_flu[109:138,]

ggplot() +
  geom_line(data = forecasted_flu21, aes(x = date, y = estimate, color = "Predicted"), size = 1) +
  geom_line(data = actual_flu, aes(x = date, y = estimate, color = "Actual"), size = 1) +
  labs(title = "Projected vs Actual Flu Vaccination Rates", x = "Date", y = "Number of Cases") +
  scale_color_manual(values = c("Predicted" = "blue", "Actual" = "red")) +
  theme_minimal()
