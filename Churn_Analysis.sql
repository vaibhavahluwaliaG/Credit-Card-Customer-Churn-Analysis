USE bankchurn;
 -- Credit Card Customer Churn Analysis
 
SELECT * FROM bankchurner_staging;
DESCRIBE bankchurner_staging;

SELECT COUNT(*) AS total_rows,
	AVG(Credit_Limit) AS avg_credit_limit, 
    MIN(Credit_Limit) AS min_credit_limit, 
    MAX(Credit_Limit) AS max_credit_limit,
    AVG(Total_Trans_Amt) AS avg_trans_amt,
    MIN(Total_Trans_Amt) AS min_trans_amt,
    MAX(Total_Trans_Amt) AS max_trans_amt,
    AVG(Customer_Age) AS avg_customer_age,
    MIN(Customer_Age) AS min_customer_age,
    MAX(Customer_Age) AS max_customer_age
FROM bankchurner_staging;
-- Basic statistics of the dataset, such as mean, median, and distribution of numerical columns (Credit_Limit, Total_Trans_Amt,
-- Customer_Age)provide a more complete understanding of the data, helping to identify any outliers or irregularities.
-- Gives us good understanding of the customer age group which is at the avg age of 46.
-- Range of credit limit is from min-1439 and max-34516, yet the avg credit limit is on the lower end of 8k.

SELECT 
    Attrition_Flag,
    COUNT(*) AS total_customers,
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bankchurner_staging)) AS churn_percentage
FROM bankchurner_staging
GROUP BY Attrition_Flag;
-- Churn percentage of attrited customers is at only 16% so far with 1627 customers out of 10127.

SELECT * FROM bankchurner_staging WHERE Credit_Limit IS NULL;

SELECT COUNT(Credit_Limit) FROM bankchurner_staging
	WHERE Attrition_Flag = 'Attrited Customer'
AND
    Credit_Limit < (
SELECT AVG(Credit_Limit) AS avg_credit_limit
	FROM bankchurner_staging
);
-- INSIGHT: Attrition is highly skewed towards customers whose credit limit is less than 8k
-- Out of total number of 1627 attrited customers, 1155 had a limit less than 8k.
-- Lower credit limit appears to have highly influenced the Attrition rate.

SELECT * FROM bankchurner_staging WHERE Customer_Age IS NULL;

-- General Gender Analysis
SELECT Gender, COUNT(*) AS churn_count
FROM bankchurner_staging 
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Gender;
-- F = 930 and M = 697

SELECT Gender, 
       CASE 
           WHEN Customer_Age BETWEEN 20 AND 30 THEN '20-30'
           WHEN Customer_Age BETWEEN 31 AND 40 THEN '31-40'
           WHEN Customer_Age BETWEEN 41 AND 50 THEN '41-50'
           WHEN Customer_Age BETWEEN 51 AND 60 THEN '51-60'
           ELSE '60+'
       END AS Age_Group, 
       COUNT(*) AS churn_count
FROM bankchurner_staging 
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Gender, Age_Group;
-- Churn count for both M and F appears to be the highest in the age group of 41-50
-- In all the age groups F have the highest churn rate compared to M.

-- Handling missing values in Income_Category with mode value
SELECT Income_Category 
FROM bankchurner_staging 
WHERE Income_Category != 'Unknown'
GROUP BY Income_Category 
ORDER BY COUNT(*) DESC 
LIMIT 1;

-- Declare a variable to hold the mode value
SET @mode_value  = (SELECT Income_Category 
                   FROM bankchurner_staging 
                   WHERE Income_Category != 'Unknown'
                   GROUP BY Income_Category 
                   ORDER BY COUNT(*) DESC 
                   LIMIT 1);

-- Update the 'Unknown' values in Income_Category column with the mode value
UPDATE bankchurner_staging
SET Income_Category = @mode_value
WHERE Income_Category = 'Unknown';

SELECT DISTINCT Income_Category from bankchurner_staging;

SELECT COUNT(*) AS Churned_Cust,
	CASE
		WHEN Income_Category = 'Less than $40K' THEN 'Low Income Group'
        WHEN Income_Category = '$40K - $60K' THEN 'Avg Income Group'
        WHEN Income_Category = '$60K - $80K' THEN 'Above Avg Income Group'
        WHEN Income_Category = '$80K - $120K' THEN 'High Income Group'
        ELSE 'Very High Income Group'
	END AS 'Income Group'
FROM bankchurner_staging
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Income_Category;
-- Low income group has the highest churn rate with 799, followed by Avg Income group at 271 Attrited Customer

SELECT Gender, COUNT(*) AS churn_count
FROM bankchurner_staging
	WHERE Income_Category = 'Less than $40K'
AND
	Attrition_Flag = 'Attrited Customer'
GROUP BY Gender;
-- In the low income category we have found that 764 are F and 35 are M.

SELECT Gender, COUNT(Credit_Limit) FROM bankchurner_staging
	WHERE Attrition_Flag = 'Attrited Customer'
AND
    Credit_Limit < (
SELECT AVG(Credit_Limit) AS avg_credit_limit
	FROM bankchurner_staging
)
GROUP BY Gender;
-- INSIGHT:
-- Out of 1155 people with limit less than 8k, 820 are F.
-- It is observed that Females are being paid less and are being approved for lower limit.
-- Above factors have the most influense in higher churn rate.





