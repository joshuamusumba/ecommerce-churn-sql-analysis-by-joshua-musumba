-- Step 1: Establish baseline churn rate
-- Finding: 929 of 6,000 customers churned (15.5%)

SELECT churned, COUNT(*)
FROM dbo.ecommerce_customer_targets
GROUP BY churned;
