-- Customer Segmentation by Spending and Credit Score
SELECT 
    c.CustomerID,
    c.Name,
    SUM(t.Amount) AS TotalSpent,
    cs.CreditScore,
    CASE 
        WHEN SUM(t.Amount) > 10000 AND cs.CreditScore > 700 THEN 'High Value - Low Risk'
        WHEN SUM(t.Amount) > 10000 AND cs.CreditScore <= 700 THEN 'High Value - High Risk'
        WHEN SUM(t.Amount) <= 10000 AND cs.CreditScore > 700 THEN 'Medium Value - Low Risk'
        ELSE 'Low Value or High Risk'
    END AS Segment
FROM Customers c
JOIN Transactions t ON c.CustomerID = t.CustomerID
JOIN CreditScores cs ON c.CustomerID = cs.CustomerID
GROUP BY c.CustomerID, c.Name, cs.CreditScore;
