	--Churn Analysis by Gender and Subscription Type
	
-- Male customers with Basic subscription
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Male' and churn = 0 and subscription_type = 'Basic'
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Male' and churn = 1 and subscription_type = 'Basic'

-- Male customers with Standard subscription
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Male' and churn = 0 and subscription_type = 'Standard'
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Male' and churn = 1 and subscription_type = 'Standard'

-- Male customers with Premimum subscription
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Male' and churn = 0 and subscription_type = 'Premium'
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Male' and churn = 1 and subscription_type = 'Premium'

-- Female customers with Basic subscription
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Female' and churn = 0 and subscription_type = 'Basic'
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Female' and churn = 1 and subscription_type = 'Basic'

-- Female customers with Standard subscription
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Female' and churn = 0 and subscription_type = 'Standard'
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Female' and churn = 1 and subscription_type = 'Standard'

-- Female customers with Premium subscription
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Female' and churn = 0 and subscription_type = 'Premium'
SELECT COUNT(*) FROM customer_churn WHERE gender = 'Female' and churn = 1 and subscription_type = 'Premium'

-- Average Customer Metrics
SELECT AVG(support_calls) FROM customer_churn;
SELECT AVG(last_interaction) FROM customer_churn;
SELECT AVG(total_spend) FROM customer_churn;
SELECT AVG(payment_delay) FROM customer_churn;
SELECT AVG(age) FROM customer_churn;
SELECT AVG(churn) FROM customer_churn;

-- Total Spend Statistics
SELECT MIN(total_spend) FROM customer_churn;
SELECT MAX (total_spend)FROM customer_churn;
SELECT SUM(total_spend) FROM customer_churn;
	
--Churn Breakdown by Gender
SELECT gender,
	TO_CHAR(COUNT (*), 'FM999,999,999') AS non_churned_customers
FROM customer_churn
	WHERE churn = 0
GROUP BY gender

SELECT gender,
	TO_CHAR (COUNT (*), 'FM999,999,999') AS churned_customers
FROM customer_churn
	WHERE churn = 1
GROUP BY gender
	
-- Gender-Based Churn Behaviour
SELECT gender,
	TO_CHAR(SUM (CASE WHEN churn = 0 THEN 1 ELSE 0 END), 'FM999,999,999') AS non_churned_customers,
	TO_CHAR(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END ), 'FM999,999,999') AS churned_customers,
	ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END)* 100.0/ COUNT (*),2) AS churn_rate
FROM customer_churn
GROUP BY gender
ORDER BY churn_rate DESC;

-- Churn Rate by Subscription Type and Gender
	--Churned male customers by subscription type
SELECT subscription_type, 
	TO_CHAR(COUNT(*), 'FM999,999,999') AS churned_customers_by_subscription
FROM customer_churn
WHERE gender = 'Male' and churn = 1 
GROUP BY subscription_type;

-- Non_churned male customers by subscription type
SELECT subscription_type, 
	TO_CHAR(COUNT(*), 'FM999,999,999') AS non_churned_customers_by_subscription
FROM customer_churn
WHERE gender = 'Male' and churn = 0
GROUP BY subscription_type

--Churned female customers by subscription type

SELECT subscription_type, 
	TO_CHAR(COUNT(*), 'FM999,999,999') AS churned_customers_by_subscription
FROM customer_churn
WHERE gender = 'Female' and churn = 1 
GROUP BY subscription_type

--- Female churn rate by subscription type
SELECT subscription_type, 
	TO_CHAR(COUNT(*), 'FM999,999,999') AS female_total_customers,
	ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn WHERE gender = 'Female' GROUP BY subscription_type


--- Female non_churn by subscription type
SELECT subscription_type,
	TO_CHAR(COUNT (*), 'FM999,999,999') female_total_customers,
	ROUND(SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT (*), 2) AS non_churn_rate
FROM customer_churn WHERE gender = 'Female' GROUP BY subscription_type


--- Male churn rate by subscription type
SELECT subscription_type,
	TO_CHAR(COUNT(*), 'FM999,999,999') AS total_male_customers,
	ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE  0 END)* 100.0 /COUNT(*),2) AS churn_rate
FROM customer_churn WHERE gender = 'Male' GROUP BY subscription_type

--- Male non_churn rate by subscription type
SELECT subscription_type,
	TO_CHAR(COUNT(*), 'FM999,999,999') AS total_male_customers,
	ROUND(SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) non_churn_rate
FROM customer_churn WHERE gender = 'Male' GROUP BY subscription_type


SELECT *
FROM customer_churn

 
SELECT tenure FROM customer_churn WHERE tenure = 60

-- Customer Tenure and Churn Rate Analysis
	-- Grouping csutomers by tenure length and calculating churn rates
SELECT 
	CASE
	WHEN "tenure"  BETWEEN 0 AND 12 THEN 'short_tenure'
	WHEN "tenure" BETWEEN 12 AND 36 THEN 'medium_tenure'
	ELSE 'long_tenure'
	END AS tenure_group,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END ) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE  0 END)* 100.0 /COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY tenure_group


--Churn Analysis by Tenure and Subscription Type
SELECT 
	CASE
	WHEN "tenure"  BETWEEN 0 AND 12 THEN 'short_tenure'
	WHEN "tenure" BETWEEN 12 AND 36 THEN 'medium_tenure'
	ELSE 'long_tenure'
	END AS tenure_group,
		subscription_type,
COUNT(*) AS total_customers,
SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END ) AS churned_customers,
ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE  0 END)* 100.0 /COUNT(*),2) AS churn_rate
FROM customer_churn
GROUP BY tenure_group, subscription_type



--- Churn Rate by Subscription Type and Gender
SELECT subscription_type, gender,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY subscription_type, gender














