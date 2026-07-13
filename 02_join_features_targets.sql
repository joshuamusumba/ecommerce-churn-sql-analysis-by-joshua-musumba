-- Step 2: Join customer features to churn outcome
-- Links behavioral data to churn status via shared Customer_ID

SELECT 
    f.Customer_ID,
    f.return_rate,
    f.satisfaction_score,
    t.churned
FROM dbo.ecommerce_customer_features f
JOIN dbo.ecommerce_customer_targets t
    ON f.Customer_ID = t.Customer_ID
WHERE f.return_rate > 0.15
ORDER BY f.return_rate DESC;
