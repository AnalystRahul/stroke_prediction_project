# model_training.R

# Install necessary packages if not already installed
if (!require(caret)) install.packages("caret")
if (!require(randomForest)) install.packages("randomForest")
if (!require(pROC)) install.packages("pROC")

# Load required libraries
library(tidyverse)
library(caret)
library(randomForest)
library(pROC)

# Set the working directory (adjust the path as necessary)
setwd("C:/Users/rahul/OneDrive/Desktop/Projects/Google Data Analystics/R Project/Stroke Prediction/stroke_prediction_project")

# Load the preprocessed data
data <- read.csv("data/preprocessed_data.csv")

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

# Train a logistic regression model
model_logistic <- glm(stroke ~ ., data = train_data, family = binomial)

# Summary of the model
summary(model_logistic)

# Make predictions and evaluate the logistic regression model
predictions <- predict(model_logistic, newdata = test_data, type = "response")
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Convert predicted classes to factors with the same levels as the actual data
predicted_classes <- factor(predicted_classes, levels = levels(test_data$stroke))

# Evaluate the model
confusionMatrix(predicted_classes, test_data$stroke)

# Calculate AUC-ROC for logistic regression
roc_curve <- roc(test_data$stroke, predictions)
auc(roc_curve)

# Plot ROC curve for logistic regression
plot(roc_curve, col = "blue")
ggsave("visualizations/logistic_roc_curve.png", plot = last_plot())

# Train a Random Forest model
set.seed(123)
model_rf <- randomForest(stroke ~ ., data = train_data, ntree = 100, mtry = 3, importance = TRUE)

# Summary of the model
print(model_rf)

# Make predictions and evaluate the Random Forest model
predictions_rf <- predict(model_rf, newdata = test_data)
predicted_classes_rf <- factor(predictions_rf > 0.5, levels = c(FALSE, TRUE), labels = levels(test_data$stroke))

# Evaluate the Random Forest model
confusionMatrix(predicted_classes_rf, test_data$stroke)

# Calculate AUC-ROC for Random Forest
roc_curve_rf <- roc(test_data$stroke, as.numeric(predictions_rf))
auc(roc_curve_rf)

# Plot ROC curve for Random Forest
plot(roc_curve_rf, col = "green")
ggsave("visualizations/random_forest_roc_curve.png", plot = last_plot())

# Save models
saveRDS(model_logistic, "models/model_logistic.rds")
saveRDS(model_rf, "models/model_rf.rds")
