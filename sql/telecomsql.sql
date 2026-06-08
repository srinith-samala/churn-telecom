CREATE DATABASE churn;
USE churn
CREATE TABLE telecom(
	customerID VARCHAR(100),
    gender VARCHAR(100),
    SeniorCitizen VARCHAR(100),
    Partner VARCHAR(100),
    Dependents VARCHAR(100),
    tenure VARCHAR(100),
    PhoneService VARCHAR(100),
    MultipleLines VARCHAR(100),
    InternetService VARCHAR(100),
    OnlineSecurity VARCHAR(100),
    OnlineBackup VARCHAR(100),
    DeviceProtection VARCHAR(100),
    TechSupport VARCHAR(100),
    StreamingTV VARCHAR(100),
    StreamingMovies VARCHAR(100),
    Contract VARCHAR(100),
    PaperlessBilling VARCHAR(100),
    PaymentMethod VARCHAR(100),
    MonthlyCharges VARCHAR(100),
    TotalCharges VARCHAR(100),
    Churn VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/telecom.csv'
INTO TABLE telecom
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from telecom;

select customerID ,count(*) as occurnace from telecom 
group by customerid 
having count(*) > 1;


select 
    sum( case when customerID is null then 1 else 0 end ) as customer_null,
    sum( case when gender is null then 1 else 0 end ) as gender_null,
    sum( case when seniorCitizen is null then 1 else 0 end ) as senior_null,
    sum( case when partner is null then 1 else 0 end ) as partner_null,
    sum( case when dependents is null then 1 else 0 end ) as depednent_null,
    sum( case when tenure is null then 1 else 0 end ) as tenure_null,
    sum( case when Phoneservice is null then 1 else 0 end ) as phoneservieces_null,
    sum( case when MultipleLines is null then 1 else 0 end ) as multiple_null,
    sum( case when InternetService is null then 1 else 0 end ) as internet_null,
    sum( case when OnlineSecurity is null then 1 else 0 end ) as onlinesecurity_null,
    sum( case when OnlineBackup is null then 1 else 0 end ) as onlinebackup_null,
    sum( case when DeviceProtection is null then 1 else 0 end ) as cdeviceproyection_null,
    sum( case when StreamingTV is null then 1 else 0 end ) as streamingtv_null,
    sum( case when TechSupport is null then 1 else 0 end ) as techsupport_null,
    sum( case when StreamingMovies is null then 1 else 0 end ) as streaminghouts_null,
    sum( case when Contract is null then 1 else 0 end ) as contract_null,
    sum( case when PaperlessBilling is null then 1 else 0 end ) as papaerlessblingh_null,
    sum( case when PaymentMethod is null then 1 else 0 end ) as paymentmethod_null,
	sum( case when MonthlyCharges is null then 1 else 0 end ) as monthly_null,
    sum( case when TotalCharges is null then 1 else 0 end ) as totalcharges_null,
    sum( case when Churn is null then 1 else 0 end ) as churn_nulls
    from telecom;
	
    select distinct(PaymentMethod) from telecom;
-- Busiesss  Question 
-- Which high-value customer segments are at highest risk of churning,and what is the revenue impact if the telecom company fails to retain them?"
    
-- 1) Which high charge,long-term customer churn most ?
SELECT COUNT(*) AS HighValueChurnCount,
       SUM(CAST(MonthlyCharges AS DECIMAL(10,2))) AS HighValueRevenueLoss
FROM telecom
WHERE CAST(MonthlyCharges AS DECIMAL(10,2)) > 75
  AND tenure > 35
  AND Churn = 'Yes';

-- 2) Which Contract + Payemnt types Drive churn  ?
SELECT contract,PaymentMethod, 
	(count(case when churn = 'yes' then 1 end) *100 /count(*)) as churn_rate
    from telecom 
group by contract , PaymentMethod;

-- 3) Do add-on Services reduces the churn ?
SELECT  HasAddOn ,
	(count(CASE WHEN churn = 'yes' THEN 1 END) *100 /count(*)) AS churn_rate 
FROM ( 
		SELECT *,
			CASE
				WHEN OnlineSecurity='Yes' 
				OR TechSupport='Yes' 
				OR DeviceProtection='Yes' THEN 1 ELSE 0 END AS HasAddOn
	from telecom) 
		t 
		Group by HasAddOn;

-- 4) How much revenue is lost when high value customer hurn vs low value ?
SELECT 
    CASE 
      WHEN MonthlyCharges > 75 OR tenure > 35 THEN 'HighValue'
      ELSE 'LowValue'
    END AS CustomerSegment,
    COUNT(*) AS CustomerCount,
    SUM(TotalCharges) AS RevenueLoss
FROM telecom
WHERE Churn = 'Yes'
GROUP BY CustomerSegment;

 
