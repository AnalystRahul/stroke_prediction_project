# data_preprocessing.R

# Install necessary packages if not already installed
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(skimr)) install.packages("skimr")
if (!require(mice)) install.packages("mice")
if (!require(caTools)) install.packages("caTools")

# Load required libraries
library(tidyverse)
library(skimr)
library(mice)
library(caTools)

# Set the working directory (adjust the path as necessary)
setwd("C:/Users/rahul/OneDrive/Desktop/Projects/Google Data Analystics/R Project/Stroke Prediction/stroke_prediction_project")

# Load the dataset
data <- read.csv("data/healthcare-dataset-stroke-data.csv")

# Check for missing values
skim(data)

# Handle missing values using multiple imputation
imputed_data <- mice(data, m = 5, method = 'pmm', maxit = 50, seed = 500)
data <- complete(imputed_data, 1)

# Ensure numeric columns are treated as numeric
data$age <- as.numeric(data$age)
data$bmi <- as.numeric(data$bmi)
data$avg_glucose_level <- as.numeric(data$avg_glucose_level)

# Ensure factor columns are treated as factors
data$stroke <- as.factor(data$stroke)
data$gender <- as.factor(data$gender)
data$ever_married <- as.factor(data$ever_married)
data$work_type <- as.factor(data$work_type)
data$Residence_type <- as.factor(data$Residence_type)
data$smoking_status <- as.factor(data$smoking_status)

# Save the preprocessed data
write.csv(data, "data/preprocessed_data.csv", row.names = FALSE)
