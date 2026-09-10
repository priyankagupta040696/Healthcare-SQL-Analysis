-- 03_exploratory_analysis.sql

-- 1. Total cleaned records
SELECT COUNT(*) AS total_records FROM healthcare_clean;

-- 2. Gender distribution
SELECT gender, COUNT(*) AS total_patients
FROM healthcare_clean
GROUP BY gender
ORDER BY total_patients DESC;

-- 3. Average patient age
SELECT ROUND(AVG(age), 2) AS average_age
FROM healthcare_clean;

-- 4. Age-group distribution
SELECT
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_patients
FROM healthcare_clean
GROUP BY age_group
ORDER BY total_patients DESC;

-- 5. Medical-condition distribution
SELECT
    medical_condition,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM healthcare_clean
GROUP BY medical_condition
ORDER BY total_patients DESC;

-- 6. Average age by condition
SELECT medical_condition, ROUND(AVG(age), 2) AS average_age
FROM healthcare_clean
GROUP BY medical_condition
ORDER BY average_age DESC;

-- 7. Condition by gender
SELECT medical_condition, gender, COUNT(*) AS total_patients
FROM healthcare_clean
GROUP BY medical_condition, gender
ORDER BY medical_condition, total_patients DESC;

-- 8. Top 10 hospitals by records
SELECT hospital, COUNT(*) AS total_records
FROM healthcare_clean
GROUP BY hospital
ORDER BY total_records DESC
LIMIT 10;

-- 9. Admission-type distribution
SELECT admission_type, COUNT(*) AS total_admissions
FROM healthcare_clean
GROUP BY admission_type
ORDER BY total_admissions DESC;

-- 10a. Overall average length of stay
SELECT ROUND(AVG(discharge_date - date_of_admission), 2) AS average_length_of_stay
FROM healthcare_clean;

-- 10b. Average length of stay by condition
SELECT
    medical_condition,
    ROUND(AVG(discharge_date - date_of_admission), 2) AS average_length_of_stay
FROM healthcare_clean
GROUP BY medical_condition
ORDER BY average_length_of_stay DESC;
