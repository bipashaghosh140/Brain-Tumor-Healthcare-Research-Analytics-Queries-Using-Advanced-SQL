🧠 Brain Tumour Healthcare & Research Analytics Using Advanced SQL
📌 Project Overview

This project applies advanced SQL analytics to a healthcare case study focused on brain tumour diagnosis, treatment, and clinical research outcomes. Using synthetically generated real-world clinical data, it demonstrates how structured healthcare data can be analyzed using relational models, complex joins, and window functions.

This project is ideal for:

🎯 Technical interviews

🎓 Academic evaluations

💼 GitHub portfolio presentation

1️⃣ Project Title

Brain Tumour Healthcare & Research Analytics using Advanced SQL

2️⃣ Project Description

This project showcases the application of advanced SQL-based data analysis in the healthcare domain, with a focus on neuro-oncology analytics.

The dataset simulates realistic hospital and research data commonly used in:

Clinical outcome analysis

Treatment effectiveness studies

Biomarker-driven research

The primary goal is to extract meaningful insights from structured medical data using:

Relational database design

Multi-table joins

Window functions and analytical queries

3️⃣ Problem Statement

Brain tumour management involves integrating multiple data sources such as:

Patient demographics

Imaging findings

Genomic and molecular biomarkers

Treatment protocols

Survival and clinical trial outcomes

Traditional reporting methods fail to capture complex relationships across these dimensions.

This project addresses these challenges using SQL to:

Analyze survival outcomes across tumour types

Compare treatment effectiveness

Evaluate imaging and genomic biomarkers

Assess the impact of clinical trial participation

4️⃣ Dataset Overview

The dataset consists of five interrelated CSV files, each representing a core component of brain tumour healthcare data.

Table Name	Description
Patients	Demographics, tumour type, diagnosis date, hospital, country
Imaging	MRI tumour volume, radiomic score, contrast enhancement
Genomics	MGMT, EGFR, IDH status, TMB, immune biomarker score
Treatments	Treatment type, response, survival duration
Clinical_Trials	Trial enrollment status, phase, and outcomes

📊 Each table contains 1000 records, enabling realistic analytical scenarios.

5️⃣ Database Schema

Primary Key: patient_id

Relationships:

Patients → Imaging (One-to-Many)

Patients → Genomics (One-to-One)

Patients → Treatments (One-to-Many)

Patients → Clinical_Trials (One-to-Many)

All tables are connected using patient_id as the foreign key.

6️⃣ Analytical Objectives

This project focuses on:

Ranking patients by survival within tumour types

Identifying top-performing treatments

Segmenting patients into risk categories

Comparing trial-enrolled vs non-enrolled patient outcomes

Hospital-level and population-level performance analysis

7️⃣ SQL Concepts Demonstrated

Multi-table JOINs

Window functions:

RANK()

DENSE_RANK()

ROW_NUMBER()

NTILE()

GROUP BY vs PARTITION BY

Aggregate functions with ordering

Creation and usage of database VIEWs

8️⃣ SQL Queries & Execution Results -
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

9️⃣ Key Insights Derived from Analysis

Applying advanced SQL analytics produced the following insights:

Tumour-wise Survival Patterns
Glioblastoma (GBM) patients show significantly lower survival compared to low-grade tumours such as meningioma and pituitary tumours.

Treatment Effectiveness
Combined and targeted therapies demonstrate higher average survival than single-modality treatments.

Biomarker Impact
Favorable genomic markers (MGMT methylation, IDH mutation) and higher immune biomarker scores are associated with improved survival.

Imaging-Based Prognosis
Lower tumour volume and higher radiomic scores correlate with better clinical outcomes.

Clinical Trial Participation
Trial-enrolled patients exhibit distinct survival trends, highlighting the value of research-driven care.

Hospital-Level Variations
Survival outcomes and treatment patterns vary across hospitals, enabling institutional performance analysis.

🔧 Technology Stack

Database: MySQL

Language: SQL (Advanced SQL)

Data Format: CSV

Tools: MySQL Workbench

Version Control: Git & GitHub

Domain: Healthcare & Biomedical Analytics

🔄 Project Usage

This project can be used for:

SQL & data analytics technical interviews

Academic lab assessments

Healthcare analytics demonstrations

GitHub portfolio showcasing

▶️ How to Run the Project

Create the database schema in MySQL

Import all CSV files into corresponding tables

Execute queries from Query_Mini_Project.sql

Review query outputs and insights

⚠️ Disclaimer

This dataset is synthetically generated for educational and demonstration purposes only.
It does not contain real patient data.
