-- 05_advanced_analysis.sql

-- 16. Top 3 conditions by total billing within each admission type
WITH condition_billing AS (
    SELECT
        admission_type,
        medical_condition,
        ROUND(SUM(billing_amount), 2) AS total_billing
    FROM healthcare_clean
    WHERE billing_amount > 0
    GROUP BY admission_type, medical_condition
),
ranked_conditions AS (
    SELECT
        admission_type,
        medical_condition,
        total_billing,
        RANK() OVER (
            PARTITION BY admission_type
            ORDER BY total_billing DESC
        ) AS billing_rank
    FROM condition_billing
)
SELECT admission_type, medical_condition, total_billing, billing_rank
FROM ranked_conditions
WHERE billing_rank <= 3
ORDER BY admission_type, billing_rank;

-- 17. Count positive-billing records above the positive-billing average
SELECT COUNT(*) AS above_average_bills
FROM healthcare_clean
WHERE billing_amount > (
    SELECT AVG(billing_amount)
    FROM healthcare_clean
    WHERE billing_amount > 0
)
AND billing_amount > 0;
-- Result: 27,429

-- 18. Condition share within each admission type
SELECT
    admission_type,
    medical_condition,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY admission_type),
        2
    ) AS percentage_within_admission_type
FROM healthcare_clean
GROUP BY admission_type, medical_condition
ORDER BY admission_type, percentage_within_admission_type DESC;
