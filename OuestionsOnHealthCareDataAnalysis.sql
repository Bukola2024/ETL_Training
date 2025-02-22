-- DATA ANALYSIS USING SQL ON healthcare_dataset DATABASE
-- This Database is not based on real facts, please don't consider the result sets to be actual and utilize it for any function.

-- Creating Database called healthcare_dataset.
-- Create Database healthcare_dataset;
-- Selecting healthcare_dataset Database To Query.

Use EmadeDev

-- Veiwing Data on Database

Select *
From [dbo].[healthcare_dataset]

-- Describing characteristics of Table.
-- DESC healthcare_dataset

-- 1.  Counting Total Record in Database

Select COUNT(*)
From [dbo].[healthcare_dataset]

-- 2. Finding maximum age of patient admitted.

Select MAX(Age) as Maximum_Age
From [dbo].[healthcare_dataset]

-- 3. Finding Average age of hospitalized patients.

1. Select round(AVG(Age),0) as Average_Age 
From [dbo].[healthcare_dataset]

2. Select AVG(Age) as Average_Age 
From [dbo].[healthcare_dataset]

-- 4. Calculating Patients Hospitalized Age-wise from Maximum to Minimum

Select Age, COUNT(Age) as Total
From [dbo].[healthcare_dataset]
GROUP BY Age
ORDER BY Age DESC

-- 5. Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.

Select Age, COUNT(Age) as Total
From [dbo].[healthcare_dataset]
GROUP BY Age
ORDER BY Total DESC, Age DESC

-- 6. Ranking Age on the number of patients Hospitalized

Select Age, COUNT(Age) as Total, 
DENSE_RANK() OVER(ORDER BY COUNT(Age) DESC, age DESC) as RankingPatientsHospitalized
From [dbo].[healthcare_dataset]
GROUP BY Age HAVING COUNT(Age) > AVG(Age)

--7. Finding Count of Medical Condition of patients and lisitng it by maximum no of patients.
 -- Findings : This query retrieves a breakdown of medical conditions recorded in a healthcare dataset along with the total number of patients diagnosed with each condition. 
 --It groups the data by distinct medical conditions, counting the occurrences of each condition across the dataset. 
 --The result is presented in descending order based on the total number of patients affected by each medical condition, providing an insight into the prevalence or frequency of various health issues within the dataset
 
 Select Medical_Condition, COUNT(Medical_Condition) as Total
From [dbo].[healthcare_dataset]
GROUP BY Medical_Condition
ORDER BY Total DESC, Medical_Condition DESC

 -- 8. Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.
-- Finding : The output provides insight into the most common medications used for various medical conditions, assigning a rank to each medication based on how frequently its prescribed within its corresponding condition.

 --Select Medication, Medical_Condition, COUNT(Medical_Condition) as TotalNumberofMedicine,
 --Rank() over (Partition By Medical_Condition ORDER BY COUNT(Medical_Condition) DESC) as RankNumberofMedicine
--From [dbo].[healthcare_dataset]
--GROUP BY Medical_Condition
--ORDER BY TotalNumberofMedicine, Medical_Condition DESC

Select Medical_Condition, Medication, --COUNT(Medication) as TotalNumberofMedicine
 Rank() over (Partition By Medication ORDER BY Medical_Condition DESC) as RankNumberofMedicine
From [dbo].[healthcare_dataset]
--GROUP BY Medical_Condition,Medication
--ORDER BY TotalNumberofMedicine, Medical_Condition DESC

 Select Medication, Medical_Condition, COUNT(Medication) as TotalMedication,
 Rank() over (Partition By Medical_Condition ORDER BY COUNT(Medication) DESC) as RankNumberofMedicine
From [dbo].[healthcare_dataset]
GROUP BY Medication, Medical_Condition
--ORDER BY TotalNumberofMedicine, Medical_Condition DESC


-- 9. Most preffered Insurance Provider by Patients Hospatilized DESC;
	-- Findings : This information helps identify the most prevalent insurance providers among the patient population, offering valuable data for resource allocation, understanding coverage preferences, and potentially indicating trends in healthcare accessibility based on insurance networks

Select Insurance_Provider, COUNT(Insurance_Provider) as TotalPatientsHospatilized
From [dbo].[healthcare_dataset]
GROUP BY Insurance_Provider
ORDER BY 2 DESC

-- 10. Finding out most preffered Hospital
--Findings : It provides insight into which hospitals have the highest frequency of records within the healthcare dataset. The resulting list showcases hospitals based on their patient count or the number of entries related to each hospital, allowing for an understanding of the distribution or prominence of healthcare services among different medical facilities.

Select Hospital, COUNT(Hospital) as Total
From [dbo].[healthcare_dataset]
GROUP BY Hospital
ORDER BY 2 DESC

--11. Identifying Average Billing Amount by Medical Condition.
	-- Findings :  It offers insights into the typical costs associated with various medical conditions. This information can be valuable for analyzing the financial impact of different health issues, identifying expensive conditions, or assisting in resource allocation within healthcare facilities.
 
Select Medical_Condition, AVG(Billing_Amount) as Billing_Amount 
From [dbo].[healthcare_dataset]
GROUP BY Medical_Condition
ORDER BY Billing_Amount DESC

-- 12. Finding Billing Amount of patients admitted and number of days spent in respective hospital.
 
--Select Billing_Amount, COUNT(Billing_Amount) as TotalNumberofDays
--From [dbo].[healthcare_dataset]
--GROUP BY Billing_Amount
--ORDER BY TotalNumberofDays DESC, Billing_Amount DESC

SELECT  Name, Hospital,
    DATEDIFF(D, Date_of_Admission, discharge_date) AS total_days_spent
From [dbo].[healthcare_dataset]


-- 13. Finding Total number of days spent by patient in an hospital for given medical condition
        -- Findings : This query retrieves a dataset showing the names of patients, their respective medical conditions, billed amounts (rounded to two decimal places), the hospitals they visited, and the duration of their hospital stay in days. Insights gleaned include: 
		-- Individual Patient Details: It presents a comprehensive view of patients, their medical conditions, billed amounts, and hospitals involved, aiding in understanding the scope of medical services availed by patients.
		-- Financial Overview: The rounded billing amounts provide an overview of the costs incurred by patients for their treatments, assisting in analyzing the financial aspect of healthcare services.
		-- Hospital Performance: By knowing the length of hospital stays, an evaluation of the efficiency of hospitals in managing patient care and treatment duration is possible.
		-- Potential Patterns: Patterns in medical conditions, billed amounts, and duration of hospitalization may emerge, offering insights into prevalent health issues and associated costs in the healthcare dataset.

		SELECT  Name, Medical_Condition, Hospital,
    DATEDIFF(D, Date_of_Admission,discharge_date) AS total_days_spent
FROM [dbo].[healthcare_dataset]   
--WHERE medical_condition = 'YourCondition'
--GROUP BY Name, medical_condition

-- 14. Finding Hospitals which were successful in discharging patients after having test results as 'Normal' with count of days taken to get results to Normal

SELECT Hospital, Medical_Condition, Test_Results,
    SUM(DATEDIFF(D, Date_of_Admission, discharge_date)) AS total_days_spent
From [dbo].[healthcare_dataset]
GROUP BY Hospital, Medical_Condition, Test_Results
HAVING Test_Results = 'Normal'
Order by 4 ASC


-- 15. Calculate number of blood types of patients which lies between age 20 to 45 DESC;
	-- Findings: This query filters healthcare data for individuals aged between 20 and 45, grouping them by their age and blood type. It then counts the occurrences of each blood type within this age range. The output provides a breakdown of blood type distribution among individuals aged 20 to 45, revealing the prevalence of different blood types within this specific age bracket. The results may offer insights into any potential correlations between age groups and blood type occurrences within the dataset.
    
	Select Age, Blood_Type, Count(*) AS NumberofPatientwithBlood_Type
	From [dbo].[healthcare_dataset]
	Group By Age, Blood_Type
	Having Age between 20 and 45
	ORDER BY AGE ASC

-- 16. Find how many of patient are Universal Blood Donor and Universal Blood reciever

SELECT Blood_Type, COUNT(*) AS Universal_DonorsandReceiver
From [dbo].[healthcare_dataset]
Group by Blood_Type
HAVING Blood_Type in ('O-', 'O+', 'AB-', 'AB+')

