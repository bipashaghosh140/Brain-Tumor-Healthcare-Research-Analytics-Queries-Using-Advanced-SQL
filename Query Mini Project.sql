use mini_project;
show tables;
select * from brain_tumor_genomics;
select * from brain_tumor_imaging;
select * from brain_tumor_patients;
select * from brain_tumor_treatments;
select * from brain_tumor_trials;
-- Database link
-- brain_tumor_patients (main) - patient_id
-- brain_tumor_genomics - PK: specimen_id, FK: patient_id
-- brain_tumor_imaging - PK: study_id, FK: patient_id
-- brain_tumor_treatments - PK: treatment_id, FK: patient_id
-- brain_tumor_trials - PK: trial_record_id, FK: patient_id

-- Section A – Window Functions with Healthcare Insights
-- Q1.For each tumor type, rank patients by survival_months in descending order.
--    Display patient_id, tumor_type, survival_months, and RANK().
SELECT patient_id, tumor_type, survival_months, rank_patient
from(
SELECT p.patient_id, p.tumor_type, t.survival_months, 
RANK() over(partition by p.tumor_type order by t.survival_months DESC) as rank_patient
from brain_tumor_patients p
join brain_tumor_treatments t 
on p.patient_id = t.patient_id
) t;


-- Q2. Identify the top 3 patients per tumor type based on survival using DENSE_RANK().
select patient_id, tumor_type, survival_months
from(
select p.patient_id, p.tumor_type, t.survival_months,
DENSE_RANK() over (partition by p.tumor_type order by t.survival_months) as dense_rank_patient
from brain_tumor_patients p
join brain_tumor_treatments t 
on p.patient_id = t.patient_id
) temp
where dense_rank_patient <= 3;

-- Q3. For each hospital, assign a sequential number to patients based on diagnosis_date using ROW_NUMBER().
select hospital, diagnosis_date,
ROW_NUMBER() over (partition by hospital order by diagnosis_date) as sequential_number
from brain_tumor_patients;

-- Q4. Divide patients into quartiles (NTILE 4) based on radiomic_score and show which quartile each patient falls into.
select patient_id, radiomic_score,
NTILE(4) over (order by radiomic_score desc) as quartiles
from brain_tumor_imaging;

-- Q5. Compute the average survival_months per tumor type, but also show each patient’s survival alongside that average using AVG() OVER (PARTITION BY ...).
select patient_id, tumor_type, survival_months, average_survival_months
from(
select p.patient_id, p.tumor_type, t.survival_months,
avg(survival_months) over (partition by tumor_type) as average_survival_months
from brain_tumor_patients p
join brain_tumor_treatments t 
on p.patient_id = t.patient_id
) temp;

-- Section B – GROUP BY vs PARTITION BY (Clear Contrast)
-- Q6. Using GROUP BY, calculate the average tumor volume per tumor type.
--     Then rewrite the query using AVG() OVER (PARTITION BY tumor_type) to retain patient-level rows.
-- Using Group By clause
select p.tumor_type, 
AVG(i.tumor_volume_cc) as avg_tumor_volume
from brain_tumor_patients p
join brain_tumor_imaging i
on p.patient_id = i.patient_id
group by p.tumor_type;

-- Using Partition By clause
select tumor_type, tumor_volume, avg_tumor_volume
from(
select p.tumor_type, i.tumor_volume_cc as tumor_volume,
AVG(i.tumor_volume_cc) over (partition by p.tumor_type) as avg_tumor_volume
from brain_tumor_patients p
join brain_tumor_imaging i
on p.patient_id = i.patient_id
) temp;

-- Q7.For each patient, display:
-- o tumor_type
-- o survival_months
-- o maximum survival within the same tumor type (using window function)
select tumor_type, survival_months, max_survival_months
from(
select p.tumor_type, t.survival_months,
MAX(t.survival_months) over (partition by p.tumor_type) as max_survival_months
from brain_tumor_patients p
join brain_tumor_treatments t
on p.patient_id = t.patient_id
) temp;

-- Q8.Show the total number of patients per hospital using GROUP BY, and alongside each row show the overall patient count using COUNT() OVER().
-- Using Group By clause
select hospital, COUNT(*) as total_patient
from brain_tumor_patients
group by hospital;

-- Section C – JOINs + Window Functions (Core Analytical Skills)
-- Using Partition By clause
select * ,
COUNT(*) over (partition by hospital) as hospital_total_patient
from brain_tumor_patients;

-- Q9.Join patients, treatments, and genomics tables.
-- Rank patients within each tumor type by immune_biomarker_score.
select patient_id, tumor_type, immune_biomarker_score, rank_patient
from(
select t.patient_id, p.tumor_type, g.immune_biomarker_score,
RANK() over (partition by p.tumor_type order by g.immune_biomarker_score) as rank_patient
from brain_tumor_patients p
join brain_tumor_treatments t
on p.patient_id = t.patient_id
join brain_tumor_genomics g
on p.patient_id = g.patient_id
) temp;

-- Q10.	Join patients and imaging tables.
-- For each tumor type, calculate the average radiomic_score and show each patient’s deviation from it.
SELECT
    p.tumor_type,
    i.radiomic_score,
    AVG(i.radiomic_score) OVER (PARTITION BY p.tumor_type) AS avg_radiomic_score,
    i.radiomic_score - AVG(i.radiomic_score) OVER (PARTITION BY p.tumor_type) AS deviation_score
FROM brain_tumor_patients p
JOIN brain_tumor_imaging i
ON p.patient_id = i.patient_id;

-- Q11.	Using patients + treatments, find the latest treatment per patient using ROW_NUMBER().
select 
patient_id, treatment_date, treatment_type, row_num
from(
select p.patient_id, t.treatment_type, t.end_date as treatment_date,
ROW_NUMBER() over (partition by p.patient_id order by t.end_date desc) as row_num
FROM brain_tumor_patients p
JOIN brain_tumor_treatments t
ON p.patient_id = t.patient_id
) temp
where row_num <= 1;

-- Q12.	Join patients + clinical_trials and rank patients by trial phase priority within each tumor type.
select patient_id, tumor_type, trial_phase,
DENSE_RANK() over (partition by p.tumor_type order by priority desc) as dense_rank_num
from(
select p.patient_id, p.tumor_type, c.trial_phase,
case
   when c.trial_phase = 'Phase IV' then 1
   when c.trial_phase = 'Phase III' then 2
   when c.trial_phase = 'Phase II' then 3
   when c.trial_phase = 'Phase I' then 4
   else 0
   end as priority
FROM brain_tumor_patients p
JOIN brain_tumor_trials c
ON p.patient_id = c.patient_id
) t;

-- Section D – Time-based & Research-oriented Analysis
-- Q13.	Using JOINs, calculate the cumulative survival_months per tumor type ordered by diagnosis_date.
select 
p.tumor_type, 
p.diagnosis_date,
SUM(t.survival_months) over (partition by p.tumor_type order by p.diagnosis_date) as cumulative_survival_months
from brain_tumor_patients p
join brain_tumor_treatments t 
on p.patient_id = t.patient_id;

-- Q14.	For each hospital, compute a running total of enrolled clinical trial patients over time.
select 
hospital,
SUM(exact_enrolled) over (partition by hospital order by enroll_date) as running_total_enroll
from(
select p.hospital, c.enroll_date,
case
   when c.enrolled = 'TRUE' then 1
   else 0
   end as exact_enrolled
from brain_tumor_patients p
join brain_tumor_trials c
on p.patient_id = c.patient_id
) temp;

-- Q15.	Compare average survival of patients enrolled in trials vs not enrolled, grouped by tumor type.
select p.tumor_type, 
avg(case when c.enrolled = 'TRUE' then t.survival_months end) as Avg_survival_trial,
avg(case when c.enrolled = 'FALSE' then t.survival_months end) as Avg_survival_non_trial
from brain_tumor_patients p
join brain_tumor_trials c on p.patient_id = c.patient_id
join brain_tumor_treatments t on p.patient_id = t.patient_id
group by p.tumor_type;

-- Section E – Views & Reusable Research Insights
-- Q16.	Create a VIEW showing only Glioblastoma (GBM) patients who received Immunotherapy or Targeted Therapy, including survival and biomarker details.
create view GBM_patient as
select 
p.tumor_type,
t.treatment_type,
t.survival_months,
g.immune_biomarker_score
from brain_tumor_patients p
join brain_tumor_treatments t on p.patient_id = t.patient_id
join brain_tumor_genomics g on p.patient_id = g.patient_id 
where p.tumor_type = 'Glioblastoma (GBM)' AND t.treatment_type in ('Immunotherapy', 'Targeted Therapy');
select * from GBM_patient;

-- Q17.	Replace the above VIEW to include radiomic_score and tumor volume from imaging data.
create or replace view GBM_patient as
select 
p.tumor_type,
t.treatment_type,
t.survival_months,
g.immune_biomarker_score,
i.tumor_volume_cc,
i.radiomic_score
from brain_tumor_patients p
join brain_tumor_treatments t on p.patient_id = t.patient_id
join brain_tumor_genomics g on p.patient_id = g.patient_id 
join brain_tumor_imaging i on p.patient_id = i.patient_id 
where p.tumor_type = 'Glioblastoma (GBM)' AND t.treatment_type in ('Immunotherapy', 'Targeted Therapy');
select * from GBM_patient;

-- Q18.	Drop the view once analysis is complete.
drop view GBM_patient;

-- Section F – Advanced Ranking & Decision Support
-- Q19.	For each tumor type, identify the best performing treatment based on average survival using RANK().
select
tumor_type,
treatment_type,
RANK() over (partition by tumor_type order by Avg_survival_month) as rank_treatment,
Avg_survival_month
from(
select 
p.tumor_type,
t.treatment_type, 
avg(t.survival_months) as Avg_survival_month
from brain_tumor_patients p
join brain_tumor_treatments t on p.patient_id = t.patient_id
group by p.tumor_type, t.treatment_type
) temp; 

-- Q20.	Using JOINs across patients, genomics, treatments, classify patients into High / Medium / Low survival risk groups using NTILE(3) based on survival_months.
select 
patient_id,
survival_months,
survival_risk,
bucket
from(
select 
patient_id,
survival_months,
bucket,
case
    when bucket = 1 then 'High'
    when bucket = 2 then 'Medium'
    when bucket = 3 then 'Low'
    end as survival_risk
from(
select 
p.patient_id,
t.survival_months,
NTILE(3) over (order by t.survival_months desc) as bucket
from brain_tumor_patients p
join brain_tumor_treatments t on p.patient_id = t.patient_id
join brain_tumor_genomics g on p.patient_id = g.patient_id
)t1
)t2;



