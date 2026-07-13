-- Step 4: Does loyalty membership reduce churn?
-- Uses a window function (OVER PARTITION BY) to compute % within each group directly

SELECT 
    f.loyalty_member,
    t.churned,
    COUNT(*) AS num_customers,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY f.loyalty_member),
        1
    ) AS pct_within_group
FROM dbo.ecommerce_customer_features f
JOIN dbo.ecommerce_customer_targets t
    ON f.Customer_ID = t.Customer_ID
GROUP BY f.loyalty_member, t.churned
ORDER BY f.loyalty_member, t.churned;

-- Result: Non-members churn at 16.9%, loyalty members churn at 9.0%
-- Loyalty membership roughly halves churn risk
