# gradient_boosting.R

# Install necessary packages if not already installed
if (!require(xgboost)) install.packages("xgboost")

# Load required libraries
library(tidyverse)
library(caret)
library(xgboost)

# Set the working directory (adjust the path as necessary)
setwd("C:/Users/rahul/OneDrive/Desktop/Projects/Google Data Analystics/R Project/Stroke Prediction/stroke_prediction_project")

# Load the engineered data
data <- read.csv("data/engineered_data.csv")

# Handle missing values
data <- data %>%
  filter(!is.na(bmi) & !is.na(age) & !is.na(avg_glucose_level))

# Split the data into training and testing sets
set.seed(123)
train_indices <- createDataPartition(data$stroke, p = 0.8, list = FALSE)
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Convert data to matrix format for xgboost
train_matrix <- xgb.DMatrix(data = as.matrix(train_data[, -c(1, 12)]), label = train_data$stroke)
test_matrix <- xgb.DMatrix(data = as.matrix(test_data[, -c(1, 12)]), label = test_data$stroke)

# Train the xgboost model
params <- list(
  objective = "binary:logistic",
  eval_metric = "auc",
  max_depth = 6,
  eta = 0.1,
  nthread = 2,
  nrounds = 100
)

xgb_model <- xgb.train(params, train_matrix, params$nrounds)

# Make predictions
predictions <- predict(xgb_model, test_matrix)
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Evaluate the model
confusionMatrix(factor(predicted_classes), test_data$stroke)
roc_curve <- roc(test_data$stroke, predictions)
auc(roc_curve)

# Save the model
xgb.save(xgb_model, "models/xgb_model.model")
