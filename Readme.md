# 🚨 AML Fraud Detection & Analytics Dashboard

## 📌 Project Overview

This project focuses on detecting and analyzing suspicious financial transactions using **data analytics, SQL, and Power BI dashboards**.

It simulates a real-world **Anti-Money Laundering (AML)** system by identifying high-risk customers, fraudulent transactions, and geographic risk patterns.

---

## 🎯 Objectives

* Detect **fraudulent and high-risk transactions**
* Identify **suspicious customer behavior**
* Analyze fraud trends across **countries and transaction types**
* Build an **interactive dashboard** for decision-making

---

## 🛠️ Tech Stack

* **Python (Pandas, NumPy)** → Data Cleaning & Feature Engineering
* **SQL** → Data extraction & fraud detection logic
* **Power BI** → Dashboard & visualization

---

## 📂 Dataset

The project uses three datasets:

* `customers.csv` → Customer details (KYC, income, country)
* `transactions.csv` → Transaction records
* `high_risk_countries.csv` → List of risky countries

---

## ⚙️ Data Processing (Python)

### Key Steps:

* Data cleaning (missing values, duplicates)
* Date formatting
* Standardizing country names

### Feature Engineering:

* Total transaction amount per customer
* Transaction frequency
* Average transaction value
* High-risk country transactions
* Large transactions (> ₹5 lakh)
* Round-number transactions

### Risk Scoring Logic:

Customers are assigned a **Risk Score** based on:

* High-risk country activity
* Large transactions
* High frequency
* Incomplete KYC
* Suspicious patterns

### Risk Categories:

* 🟢 Low Risk
* 🟠 Medium Risk
* 🔴 High Risk

---

## 🗄️ SQL Analysis

### Key Queries:

* High-value transactions detection
* Customers from high-risk countries
* Rapid transactions (same day multiple activity)
* Country mismatch detection
* Fraud flag classification using CASE logic

---

## 📊 Power BI Dashboard

### 🔹 Key KPIs:

* Total Transactions
* Fraud %
* Blocked Transactions
* Average Transaction Value
* High-Value Fraud Count

### 🔹 Visualizations:

* Fraud by Country (Map View)
* Fraud by Transaction Type
* Risk Category Distribution
* Monthly Fraud Trends
* Customer-level Drill-through Analysis

### 🔹 Drill-through Feature:

* Select a customer → View:

  * Transaction history
  * Risk score
  * Fraud indicators

---

## 🌍 Key Insights

* Certain countries show **higher fraud concentration**
* **Transfer & Withdrawal** transactions have higher risk
* High-risk customers often:

  * Perform large transactions
  * Operate in high-risk regions
  * Have incomplete KYC

---

## 🚀 Business Impact

* Helps banks detect **fraud early**
* Improves **compliance with AML regulations**
* Enables **risk-based customer monitoring**
* Supports **real-time fraud investigation**

---

## 📌 Future Enhancements

* Machine Learning model for fraud prediction
* Real-time streaming data integration
* Advanced anomaly detection
* Customer behavior profiling

---

## 📎 Conclusion

This project demonstrates how **data analytics + business logic** can effectively identify fraudulent activities and support financial institutions in reducing risk.

---

## 👨‍💻 Author

Pavan Kumar
