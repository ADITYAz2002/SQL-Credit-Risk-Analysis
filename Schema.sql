IF OBJECT_ID('dbo.Payments', 'U') IS NOT NULL DROP TABLE dbo.Payments;
IF OBJECT_ID('dbo.Credit_Score', 'U') IS NOT NULL DROP TABLE dbo.Credit_Score;
IF OBJECT_ID('dbo.Transactions', 'U') IS NOT NULL DROP TABLE dbo.Transactions;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;

CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
full_name NVARCHAR(100),
age INT,
income DECIMAL(12,2),
city NVARCHAR(50),
join_date DATE
);

CREATE TABLE Transactions (
txn_id INT PRIMARY KEY,
customer_id INT,
amount DECIMAL(12,2),
merchant NVARCHAR(100),
txn_date DATE,
category NVARCHAR(50),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Credit_Score (
customer_id INT,
credit_score INT,
last_updated DATE,
PRIMARY KEY (customer_id, last_updated),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Payments (
payment_id INT PRIMARY KEY,
customer_id INT,
due_amount DECIMAL(12,2),
paid_amount DECIMAL(12,2),
due_date DATE,
payment_date DATE NULL,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE INDEX idx_txn_date ON Transactions(txn_date);
CREATE INDEX idx_credit_score ON Credit_Score(credit_score);