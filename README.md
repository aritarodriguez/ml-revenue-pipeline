# ml-revenue-pipeline

**Project Workflow**

Load libraries & dataset
Using readxl, dplyr, ggplot2, caret, corrplot, rpart, and randomForest.

**Exploratory Data Analysis (EDA)**

Summary statistics

Boxplot of sales by category

Correlation heatmap for numerical features

**Data Preparation**

Convert categorical variables (category, product_id) to factors

Train/test split (80/20) using caret::createDataPartition

**Models Built**

Multiple Linear Regression

Decision Tree (rpart)

Random Forest (100 trees)

Evaluation
Each model is evaluated using postResample (RMSE, R²).
Feature importance is visualized for the Random Forest.
