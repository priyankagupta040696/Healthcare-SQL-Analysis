# Dataset Source

Dataset: **Healthcare Dataset** by prasad22 on Kaggle.

Source page: https://www.kaggle.com/datasets/prasad22/healthcare-dataset

The working CSV contained 55,500 rows and 15 fields covering patient demographics, medical condition, admission/discharge information, hospital/doctor, insurance provider, billing, medication and test results.

The raw CSV is not included in this repository. Download it from the source page and import it into PostgreSQL using the schema in `sql/01_database_setup.sql`.

## Analysis note
Several categorical variables are unusually evenly distributed. Findings should therefore be treated as a portfolio analysis of this dataset rather than generalized to real healthcare populations without further validation.
