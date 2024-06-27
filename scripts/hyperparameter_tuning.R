# hyperparameter_tuning.R

# Install necessary packages if not already installed
if (!require(caret)) install.packages("caret")
if (!require(randomForest)) install.packages("randomForest")

# Load required libraries
library(tidyverse)
library(caret)
library(randomForest)

# Set the working directory (adjust the path as necessary)
setwd("C:/Users/rahul/OneDrive/Desktop/Projects/Google Data Analystics/R Project/Stroke Prediction/stroke_prediction_project")

# Load the preprocessed data
data <- read.csv("data/preprocessed_data.csv")

# Handle missing values
data <- data %>%
  filter(!is.na(bmi) & !is.na(age) & !is.na(avg_glucose_level))

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

# Split the data into training and testing sets
set.seed(123)
train_indices <- createDataPartition(data$stroke, p = 0.8, list = FALSE)
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Ensure consistent factor levels in test data
for (col in names(train_data)) {
  if (is.factor(train_data[[col]])) {
    test_data[[col]] <- factor(test_data[[col]], levels = levels(train_data[[col]]))
  }
}

# Define the parameter grid for tuning
tune_grid <- expand.grid(
  mtry = c(2, 3, 4, 5)
)

# Train the model using cross-validation
set.seed(123)
control <- trainControl(method = "cv", number = 5, search = "grid")
model_rf_tuned <- train(
  stroke ~ ., data = train_data,
  method = "rf",
  trControl = control,
  tuneGrid = tune_grid
)

# Print the best model
print(model_rf_tuned$bestTune)

# Make predictions and evaluate the tuned model
predictions_rf_tuned <- predict(model_rf_tuned, newdata = test_data)
confusionMatrix(predictions_rf_tuned, test_data$stroke)

# Save the tuned model
saveRDS(model_rf_tuned, "models/model_rf_tuned.rds")
