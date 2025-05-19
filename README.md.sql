-- Assessment_Q1.sql --
-- MySQL Query Explanation --
-- This MySQL query is designed to find high-value customers who have both funded savings and investment plans --

-- Query Structure --

-SELECT statement: Selects the columns to retrieve.
-JOIN clauses: Joins the users_customuser table with savings_savingsaccount and plans_plan tables.
-GROUP BY clause: Groups the results by customer.
-HAVING clause: Filters the results to include only customers with both savings and investment plans.
-ORDER BY clause: Orders the results by total deposits.

Selected Columns

- owner_id: The ID of the customer.
- name: The name of the customer.
- savings_count: The number of distinct savings accounts.
- investment_count: The number of distinct investment plans.
- total_deposits: The total balance of savings and investment plans.

JOIN Clauses
The query joins the users_customuser table with:

- savings_savingsaccount table: Joins on owner_id and filters for accounts with a balance greater than 0.
- plans_plan table: Joins on owner_id, filters for investment plans (plan_type = 'Investment'), and balances greater than 0.

GROUP BY and HAVING Clauses
The query:

- Groups the results by owner_id and name.
- Filters the results to include only customers with both savings and investment plans using the HAVING clause.

ORDER BY Clause
The query orders the results by total_deposits in descending order.

How the Query Works
- Identify customers with funded savings and investment plans: The query joins the tables and filters for customers with both types of plans.
- Calculate savings and investment counts: The query counts the distinct savings accounts and investment plans for each customer.
- Calculate total deposits: The query calculates the total balance of savings and investment plans for each customer.
- Return high-value customers: The query returns the customers with both savings and investment plans, ordered by total deposits.

Business case
This query provides valuable insights into high-value customers, allowing businesses to:

- Identify customers with multiple funded plans
- Analyze customer behavior and preferences
- Develop targeted marketing strategies to retain high-value customers


-- Assessment_Q2.sql --
-- The Query Structure--
The query consists of two main parts:
-- Subquery: The subquery calculates the number of transactions for each customer per month.
-- Main Query: The main query calculates the average number of transactions per customer and categorizes them based on frequency.

Subquery

SELECT 
  owner_id,
  YEAR(transaction_date) AS year,
  MONTH(transaction_date) AS month,
  COUNT(*) AS transactions
FROM 
  transactions
GROUP BY 
  owner_id, YEAR(transaction_date), MONTH(transaction_date)


The subquery:

- Selects the owner_id, year, and month from the transaction_date column.
- Counts the number of transactions for each customer per month using COUNT(*).
- Groups the results by customer_id, year, and month.

Main Query

SELECT 
  owner_id,
  AVG(transactions) AS avg_transactions,
  CASE
    WHEN AVG(transactions) >= 10 THEN 'High Frequency'
    WHEN AVG(transactions) BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
  END AS frequency_category
FROM 
   AS monthly_transactions
GROUP BY 
  owner_id
ORDER BY 
  avg_transactions DESC;


The main query:

- Calculates the average number of transactions per customer using AVG(transactions).
- Categorizes customers based on their average transaction frequency using a CASE statement.
- Groups the results by customer_id.
- Orders the results by avg_transactions in descending order.

How Data is Retrieved
The query retrieves data from the transactions table by:

Filtering and grouping data: The subquery filters and groups the data by customer and month.
Calculating aggregates: The main query calculates the average number of transactions and categorizes customers based on frequency.
-- Returning results: The final results are returned, showing the customer ID, average transactions, and frequency category --

Business marketing strategies
This query provides valuable insights into customer transaction behavior, allowing businesses to:

- Identify high-frequency customers
- Analyze transaction patterns
- Develop targeted marketing strategies


-- Assessment_Q3.sql--
-- To retreive all active customer accounts with no transactions in the last year --
This query joins the plans_plan and savings_savingsaccount tables based on plan_id.
it also filters for active accounts with plan types savings or investment.
The having clause filters for accounts with no transactions in the last year. 


-- Assessment_Q4.sql--
-- Calculating Estimated Customer Lifetime Value (CLV)--
-- Query Explanation --
-- The MySQL query calculates the estimated Customer Lifetime Value (CLV) for each customer based on their transaction history.

-- Account Tenure Calculation--
TIMESTAMPDIFF (MONTH, MIN(transaction_date), CURDATE() calculates the account tenure in months since the first transaction.
MIN(transaction_date) finds the earliest transaction date for each customer.
CURDATE() gets the current date.
TIMESTAMPDIFF(MONTH) calculates the difference between the two dates in months.

2. Total Transactions Calculation
COUNT(transaction_id) calculates the total number of transactions for each customer.

3. Estimated CLV Calculation
COUNT(transaction_id) / TIMESTAMPDIFF(MONTH, MIN(transaction_date), CURDATE()) * 12 * 0.001 * AVG(transaction_amount) calculates the estimated CLV based on the formula:

CLV = (Total Transactions / Tenure) * 12 * Average Profit per Transaction

COUNT(transaction_id) / TIMESTAMPDIFF(MONTH, MIN(transaction_date), CURDATE() calculates the average number of transactions per month.
* 12 annualizes the transaction frequency.
0.001 represents the average profit per transaction as a percentage (0.1%).
AVG(transaction_amount) calculates the average transaction value.

4. Grouping and Ordering
The results are grouped by owner_id (customer ID) and ordered by estimated CLV from highest to lowest.

for the purpose of this calculation, I assume...
-- The transaction_amount column represents the transaction value.
-- The transaction_date column represents the date of each transaction.
-- The owner_id column represents the customer ID.
-- The average profit per transaction is 0.1% of the transaction value.

Business Case
This query can help businesses identify high-value customers and tailor their marketing strategies accordingly.