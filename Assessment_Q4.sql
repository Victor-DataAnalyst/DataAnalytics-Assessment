
SELECT 
  owner_id AS customer_id,
  TIMESTAMPDIFF(MONTH, MIN(transaction_date), CURDATE()) AS account_tenure_months,
  COUNT(transaction_type_id) AS total_transactions,
  COUNT(transaction_type_id) / TIMESTAMPDIFF(MONTH, MIN(transaction_date), CURDATE()) * 12 * 0.001 * AVG(amount) AS estimated_CLV
FROM 
  savings_savingsaccount
GROUP BY 
  owner_id
ORDER BY 
  estimated_CLV DESC;

