
-- Find high-value customers with both funded savings and investment plans
SELECT
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT sa.id) AS savings_count,
    COUNT(DISTINCT ip.id) AS investment_count,
    ROUND(SUM(sa.new_balance) + SUM(sa.new_balance), 2) AS total_deposits
FROM
    adashi_staging.users_customuser u
-- Join with funded savings accounts
JOIN
    adashi_staging.savings_savingsaccount sa
    ON sa.owner_id = u.id AND sa.new_balance > 0
-- Join with funded investment plans
JOIN
    adashi_staging.plans_plan ip
    ON ip.owner_id = u.id AND ip.plan_type_id = 'Investment' AND sa.new_balance > 0
GROUP BY
    u.id, u.name
HAVING
    savings_count > 0 AND investment_count > 0
ORDER BY
    total_deposits DESC;
