-- Monthly and Yearly Revenue Trends
SELECT 
    YEAR(t.TransactionDate) AS Year,
    MONTH(t.TransactionDate) AS Month,
    SUM(t.Amount) AS TotalRevenue
FROM Transactions t
GROUP BY YEAR(t.TransactionDate), MONTH(t.TransactionDate)
ORDER BY Year, Month;
