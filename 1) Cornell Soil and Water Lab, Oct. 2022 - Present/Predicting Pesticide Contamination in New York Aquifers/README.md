# Predicting Pesticide Conamination in New York Aquifers 🌱💦🗽

*Please note that the code/output is currently confidential and cannot be shared.*

SUMMARY
- over the past 3 years, the Cornell Soil & Water Lab has collaborated with the NYSDEC to test groundwater        samples around the state for pesticide contamination

- we are now using this data to build machine learning models that predict pesticide leaching events...since the code/output cannot be currently shared, here's a list of key components being implemented:
  - Gradient Boosting Classification (binary) from scikit-learn
  - tree tuning (depth and min samples)
  - cross-validation with custom model scorer (f-beta) and modified probability threshold for decision
  - ordinal feature engineering for categorical data
  - impurity-based feature importances and permutation feature importances
  - adjustments for imbalanced class labels

- more info on the overall project can be found here: https://soilandwaterlab.cornell.edu/wp-content/uploads/static/dec-web/
