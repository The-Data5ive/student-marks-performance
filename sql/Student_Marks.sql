
--Week 1
-- Switch to the database where your table is stored
USE studentmarks_db;


-- checking the dataset
SELECT
    COUNT(*) AS total_rows,
    SUM(gender IS NULL) AS missing_gender,
    SUM(`race/ethnicity` IS NULL) AS missing_race,
    SUM(`parental level of education` IS NULL) AS missing_parent_education,
    SUM(lunch IS NULL) AS missing_lunch,
    SUM(`test preparation course` IS NULL) AS missing_test_prep,
    SUM(`math score` IS NULL) AS missing_math,
    SUM(`reading score` IS NULL) AS missing_reading,
    SUM(`writing score` IS NULL) AS missing_writing
FROM studentsperformance;

-- Check the table structure
DESCRIBE studentsperformance;

-- Finding duplicate values
SELECT 
    `gender`,`race/ethnicity`,`parental level of education`,`lunch`,
    `test preparation course`,`math score`,`reading score`,
    `writing score`,
    COUNT(*) AS duplicate_count
FROM studentsperformance
GROUP BY 
    `gender`,
    `race/ethnicity`,
    `parental level of education`,
    `lunch`,
    `test preparation course`,
    `math score`,
    `reading score`,
    `writing score`
HAVING COUNT(*) > 1;
