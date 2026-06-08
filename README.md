# churn-telecom

## Dataset
Telecom customer dataset with 7,043 records and 21 columns, including contract type, monthly charges, tenure, payment method, and churn status (Yes/No).

## Business Problem
Identify which high‑value customers are churning and quantify the revenue impact of their churn.

## Data Cleaning
Churn column contained hidden carriage return characters (\r) → fixed using REPLACE.
TotalCharges column was stored as VARCHAR → converted to DECIMAL using CAST for accurate calculations.

## Findings
428 high‑value customers churned, resulting in $1.94M revenue loss.

Month‑to‑month contracts with electronic check payments show the highest churn rate (53.7%).

Customers with add‑on services churn at 22.3%, while those without churn at 31.5% — a 9% difference.

High‑value customers contribute 62% of total churned revenue, despite being fewer in number.

## Recommendations
Provide personalized retention offers to high‑value customers before they leave.

Encourage month‑to‑month customers to switch to yearly plans by offering discounts.

Offer free trials of add‑on services to customers who don’t currently use them.

Launch a loyalty rewards program specifically for high‑value customers to strengthen long‑term relationships.

## Tool Stack 
SQL POWERBI
