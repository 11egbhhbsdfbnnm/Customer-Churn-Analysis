-- DATA CLEANING WITH SQL

-- Load the data
SELECT *
FROM customer_churn


-- To check for null values in all columns

SELECT*
FROM customer_churn
WHERE "CustomerID" IS NULL
	OR "Age" IS NULL
	OR "Gender" IS NULL
	OR "Tenure" IS NULL
	OR "Usage.Frequency" IS NULL
	OR "Support.Calls" IS NULL
	OR "Payment.Delay" IS NULL
	OR "Subscription.Type" IS NULL
	OR "Contract.Length" IS NULL
	OR "Total.Spend" IS NULL
	OR "Last.Interaction" IS NULL
	OR "Churn" IS NULL

-- Count null values in each column

SELECT COUNT(CASE WHEN "CustomerID" IS NULL THEN 1 END) AS "EmptyID",
 	COUNT(CASE WHEN "Age" IS NULL THEN 1 END) AS "EmptyAge",
	COUNT(CASE WHEN "Gender" IS NULL THEN 1 END) AS "EmptyGender",
	COUNT(CASE WHEN "Tenure" IS NULL THEN 1 END) AS "EmptyTenure",
	COUNT(CASE WHEN "Usage.Frequency" IS NULL THEN 1 END) AS "EmptyFrequency",
	COUNT (CASE WHEN "Support.Calls" IS NULL THEN 1 END) AS "Emptycalls",
	COUNT(CASE WHEN "Payment.Delay" IS NULL THEN 1 END) AS "EmptyDelay",
	COUNT(CASE WHEN"Subscription.Type" IS NULL THEN 1 END) AS "EmptySub",
	COUNT(CASE WHEN"Contract.Length" IS NULL THEN 1 END) AS "EmptyContract",
	COUNT(CASE WHEN"Total.Spend" IS NULL THEN 1 END) AS "EmptySpend",
	COUNT(CASE WHEN "Last.Interaction" IS NULL THEN 1 END) AS "EmptyInteraction",
	COUNT(CASE WHEN "Churn" IS NULL THEN 1 END) AS "EmptyChurn"
FROM customer_churn


--  Check for duplicates using ROW_NUMBER()

SELECT *,
ROW_NUMBER () OVER (
PARTITION BY "CustomerID", "Age", "Gender", "Usage.Frequency", "Support.Calls", "Payment.Delay", "Subscription.Type", "Contract.Length", "Total.Spend", "Last.Interaction", "Churn") AS row_num
FROM customer_churn

-- To check for duplicates using CTE (common table expression)

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY "CustomerID", "Age", "Gender", "Usage.Frequency", "Support.Calls", "Payment.Delay", "Subscription.Type", "Contract.Length", "Total.Spend", "Last.Interaction", "Churn") AS row_num
FROM customer_churn
)
SELECT *
FROM  duplicate_cte
WHERE row_num > 1;


-- Trim spaces from Subscription Type

SELECT "Subscription.Type", TRIM("Subscription.Type")
FROM customer_churn


--Rename columnd for better readability

ALTER TABLE customer_churn
RENAME COLUMN "CustomerID" TO "customer_id"

ALTER TABLE customer_churn
RENAME COLUMN "Age" TO "age"

ALTER TABLE customer_churn
RENAME COLUMN "Gender" TO "gender"

ALTER TABLE customer_churn
RENAME COLUMN "Tenure" TO "tenure"

ALTER TABLE customer_churn
RENAME COLUMN "Usage.Frequency" TO "usage_frequency"

ALTER TABLE customer_churn
RENAME COLUMN "Support.Calls" TO "support_calls"

ALTER TABLE customer_churn
RENAME COLUMN "Payment.Delay" TO "payment_delay"

ALTER TABLE customer_churn
RENAME COLUMN "Subscription.Type" TO "subscription_type"

ALTER TABLE customer_churn
RENAME COLUMN "Contract.Length" TO "contract_length"

ALTER TABLE customer_churn
RENAME COLUMN "Total.Spend" TO "total_spend"

ALTER TABLE customer_churn
RENAME COLUMN "Last.Interaction" TO "last_interaction"

ALTER TABLE customer_churn
RENAME COLUMN "Churn" TO "churn"












