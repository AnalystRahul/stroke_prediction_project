# feature_engineering.R

# Install necessary packages if not already installed
if (!require(tidyverse)) install.packages("tidyverse")

# Load required libraries
library(tidyverse)

# Set the working directory (adjust the path as necessary)
setwd("C:/Users/rahul/OneDrive/Desktop/Projects/Google Data Analystics/R Project/Stroke Prediction/stroke_prediction_project")

# Load the preprocessed data
data <- read.csv("data/preprocessed_data.csv")

# Handle missing values
data <- data %>%
  filter(!is.na(bmi) & !is.na(age) & !is.na(avg_glucose_level) & !is.na(hypertension))

# Ensure numeric columns are treated as numeric
data$age <- as.numeric(data$age)
data$bmi <- as.numeric(data$bmi)
data$avg_glucose_level <- as.numeric(data$avg_glucose_level)
data$hypertension <- as.numeric(data$hypertension)

# Add interaction terms
data <- data %>%
  mutate(
    age_bmi_interaction = age * bmi,
    age_hypertension_interaction = age * hypertension,
    bmi_hypertension_interaction = bmi * hypertension
  )

# Save the engineered data
write.csv(data, "data/engineered_data.csv", row.names = FALSE)
