
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

-- Week 2

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

-- Create Derived Columns
-- Average Score
ALTER TABLE studentsperformance
ADD average_score DECIMAL(5,2);

UPDATE studentsperformance
SET average_score = (`math score` + `reading score` + `writing score`) / 3;


-- Pass/Fail (Pass = 50+)
UPDATE studentsperformance
SET pass_status = 
    CASE 
        WHEN average_score >= 50 THEN 'pass'
        ELSE 'fail'
    END;
    
    
select * from studentsperformance limit 10;

-- Week 3

-- Average, max, and min scores per gender
SELECT gender,
       AVG(`math score`) AS avg_math,
       AVG(`reading score`) AS avg_reading,
       AVG(`writing score`) AS avg_writing,
       MAX(`math score`) AS max_math,
       MIN(`math score`) AS min_math,
       COUNT(*) AS total_students
FROM studentsperformance
GROUP BY gender;

-- Performance per Test Preparation Course:
SELECT `test preparation course`,
       AVG(average_score) AS avg_score,
       SUM(CASE WHEN pass_status='pass' THEN 1 ELSE 0 END) AS total_pass,
       SUM(CASE WHEN pass_status='fail' THEN 1 ELSE 0 END) AS total_fail
FROM studentsperformance
GROUP BY `test preparation course`;

-- Performance by Parental Education
SELECT `parental level of education`,
       AVG(average_score) AS avg_score,
       COUNT(*) AS total_students
FROM studentsperformance
GROUP BY `parental level of education`
ORDER BY avg_score DESC;

SELECT 
    gender,
    AVG(`math score`) AS avg_math,
    AVG(`reading score`) AS avg_reading,
    AVG(`writing score`) AS avg_writing,
    AVG(average_score) AS avg_overall
FROM studentsperformance
GROUP BY gender;


SELECT *
FROM studentsperformance;



