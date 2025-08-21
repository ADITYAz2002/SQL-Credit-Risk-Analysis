# Customer Spending & Credit Risk Analysis (SQL Project)

## 📌 Overview
This project demonstrates advanced **SQL (T-SQL)** skills by analyzing **customer spending patterns, payments, and credit risk**. It simulates a financial dataset relevant to companies like **American Express**, showcasing the ability to extract business insights using SQL.

The project covers:
- Data modeling (fact/dimension tables with constraints & indexes)
- Analytical queries with **joins, aggregations, window functions, and CTEs**
- Business insights such as **high-value customers, at-risk customers, churn signals**
- Query optimization techniques (indexes and partitions)

---

## 📂 Project Structure
```
├── schema.sql         # Database schema (tables, constraints, indexes)
├── insert_data.sql    # Sample data for Customers, Transactions, Payments, Credit Score
├── queries.sql        # Analytical queries with business insights
└── README.md          # Project documentation
```

---

## 🏗 Database Schema

**Tables:**
1. **Customers** → Customer demographic and financial profile  
2. **Transactions** → All customer transaction history  
3. **Credit_Score** → Historical credit score records  
4. **Payments** → Due vs. paid amounts, payment history  

**Schema Diagram:**
```
Customers (customer_id PK)
    │
    ├──< Transactions (txn_id PK)
    │
    ├──< Credit_Score (customer_id, last_updated PK)
    │
    └──< Payments (payment_id PK)
```

---

## 📊 Sample Data (Preview)

**Customers**
| customer_id | full_name    | age | income   | city      | join_date  |
|-------------|-------------|-----|----------|-----------|------------|
| 1           | Amit Sharma | 32  | 85000.00 | Mumbai    | 2022-01-15 |
| 2           | Neha Verma  | 27  | 65000.00 | Delhi     | 2022-03-20 |
| 3           | Raj Patel   | 45  | 120000.00| Bangalore | 2021-07-10 |

**Transactions**
| txn_id | customer_id | amount | merchant | txn_date   | category   |
|--------|-------------|--------|----------|------------|------------|
| 101    | 1           | 5000   | Amazon   | 2023-01-12 | Shopping   |
| 102    | 1           | 2000   | Swiggy   | 2023-02-05 | Food       |
| 103    | 2           | 15000  | Flipkart | 2023-01-22 | Shopping   |

---

## 🔍 Key SQL Queries & Insights

1. **Top 10 Customers by Spend**  
```sql
SELECT TOP 10 c.full_name, SUM(t.amount) AS total_spent
FROM Customers c
JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.full_name
ORDER BY total_spent DESC;
```
📌 Identifies the **highest value customers**.

---

2. **Monthly Revenue Trend**  
```sql
SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0) AS month_start,
       SUM(amount) AS revenue
FROM Transactions
GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0)
ORDER BY month_start;
```
📌 Shows **growth or decline trends** over time.

---

3. **Rolling 3-Transaction Spend per Customer**  
```sql
SELECT customer_id, txn_date,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY txn_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3_txn
FROM Transactions;
```
📌 Tracks **short-term spending momentum**.

---

4. **At-Risk Customers**  
```sql
SELECT DISTINCT c.full_name
FROM Customers c
JOIN Credit_Score cs ON c.customer_id = cs.customer_id
JOIN Payments p ON c.customer_id = p.customer_id
WHERE p.paid_amount < p.due_amount
AND cs.credit_score < 700;
```
📌 Flags customers with **low credit scores & missed payments**.

---

## 🚀 How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/sql-credit-risk-analysis.git
   cd sql-credit-risk-analysis
   ```

2. Open **SQL Server Management Studio (SSMS)** or **Azure SQL**.

3. Run scripts in order:
   - `schema.sql`
   - `insert_data.sql`
   - `queries.sql`

4. Explore the results of queries for insights.

---

## 📈 Business Impact
- **For Banks/Fintech (like AmEx):**
  - Identify high-value customers for rewards/loyalty programs.
  - Detect customers at risk of defaulting.
  - Monitor revenue trends and transaction categories.
  - Enable data-driven decision making for credit risk & customer segmentation.

---

## 🔧 Future Enhancements
- Load larger datasets from **Kaggle or Faker-generated data**
- Integrate with **Power BI/Tableau dashboards**
- Add stored procedures for **automated credit risk scoring**
- Explore **ETL pipelines** to automate ingestion

---

## 👨‍💻 Author
**Aditya Chaturvedi**  
Passionate about Data Engineering, SQL, and Analytics.  
📌 This project is designed to showcase SQL expertise and business problem-solving skills for analytics-driven organizations.
