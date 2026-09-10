-- 02_data_cleaning.sql
-- Preserve the raw table and create a separate analysis-ready table.

-- Confirm exact full-row duplicates.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ROW(
        patient_name, age, gender, blood_type, medical_condition,
        date_of_admission, doctor, hospital, insurance_provider,
        billing_amount, room_number, admission_type, discharge_date,
        medication, test_results
    )) AS unique_rows
FROM healthcare;
-- Result: 55,500 total rows; 54,966 unique rows; 534 duplicate copies.

-- Create cleaned table without exact duplicates.
CREATE TABLE healthcare_clean AS
SELECT DISTINCT *
FROM healthcare;

-- Validate row counts.
SELECT COUNT(*) AS raw_rows FROM healthcare;
SELECT COUNT(*) AS cleaned_rows FROM healthcare_clean;
-- Results: 55,500 raw; 54,966 clean.

-- Verify exact duplicates are removed.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ROW(
        patient_name, age, gender, blood_type, medical_condition,
        date_of_admission, doctor, hospital, insurance_provider,
        billing_amount, room_number, admission_type, discharge_date,
        medication, test_results
    )) AS unique_rows
FROM healthcare_clean;
-- Both values should be 54,966.

-- Post-cleaning quality profile.
SELECT
    COUNT(*) AS total_records,
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    ROUND(MIN(billing_amount), 2) AS min_billing,
    ROUND(MAX(billing_amount), 2) AS max_billing,
    ROUND(AVG(billing_amount), 2) AS avg_billing,
    COUNT(*) FILTER (WHERE billing_amount <= 0) AS non_positive_bills,
    COUNT(*) FILTER (WHERE discharge_date < date_of_admission) AS invalid_date_records
FROM healthcare_clean;

-- Investigate non-positive billing by condition.
SELECT
    medical_condition,
    COUNT(*) AS records,
    ROUND(MIN(billing_amount), 2) AS minimum_bill,
    ROUND(MAX(billing_amount), 2) AS maximum_bill
FROM healthcare_clean
WHERE billing_amount <= 0
GROUP BY medical_condition
ORDER BY records DESC;

-- Financial-analysis population.
SELECT
    COUNT(*) AS total_clean_records,
    COUNT(*) FILTER (WHERE billing_amount > 0) AS valid_billing_records,
    COUNT(*) FILTER (WHERE billing_amount <= 0) AS excluded_billing_records
FROM healthcare_clean;
-- Result: 54,966 total; 54,860 positive-billing; 106 excluded from billing KPIs.

-- Cleaning rule:
-- Keep all 54,966 deduplicated records for non-financial analysis.
-- Exclude billing_amount <= 0 only from financial KPIs because the source
-- does not establish whether negative amounts are adjustments/refunds or errors.
