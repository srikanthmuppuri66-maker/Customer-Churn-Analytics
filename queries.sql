USE CustomerAnalyticsDB;

-- 1. OVERALL CHURN METRICS
SELECT 
    COUNT(*) AS total_customers,
    SUM(CAST(Churn_Numeric AS INT)) AS total_churned,
    ROUND(AVG(CAST(Churn_Numeric AS FLOAT)) * 100, 2) AS churn_rate_percent
FROM cleaned_customer_churn;

-- 2. CHURN RATE BY CONTRACT TYPE
SELECT 
    Contract,
    COUNT(*) AS customer_count,
    SUM(CAST(Churn_Numeric AS INT)) AS churned_count,
    ROUND(AVG(CAST(Churn_Numeric AS FLOAT)) * 100, 2) AS churn_rate_percent,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_bill
FROM cleaned_customer_churn
GROUP BY Contract
ORDER BY churned_count DESC;

-- 3. HIGH-VALUE AT-RISK CUSTOMERS
SELECT TOP 10
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    TotalCharges
FROM cleaned_customer_churn
WHERE Churn_Numeric = 0 
  AND Contract = 'Month-to-month' 
  AND MonthlyCharges > 80
ORDER BY MonthlyCharges DESC;