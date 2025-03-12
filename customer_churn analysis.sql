-- Churn Analysis by Gender and Subscription Type
SELECT gender, subscription_type,
    SUM(1 - churn) AS non_churned_customers,
    SUM(churn) AS churned_customers
FROM customer_churn
GROUP BY gender, subscription_type;

-- Average Customer Metrics
SELECT 
    AVG(support_calls) AS avg_support_calls,
    AVG(last_interaction) AS avg_last_interaction,
    AVG(total_spend) AS avg_total_spend,
    AVG(payment_delay) AS avg_payment_delay,
    AVG(age) AS avg_age,
    AVG(churn) * 100 AS churn_rate_percentage
FROM customer_churn;

-- Total Spend Statistics
SELECT 
    MIN(total_spend) AS min_spend,
    MAX(total_spend) AS max_spend,
    SUM(total_spend) AS total_spend
FROM customer_churn;

-- Churn Breakdown by Gender
SELECT gender,
    COUNT(*) AS total_customers,
    SUM(1 - churn) AS non_churned_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY gender
ORDER BY churn_rate DESC;

-- Churn Rate by Subscription Type and Gender
SELECT subscription_type, gender,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY subscription_type, gender;

-- Customer Tenure and Churn Rate Analysis
SELECT 
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN 'Short Tenure'
        WHEN tenure BETWEEN 12 AND 36 THEN 'Medium Tenure'
        ELSE 'Long Tenure'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY tenure_group;

-- Churn Rate by Usage Frequency
SELECT 
    CASE 
        WHEN usage_frequency BETWEEN 1 AND 10 THEN 'Low Usage'
        WHEN usage_frequency BETWEEN 11 AND 20 THEN 'Medium Usage'
        ELSE 'High Usage'
    END AS frequency_group,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    SUM(1 - churn) AS non_churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY frequency_group
ORDER BY frequency_group;

-- Churn Rate by Customer Spend Category
SELECT 
    CASE 
        WHEN total_spend < 100 THEN 'Low Spend'
        WHEN total_spend BETWEEN 100 AND 500 THEN 'Medium Spend'
        ELSE 'High Spend'
    END AS spend_category,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY spend_category
ORDER BY spend_category;

-- Churn Rate by Age Group
SELECT 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and Above'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY age_group
ORDER BY age_group;

-- Churn Rate by Contract Length
SELECT contract_length, 
    COUNT(*) AS total_customers, 
    SUM(churn) AS churned_customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY contract_length;
