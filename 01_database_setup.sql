-- Healthcare Data Analysis | PostgreSQL
-- 01_database_setup.sql
-- Database used: healthcare_analysis

CREATE TABLE healthcare (
    patient_name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    blood_type VARCHAR,
    medical_condition VARCHAR,
    date_of_admission DATE,
    doctor VARCHAR,
    hospital VARCHAR,
    insurance_provider VARCHAR,
    billing_amount NUMERIC,
    room_number INTEGER,
    admission_type VARCHAR,
    discharge_date DATE,
    medication VARCHAR,
    test_results VARCHAR
);

-- Import healthcare_dataset.csv into this table using pgAdmin Import/Export.

SELECT COUNT(*) AS raw_record_count
FROM healthcare;
-- Result: 55,500
