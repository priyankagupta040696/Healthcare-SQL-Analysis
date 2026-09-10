-- 04_business_analysis.sql
-- Financial KPIs use positive billing amounts only.

-- 11. Average billing by medical condition
SELECT medical_condition, ROUND(AVG(billing_amount), 2) AS average_bill
FROM healthcare_clean
WHERE billing_amount > 0
GROUP BY medical_condition
ORDER BY average_bill DESC;

-- 12. Total billing by medical condition
SELECT medical_condition, ROUND(SUM(billing_amount), 2) AS total_billing
FROM healthcare_clean
WHERE billing_amount > 0
GROUP BY medical_condition
ORDER BY total_billing DESC;

-- 13. Insurance-provider billing analysis
SELECT
    insurance_provider,
    COUNT(*) AS total_records,
    ROUND(AVG(billing_amount), 2) AS average_bill,
    ROUND(SUM(billing_amount), 2) AS total_billing
FROM healthcare_clean
WHERE billing_amount > 0
GROUP BY insurance_provider
ORDER BY total_billing DESC;

-- 14. Admissions by year
SELECT
    EXTRACT(YEAR FROM date_of_admission) AS admission_year,
    COUNT(*) AS total_admissions
FROM healthcare_clean
GROUP BY admission_year
ORDER BY admission_year;

-- 15. Admissions by month
SELECT
    EXTRACT(MONTH FROM date_of_admission) AS month_number,
    TO_CHAR(date_of_admission, 'FMMonth') AS month_name,
    COUNT(*) AS total_admissions
FROM healthcare_clean
GROUP BY EXTRACT(MONTH FROM date_of_admission), TO_CHAR(date_of_admission, 'FMMonth')
ORDER BY month_number;
