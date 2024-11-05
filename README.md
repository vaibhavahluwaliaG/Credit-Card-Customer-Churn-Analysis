# Credit-Card-Customer-Churn-Analysis
This project provides a comprehensive SQL-based analysis of credit card customer churn, covering data cleaning and exploratory analysis to understand factors that might influence customer attrition. The objective is to analyze customer demographics and financial metrics to identify high-risk segments.

# Project Overview
Data Cleaning:
Initial dataset examination involved handling missing values, standardizing column names, and removing redundant columns.
Null values in categorical fields, such as Income_Category, were addressed using the mode, while other inconsistencies were resolved to ensure clean, reliable data.
Exploratory Data Analysis:
The cleaned data was then used to analyze demographic and financial metrics, such as customer age, gender, credit limits, and income categories.
SQL queries and aggregation functions were employed to assess distributions and trends across these variables.
This repository includes SQL scripts, detailed data cleaning steps, and a structured approach to performing churn analysis, making it a useful reference for churn analysis projects in finance and beyond.


# Project Conclusion: Customer Churn Analysis for Credit Card Customers
## Objective:
This project aimed to identify key factors influencing customer churn among credit card holders, with a specific focus on demographic, financial, and usage variables.

## Key Findings and Insights:

1. Customer Demographics:
• Age Group: The average customer age among churned individuals is 46, with the most significant churn occurring in the 41-50 age group.
• Gender Influence: Females display a consistently higher churn rate across all age groups, with 930 out of 1627 churned customers being female, compared to 697 males.

3. Financial Characteristics:
Credit Limit:
• Churn appears to be heavily skewed toward customers with lower credit limits.
• Range: Credit limits span from a minimum of 1,439 to a maximum of 34,516, with an average of approximately 8,000.
• Attrition by Credit Limit: Of the 1,627 churned customers, 1155 have credit limits below the 8k average.
• Gender breakdown: Among customers with credit limits under 8k, 820 are female, showing a higher propensity for churn in this demographic.

Income Category:
• The "Less than $40K" income category has the highest churn rate, totalling 799 churned customers.
• Breakdown by gender: 764 females compared to 35 males in this income category have churned.
• Following this, the "Average Income" category holds the next highest churn rate, with 271 attrited customers.
  
4. Churn Rate Overview:
5. • The overall churn rate is relatively low at 16% of the total customer base (1,627 out of 10,127 customers).

# Conclusion:
The analysis highlights several important drivers of churn:

• Low credit limits and low-income customers are at the highest risk of churn, with females particularly affected.
• Customers with credit limits under 8k, particularly in the Less than $40K income category, represent a critical group for retention strategies.
• Age and gender also play significant roles, with female customers in the 41-50 age group exhibiting a higher-than-average churn rate.

# Recommendations for Stakeholders:
To mitigate churn, prioritize retention efforts for female customers aged 41-50 with lower credit limits and income levels under $40K. Targeted campaigns to offer increased credit limits, loyalty programs, or tailored financial incentives may reduce attrition rates.
