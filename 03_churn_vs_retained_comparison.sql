-- Step 3: Compare average behavior between churned and retained customers
-- Repeated across multiple metric pairs: return_rate/satisfaction_score,
-- engagement_score/cart_abandonment_rate, days_since_last_purchase/browsing_frequency

SELECT 
    t.churned,
    COUNT(*) AS num_customers,
    AVG(f.return_rate) AS avg_return_rate,
    AVG(f.satisfaction_score) AS avg_satisfaction
FROM dbo.ecommerce_customer_features f
JOIN dbo.ecommerce_customer_targets t
    ON f.Customer_ID = t.Customer_ID
GROUP BY t.churned;

-- Result: Return rate 6.9% (retained) vs 8.4% (churned) — small gap
--         Satisfaction 8.14 (retained) vs 7.68 (churned) — moderate gap


SELECT 
    t.churned,
    COUNT(*) AS num_customers,
    AVG(f.engagement_score) AS avg_engagement,
    AVG(f.cart_abandonment_rate) AS avg_cart_abandonment
FROM dbo.ecommerce_customer_features f
JOIN dbo.ecommerce_customer_targets t
    ON f.Customer_ID = t.Customer_ID
GROUP BY t.churned;

-- Result: Engagement 5.35 (retained) vs 2.36 (churned) — large gap
--         Cart abandonment 0.60 vs 0.60 — no gap at all


SELECT 
    t.churned,
    COUNT(*) AS num_customers,
    AVG(f.days_since_last_purchase) AS avg_days_since_last_purchase,
    AVG(f.browsing_frequency_per_week) AS avg_browsing_frequency
FROM dbo.ecommerce_customer_features f
JOIN dbo.ecommerce_customer_targets t
    ON f.Customer_ID = t.Customer_ID
GROUP BY t.churned;

-- Result: Days since last purchase 20 (retained) vs 81 (churned) — very large gap
--         Browsing frequency 3.17 vs 2.56 — small-moderate gap
