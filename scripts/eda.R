# eda.R

# Install necessary packages if not already installed
if (!require(ggplot2)) install.packages("ggplot2")

# Load required libraries
library(tidyverse)
library(skimr)
library(ggplot2)

# Set the working directory (adjust the path as necessary)
setwd("C:/Users/rahul/OneDrive/Desktop/Projects/Google Data Analystics/R Project/Stroke Prediction/stroke_prediction_project")

# Load the preprocessed data
data <- read.csv("data/preprocessed_data.csv")

# Summary statistics
summary(data)
skim(data)

# Visualize the distribution of age
age_dist_plot <- ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  theme_minimal() +
  labs(title = "Age Distribution", x = "Age", y = "Frequency")
ggsave("visualizations/age_distribution.png", plot = age_dist_plot)

# Visualize the distribution of BMI
bmi_dist_plot <- ggplot(data, aes(x = bmi)) +
  geom_histogram(binwidth = 1, fill = "green", color = "black") +
  theme_minimal() +
  labs(title = "BMI Distribution", x = "BMI", y = "Frequency")
ggsave("visualizations/bmi_distribution.png", plot = bmi_dist_plot)

# Visualize stroke count by gender
stroke_gender_plot <- ggplot(data, aes(x = gender, fill = stroke)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Stroke Count by Gender", x = "Gender", y = "Count") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"))
ggsave("visualizations/stroke_by_gender.png", plot = stroke_gender_plot)

# Visualize stroke count by BMI category
stroke_bmi_plot <- ggplot(data, aes(x = bmi, fill = stroke)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Stroke Count by BMI", x = "BMI", y = "Count") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red"))
ggsave("visualizations/stroke_by_bmi.png", plot = stroke_bmi_plot)

# Correlation heatmap
corr_matrix <- data %>%
  select(age, avg_glucose_level, bmi) %>%
  cor()

# Convert the correlation matrix to a format suitable for ggplot
corr_df <- as.data.frame(as.table(corr_matrix))

# Plot the correlation heatmap
corr_heatmap_plot <- ggplot(corr_df, aes(Var1, Var2, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = round(Freq, 2))) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  theme_minimal() +
  labs(title = "Correlation Heatmap")
ggsave("visualizations/correlation_heatmap.png", plot = corr_heatmap_plot)
