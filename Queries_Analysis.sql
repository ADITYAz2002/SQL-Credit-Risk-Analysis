-- Top 10 customers by total transaction volume
SELECT TOP 10 c.full_name, SUM(t.amount) AS total_spent
FROM Customers c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC;

-- Monthly revenue trend
SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0) AS month_start,
SUM(amount) AS revenue
FROM Transactions
GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0)
ORDER BY month_start;

-- Most common spending category per income group
SELECT c.income, t.category, COUNT(*) AS txn_count
FROM Customers c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.income, t.category
ORDER BY c.income, txn_count DESC;

-- Rolling 3 transactions spend per customer
SELECT customer_id,
txn_date,
SUM(amount) OVER (PARTITION BY customer_id ORDER BY txn_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3_txn
FROM Transactions;

-- Rank customers by avg spend in each city
SELECT c.city, c.full_name, AVG(t.amount) AS avg_spent,
RANK() OVER (PARTITION BY c.city ORDER BY AVG(t.amount) DESC) AS rank_in_city
FROM Customers c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.city, c.full_name;

-- Customers with missed payments vs. their credit score trend
SELECT c.full_name, p.due_amount, p.paid_amount, cs.credit_score, cs.last_updated
FROM Customers c
JOIN Payments p ON c.customer_id = p.customer_id
JOIN Credit_Score cs ON c.customer_id = cs.customer_id
WHERE p.paid_amount < p.due_amount;

-- Identify high-value customers (spend > 50k per month, no missed payments)
WITH monthly_spend AS (
SELECT customer_id,
DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0) AS month_start,
SUM(amount) AS total_monthly_spend
FROM Transactions
GROUP BY customer_id, DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0)
)
SELECT DISTINCT c.full_name, ms.month_start, ms.total_monthly_spend
FROM monthly_spend ms
JOIN Customers c ON ms.customer_id = c.customer_id
WHERE ms.total_monthly_spend > 50000
AND cs.credit_score < 700;