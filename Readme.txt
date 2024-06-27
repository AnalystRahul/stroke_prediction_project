# Stroke Prediction Project

## Problem Statement

Stroke is a serious medical condition that occurs when the blood supply to part of the brain is interrupted or reduced, preventing brain tissue from getting oxygen and nutrients. This project aims to build a predictive model to identify the likelihood of a stroke based on various health parameters.

### Goals:
- Preprocess the healthcare dataset for stroke prediction.
- Perform exploratory data analysis (EDA) to understand the data distribution and relationships.
- Train different machine learning models (Logistic Regression, Random Forest, Gradient Boosting) to predict the occurrence of a stroke.
- Evaluate and compare the models based on performance metrics like accuracy, AUC-ROC, and confusion matrix.
- Fine-tune the models to improve performance.
- Provide visualizations to interpret the results.

### Data Description:
- `id`: Unique identifier for each patient.
- `gender`: Gender of the patient.
- `age`: Age of the patient.
- `hypertension`: Whether the patient has hypertension.
- `heart_disease`: Whether the patient has heart disease.
- `ever_married`: Whether the patient has been married.
- `work_type`: Type of work the patient does.
- `Residence_type`: Type of residence the patient lives in.
- `avg_glucose_level`: Average glucose level in the blood.
- `bmi`: Body Mass Index of the patient.
- `smoking_status`: Smoking status of the patient.
- `stroke`: Whether the patient has had a stroke.

### Visualizations:
- Age Distribution
- BMI Distribution
- Stroke Count by Gender
- Stroke Count by BMI Category
- Correlation Heatmap

## How to Run the Project

1. **Clone the repository**:
   ```sh
   git clone https://github.com/AnalystRahul/stroke_prediction_project.git
   cd stroke_prediction_project
