
SELECT 
  owner_id,
  AVG(transactions) AS avg_transactions,
  CASE
    WHEN AVG(transactions) >= 10 THEN 'High Frequency'
    WHEN AVG(transactions) BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
  END AS frequency_category
FROM 
  (
    SELECT 
      owner_id,
      YEAR(transaction_date) AS year,
      MONTH(transaction_date) AS month,
      COUNT(*) AS transactions
    FROM 
      adashi_staging.withdrawals_withdrawal
    GROUP BY 
      owner_id, YEAR(transaction_date), MONTH(transaction_date)
  ) AS monthly_transactions
GROUP BY 
  owner_id
ORDER BY 
  avg_transactions DESC;
