
  SELECT 
  p.plan_type_id,
  p.owner_id,
  p.plan_type_id AS type,
  MAX(s.transaction_date) AS last_transaction_date,
  DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM 
  plans_plan p
JOIN 
  savings_savingsaccount s ON p.plan_type_id = s.plan_id
WHERE 
  p.plan_type_id IN ('savings', 'investment')
GROUP BY 
  p.plan_type_id, p.owner_id, p.plan_type_id
HAVING 
  MAX(s.transaction_date) < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
ORDER BY 
  inactivity_days DESC;
