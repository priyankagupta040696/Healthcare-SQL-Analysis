# Healthcare Data Analysis Using SQL

## Project Overview
This project analyzes **55,500 healthcare records** in PostgreSQL to examine patient demographics, medical conditions, hospital utilization, admission patterns, length of stay, billing activity and insurance-provider performance.

The project follows an analyst workflow from raw-data profiling and cleaning through exploratory, financial, temporal and intermediate SQL analysis. The final analysis uses a deduplicated table rather than the untouched source data.

## Business Problem
A healthcare organization needs visibility into patient utilization, admission patterns, length of stay and financial activity to support operational and resource-planning decisions. This case study investigates those areas and translates SQL results into practical observations and recommendations.

## Dataset
- Raw records: **55,500**
- Columns: **15**
- Admission-date coverage: **8 May 2019 to 7 May 2024**
- Key fields: age, gender, medical condition, admission/discharge dates, hospital, insurance provider, billing amount, admission type, medication and test results
- Source: Kaggle Healthcare Dataset by prasad22 (see `dataset/dataset_source.md`)

## Tools & SQL Skills
**PostgreSQL / pgAdmin**

SQL techniques demonstrated include `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `MIN/MAX`, `CASE`, date functions, subqueries, CTEs, window functions, `RANK()` and `PARTITION BY`.

## Data Preparation & Quality
The raw table was preserved and a separate `healthcare_clean` table was created for analysis.

| Quality check | Result |
|---|---:|
| Raw rows | 55,500 |
| Unique full rows | 54,966 |
| Exact duplicate copies removed | 534 |
| Clean rows | 54,966 |
| Negative-billing records after deduplication | 106 |
| Positive-billing records used for financial KPIs | 54,860 |

The **534 exact duplicates** were removed from the analysis copy using `SELECT DISTINCT`, while the raw table remained unchanged.

The **106 negative-billing records** were not deleted from the clean dataset because the source does not establish whether they represent refunds, credits, adjustments or errors. They were retained for demographic/utilization analysis and excluded only from billing-based KPIs.

## Key Findings

### Patient demographics
- Average patient age is **51.54 years**.
- The **60+** group is the largest segment with **20,172 records** (about 36.7%).
- Approximately **59% of records involve patients aged 46 or older**.
- Gender is nearly evenly split: **27,496 male** and **27,470 female** records.

### Conditions & hospital utilization
- Arthritis, Diabetes, Hypertension, Obesity, Cancer and Asthma each account for roughly **16.6%–16.8%** of records; no condition meaningfully dominates the dataset.
- Admission types are similarly balanced: **18,473 Elective**, **18,391 Urgent**, and **18,102 Emergency**.
- Average length of stay is **15.50 days**.
- Condition-level LOS varies only from **15.43 days for Diabetes** to **15.68 days for Asthma**, indicating limited variation by condition.
- Hospital names are highly fragmented; the largest hospital grouping contains only **44 records**, so hospital-level rankings are not emphasized as a major business conclusion.

### Financial analysis
Financial KPIs use only the **54,860 records with billing_amount > 0**.

- **Obesity** has the highest average billing at **$25,859.22**; **Cancer** has the lowest at **$25,205.92**. The difference is modest.
- **Diabetes** has the highest total billing at approximately **$236.49M**, closely followed by **Obesity at $236.02M**.
- **Cigna** has the highest insurer total at approximately **$284.35M**.
- **Medicare** has the highest insurer average billing at **$25,678.09**.
- **27,429** positive-billing records exceed the average positive billing amount.

### Time analysis
Complete-year admissions are relatively stable:

| Year | Admissions |
|---|---:|
| 2020 | 11,172 |
| 2021 | 10,816 |
| 2022 | 10,915 |
| 2023 | 10,936 |

2019 and 2024 contain partial-year data and are therefore not treated as comparable full-year trends.

Monthly admissions range from **4,210 in February** to **4,785 in August**, suggesting no strong seasonal concentration in this dataset.

### Intermediate SQL insight
Using a CTE with `RANK()` and `PARTITION BY`, the highest-billing condition differs by admission type:
- **Elective:** Hypertension — $81.32M
- **Emergency:** Obesity — $80.05M
- **Urgent:** Diabetes — $81.48M

Condition shares within each admission type remain close to 16–17%, so these rankings are interpreted cautiously rather than as large differences in prevalence.

## Business Recommendations
1. Incorporate **age segmentation** into utilization reporting because patients aged 46+ represent the majority of records.
2. Track **length of stay** as an operational KPI and investigate individual hospitals or patient segments that materially exceed the ~15.5-day baseline.
3. Establish a billing-quality rule that distinguishes legitimate **refunds/credits/adjustments** from data errors before financial reporting.
4. Evaluate insurers and medical conditions using **volume, average billing and total billing together** rather than total billing alone.
5. Use the stable 2020–2023 annual volumes as a historical monitoring baseline and investigate future material deviations.

## Limitations
- Several categorical variables are unusually evenly distributed, limiting the strength of comparative conclusions.
- The dataset does not provide transaction metadata explaining negative billing amounts.
- 2019 and 2024 are partial years.
- Hospital names are highly fragmented, which limits meaningful hospital-level benchmarking.
- Findings describe this dataset only and should not be generalized to real healthcare populations without additional validation.

## Repository Structure
```text
Healthcare-SQL-Analysis/
├── README.md
├── dataset/
│   └── dataset_source.md
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_exploratory_analysis.sql
│   ├── 04_business_analysis.sql
│   └── 05_advanced_analysis.sql
├── results/
│   └── key_findings.md
└── images/
    └── sql_results/
```

## How to Reproduce
1. Download the dataset from the source documented in `dataset/dataset_source.md`.
2. Create the `healthcare` table using `sql/01_database_setup.sql` and import the CSV through pgAdmin.
3. Run `02_data_cleaning.sql` to create and validate `healthcare_clean`.
4. Run the remaining SQL files in numerical order.
5. Financial queries intentionally exclude `billing_amount <= 0`; non-financial queries use all deduplicated records.

## Portfolio Outcome
This project demonstrates a complete SQL analysis workflow: **raw-data validation → duplicate investigation → cleaning → quality-rule definition → exploratory analysis → business analysis → CTE/window-function analysis → interpretation and recommendations**.
