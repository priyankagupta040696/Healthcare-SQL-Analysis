# Key Findings

## Data quality
- Raw dataset: **55,500 rows**.
- Exact full-row duplicates: **534**.
- Deduplicated analysis table: **54,966 rows**.
- **106 negative-billing records** remained after deduplication. They were retained for non-financial analysis but excluded from billing KPIs because their business meaning could not be established from the dataset.
- Financial-analysis population: **54,860 positive-billing records**.

## Patient profile
- Average age: **51.54 years**.
- The **60+** group is the largest age segment with **20,172 records** (about 36.7%).
- Patients aged **46+ account for about 59%** of the cleaned records.
- Gender distribution is almost even: **27,496 male** and **27,470 female** records.

## Conditions and utilization
- The six medical conditions are unusually balanced, each representing roughly **16.6%–16.8%** of records. No condition dominates the dataset.
- Admission types are also balanced: **18,473 Elective**, **18,391 Urgent**, and **18,102 Emergency**.
- Overall average length of stay is **15.50 days**.
- Condition-level average LOS ranges only from **15.43 days (Diabetes)** to **15.68 days (Asthma)**, indicating little variation by condition.
- Hospital names are highly fragmented; the highest-volume hospital has only **44 records**, limiting meaningful hospital-level comparison.

## Financial analysis
- Highest average positive billing: **Obesity — $25,859.22**.
- Lowest average positive billing: **Cancer — $25,205.92**. The gap is modest, so condition-level average billing is relatively similar.
- Highest total positive billing by condition: **Diabetes — $236.49M**, closely followed by **Obesity — $236.02M**.
- Highest total billing by insurer: **Cigna — $284.35M**.
- Highest average billing by insurer: **Medicare — $25,678.09**.
- **27,429** positive-billing records are above the average positive billing amount.

## Time analysis
- Complete-year admission volumes are stable: **11,172 (2020), 10,816 (2021), 10,915 (2022), 10,936 (2023)**.
- 2019 and 2024 are partial years and should not be directly compared with complete years.
- Monthly admissions are relatively even, ranging from **4,210 in February** to **4,785 in August**, with no strong seasonal concentration.

## Ranked billing within admission type
- Elective: **Hypertension** ranks #1 by total positive billing.
- Emergency: **Obesity** ranks #1.
- Urgent: **Diabetes** ranks #1.
- Condition shares within each admission type remain close to 16–17%, so rankings should not be interpreted as dramatic differences in prevalence.

## Recommendations
1. Use age segmentation in operational reporting because patients aged 46+ represent the majority of records.
2. Monitor length of stay as a recurring KPI and investigate hospital or patient segments that materially exceed the ~15.5-day baseline.
3. Validate negative billing transactions before financial reporting; distinguish legitimate credits/refunds from data errors when transaction metadata is available.
4. Compare total billing together with patient volume and average billing rather than using total billing alone to assess insurers or conditions.
5. Monitor future annual and monthly volumes against the stable complete-year baseline to identify meaningful changes.
