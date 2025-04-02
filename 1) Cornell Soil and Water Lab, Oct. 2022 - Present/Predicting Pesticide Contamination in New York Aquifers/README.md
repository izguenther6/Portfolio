# Predicting Pesticide Contamination in New York Aquifers with Machine Learning 🌱💦🗽

*Please note that the code/output is currently confidential.  
We will be publishing a reports/papers soon.*

SUMMARY
- over the past 3 years, the Cornell Soil & Water Lab has collaborated with the NYSDEC to test groundwater samples around the state for pesticide contamination

- we are now using this data to build machine learning models that predict pesticide leaching events...since the code/output is currently confidential, here's a list of key components being implemented:
  - XGBoost binary classification
  - hyperparameter tuning (max depth, L1/L2 regularizers)
  - KFold cross-validation with custom model scorer (f-beta) and modified probability threshold for decision
  - ordinal feature engineering for categorical data
  - impurity-based feature importances and permutation feature importances
  - adjustments for imbalanced class labels

- more info on the overall project can be found here: https://soilandwaterlab.cornell.edu/wp-content/uploads/static/dec-web/
