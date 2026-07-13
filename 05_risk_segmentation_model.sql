-- Step 5: Final risk segmentation model
-- Uses CASE WHEN to bucket customers by recency, structured with a CTE (WITH clause)
-- This is the headline finding of the analysis.

WITH customer_risk AS (
    SELECT 
        f.Customer_ID,
        t.churned,
        CASE 
            WHEN f.days_since_last_purchase <= 30 THEN 'Active'
            WHEN f.days_since_last_purchase <= 60 THEN 'At Risk'
            ELSE 'High Risk'
        END AS risk_segment
    FROM dbo.ecommerce_customer_features f
    JOIN dbo.ecommerce_customer_targets t
        ON f.Customer_ID = t.Customer_ID
)
SELECT 
    risk_segment,
    COUNT(*) AS num_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS num_churned,
    ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) 
        / COUNT(*), 1) AS churn_rate_pct
FROM customer_risk
GROUP BY risk_segment
HAVING COUNT(*) > 100
ORDER BY churn_rate_pct DESC;

-- Result:
-- High Risk (60+ days inactive):  781 customers, 88.2% churn rate
-- At Risk   (31-60 days inactive): 1,371 customers, 17.1% churn rate
-- Active    (0-30 days inactive):  3,848 customers, 0.2% churn rate
