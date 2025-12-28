# Brain-Tumor-Healthcare-Research-Analytics-Queries-Using-Advanced-SQL
This project applies advanced SQL analytics to a healthcare case study on brain tumour diagnosis, treatment, and research outcomes. Using simulated real-world clinical data, it leverages relational models, complex joins, and window functions to generate insights, suitable for interviews and GitHub portfolios.
Brain Tumour Healthcare & Research Analytics
# 1. Project Title
Brain Tumour Healthcare & Research Analytics using Advanced SQL
# 2. Project Description
This project demonstrates the application of advanced SQL-based data analysis in the healthcare domain, with a focused case study on brain tumour diagnosis, treatment, and clinical research outcomes. The dataset simulates real-world clinical data commonly used in neuro-oncology research and hospital analytics.
The primary aim is to extract meaningful insights from structured medical data using relational database concepts, complex joins, and window functions. The project is designed to be presented in technical interviews and showcased on GitHub as a complete data analytics case study.
# 3. Problem Statement
Brain tumour management involves integrating multiple data sources such as patient demographics, imaging findings, molecular biomarkers, treatment protocols, and survival outcomes. Traditional reporting methods are insufficient to capture complex trends across these dimensions.
This project addresses the need for structured data analysis by using SQL to:
•	Analyze survival outcomes across tumor types
•	Compare treatment effectiveness
•	Evaluate the impact of imaging and genomic biomarkers
•	Assess clinical trial participation and research outcomes
# 4. Dataset Overview
The dataset consists of five interrelated CSV files representing different aspects of brain tumour healthcare:
•	Patients: Demographics, tumor type, diagnosis date, hospital, country
•	Imaging: MRI-based tumor volume, radiomic score, contrast enhancement
•	Genomics: MGMT, EGFR, IDH status, TMB, immune biomarker score
•	Treatments: Treatment type, response, survival duration
•	Clinical Trials: Trial enrollment, phase, and outcomes
Each table contains 1000 records, enabling realistic analytical scenarios.
# 5. Database Schema
•	Patients (PK: patient_id)
o	One-to-Many → Imaging
o	One-to-One → Genomics
o	One-to-Many → Treatments
o	One-to-Many → Clinical_Trials
All tables are linked using patient_id as the foreign key.
# 6. Analytical Objectives
The project focuses on the following analytical tasks:
•	Ranking patients by survival within tumor types
•	Identifying top-performing treatments
•	Segmenting patients into risk groups
•	Comparing trial-enrolled vs non-enrolled patient outcomes
•	Hospital-level and population-level performance analysis
# 7. SQL Concepts Demonstrated
•	Multi-table JOINs
•	Window functions: RANK(), DENSE_RANK(), ROW_NUMBER(), NTILE()
•	GROUP BY vs PARTITION BY
•	Aggregate functions with ordering
•	Creation and management of database VIEWS
SQL Queries and Analysis: include here 5-6 queries and link for the complete query script
Execution and Output: include here the query output snapshots
📌 **Complete SQL Query Script:**  
👉 **[Query_Mini_Project.sql](Query_Mini_Project.sql)**
# Query 1 - Output Screenshot
![Query Output - 1](/Images/Output_1.jpg)
# Query 2 - Output Screenshot
![Query Output - 2](/Images/Output_2.jpg)
# Query 3 - Output Screenshot
![Query Output - 3](/Images/Output_3.jpg)
# Query 4 - Output Screenshot
![Query Output - 4](/Images/Output_4.jpg)
# Query 5 - Output Screenshot
![Query Output - 5](/Images/Output_5.jpg)

# 8. Key Insights Derived from Analysis
The following insights can be derived by applying advanced SQL queries, joins, and window functions on the dataset:
•	Tumor-wise Survival Patterns: Glioblastoma (GBM) patients exhibit significantly lower survival durations compared to low-grade tumors such as meningioma and pituitary tumors, highlighting the aggressive nature of GBM.
•	Treatment Effectiveness: Patients receiving combined or targeted therapies show improved average survival when compared to single-modality treatments such as chemotherapy alone.
•	Biomarker Impact: Higher immune biomarker scores and favorable genomic markers (such as MGMT methylation and IDH mutation) are associated with better survival outcomes, supporting precision-medicine approaches.
•	Imaging-Based Prognosis: Patients with lower tumor volume and higher radiomic scores tend to have better clinical outcomes, indicating the prognostic value of advanced imaging features.
•	Clinical Trial Participation: Trial-enrolled patients demonstrate measurable differences in survival trends, emphasizing the importance of research-driven treatment strategies.
•	Hospital-Level Variations: Survival outcomes and treatment distributions vary across hospitals, enabling institutional performance and care-pattern analysis.
These insights demonstrate how structured healthcare data can be transformed into meaningful clinical and research knowledge using SQL-based analytics.
# 9. Technology Stack
•	Database: MySQL
•	Language: SQL (Advanced SQL)
•	Data Format: CSV
•	Tools: MySQL Workbench
•	Version Control: Git & GitHub
•	Domain: Healthcare & Biomedical Analytics

# 10. Project Usage
This project can be used for:
•	Technical interviews (SQL & data analytics)
•	Academic evaluation and lab assessments
•	Healthcare analytics demonstrations
•	GitHub portfolio presentation
# 11. How to Run the Project
Include here schema creation, database import, and query execution
# 12. Disclaimer
This dataset is synthetically generated for educational and demonstration purposes only. It does not contain real patient data.
