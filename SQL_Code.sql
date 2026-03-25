-- Created a primary key and foreign key and connected customers and transactions table
ALTER TABLE customers
ADD PRIMARY KEY (Customer_ID);

-- Step 2: Foreign Key
ALTER TABLE transactions
ADD CONSTRAINT fk_customer
FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

SELECT *
FROM transactions t
JOIN customers c
ON t.Customer_ID = c.Customer_ID;

ALTER TABLE transactions
ADD CONSTRAINT fk_customer
FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID);
------------------------------------------------------------------------------------------------------------------------------
-- 1. Customers from High-Risk Countries
SELECT c.*
FROM customers c
JOIN high_risk_countries h
ON c.Country = h.Country;

-- 2. High-Value Transactions (e.g., > 700000)
SELECT *
FROM transactions
WHERE Amount > 700000;

-- 3. Customers with Multiple High-Value Transactions
SELECT Customer_ID, COUNT(*) AS txn_count
FROM transactions
WHERE Amount > 700000
GROUP BY Customer_ID
HAVING COUNT(*) > 2;

-- 4. Transactions from High-Risk Countries
SELECT t.*
FROM transactions t
JOIN high_risk_countries h
ON t.Country = h.Country;

-- 5. Flag Customers with Suspicious Activity
-- 👉 (High amount + high-risk country)

SELECT DISTINCT t.Customer_ID,t.country
FROM transactions t
JOIN high_risk_countries h
ON t.Country = h.Country
WHERE t.Amount > 700000;

--  6. Customers Not Logged In Recently (Dormant Accounts)
SELECT *
FROM customers
WHERE Last_Login < DATE_SUB(CURDATE(), INTERVAL 180 DAY);

-- 7. Rapid Transactions (Same Day Multiple Transactions)
SELECT Customer_ID, Date, COUNT(*) AS txn_count
FROM transactions
GROUP BY Customer_ID, Date
HAVING COUNT(*) > 5;

--  8. Mismatch Between Customer Country & Transaction Country
SELECT t.*,c.country
FROM transactions t
JOIN customers c
ON t.Customer_ID = c.Customer_ID
WHERE t.Country <> c.Country;

--  9. Total Transaction Amount per Customer
SELECT Customer_ID, SUM(Amount) AS total_amount
FROM transactions
GROUP BY Customer_ID;

-- 10. High-Risk Customers with KYC Pending
SELECT c.*
FROM customers c
JOIN high_risk_countries h
ON c.Country = h.Country
WHERE c.KYC_Status = 'Pending';


SELECT 
    t.Transaction_ID,
    t.Customer_ID,
    t.Amount,
    t.Date,
    t.Country,
    t.Transaction_Type,
    t.Device_ID,
    t.IP_Address,
    t.Status,

    CASE 
        -- 🔴 HIGH RISK
        WHEN t.Country IN (SELECT Country FROM high_risk_countries)
             AND t.Amount > 500000 
             AND t.Transaction_Type IN ('Withdrawal','Transfer')
        THEN 'HIGH RISK'

        -- 🔴 HIGH RISK (Device/IP anomaly)
        WHEN t.Country IN (SELECT Country FROM high_risk_countries)
        THEN 'HIGH RISK'

        -- 🟠 MEDIUM RISK
        WHEN t.Amount BETWEEN 100000 AND 500000
        THEN 'MEDIUM RISK'

        -- 🟠 MEDIUM (Suspicious withdrawal)
        WHEN t.Transaction_Type = 'Withdrawal' AND t.Amount > 200000
        THEN 'MEDIUM RISK'

        -- 🟢 LOW RISK
        ELSE 'LOW RISK'
    END AS Risk_Flag

FROM transactions t;

-- ADVANCED VERSION (WITH MORE AML INTELLIGENCE)
SELECT 
    t.*,

    CASE 
        -- HIGH RISK: High-risk country + large txn
        WHEN h.Country IS NOT NULL AND t.Amount > 500000 THEN 'HIGH RISK'

        -- HIGH RISK: Very large transaction
        WHEN t.Amount > 800000 THEN 'HIGH RISK'

        -- MEDIUM: Moderate + risky type
        WHEN t.Amount BETWEEN 200000 AND 500000 
             AND t.Transaction_Type IN ('Withdrawal','Transfer')
        THEN 'MEDIUM RISK'

        -- MEDIUM: Multiple red flags
        WHEN t.Transaction_Type = 'Withdrawal' AND t.Amount > 150000
        THEN 'MEDIUM RISK'

        ELSE 'LOW RISK'
    END AS Risk_Flag

FROM transactions t
LEFT JOIN high_risk_countries h
ON t.Country = h.Country;



