-- Credit Risk Analysis based on Late Payments
SELECT 
    c.CustomerID,
    c.Name,
    COUNT(p.PaymentID) AS LatePayments,
    AVG(cs.CreditScore) AS AvgCreditScore,
    CASE 
        WHEN COUNT(p.PaymentID) > 3 AND AVG(cs.CreditScore) < 600 THEN 'High Risk'
        WHEN COUNT(p.PaymentID) BETWEEN 1 AND 3 THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS RiskCategory
FROM Customers c
JOIN Payments p ON c.CustomerID = p.CustomerID
JOIN CreditScores cs ON c.CustomerID = cs.CustomerID
WHERE p.PaymentDate > DATEADD(DAY, 7, t.TransactionDate)
GROUP BY c.CustomerID, c.Name;
