-------healthcare project

create table healthcare
(
 Name varchar(40),
 Age  integer,
 Gender varchar(20),
 BloodType varchar(4),
 Medical_Condition varchar(30),
 Date_of_admission date,
 Doctor varchar(40),
 Hospital	varchar(55),
 Insurance_Provider varchar(30),
 Billing_Amount numeric(20,15),
 Room_number integer,
 Admission_type	varchar(20),
 Discharge_Date	date,
 Medication	 varchar(30),
 Test_Results varchar(30)

);

1. List all patients with their details.

select name,age,gender,medical_condition
from healthcare
order by name;



2. Find all diabetic patients.

select name,medical_condition
from healthcare
where medical_condition = 'Diabetes';



3. How many female and male patients are there?

select gender, count(gender) as patients_count
from healthcare
group by gender;



4. Find all patients whose bloodtype A+,B+,O+.

select name,bloodtype 
from healthcare
where bloodtype in ('A+', 'B+','O+');



5. which medical conditions appear most frequently?

select medical_condition, count(medical_condition) as cases
from healthcare 
group by medical_condition
order by cases desc;



6. which blood_type is most common?

select bloodtype, count(bloodtype) 
from healthcare 
group by  bloodtype
order by bloodtype desc;



7.which patients are assigned to  doctors  which name contains 'kevin'?

select name,medical_condition,doctor
from healthcare 
where doctor ilike  '%kevin%';



8. which top 3 hospital has most patients?

select hospital, count(hospital) as patient_count
from healthcare 
group by hospital
order by patient_count  desc limit 3;



9. How much do patients pay on average?

select round(avg(billing_amount),2) as avg_bill
from healthcare;


10. what are the different results?

select medical_condition,test_results, count(*) as abnormal_cases
from healthcare
where test_results = 'Abnormal'
group by medical_condition,test_results
order by abnormal_cases desc;


11. which medication are prescribed most?

select medication, count(medication) as prescriptions_records
from healthcare
group by medication
order by prescriptions_records desc limit 5;


12. which patients admitted between january 1,2023 and december 31,2023?

select name, date_of_admission 
from healthcare 
where date_of_admission between '2023-01-01' and '2023-12-31'
order by date_of_admission;


13. How many patients are in each room?

select room_number,count(name) as patients_count
from healthcare
group by room_number
having count(name) > 150;



14. what the highest billing amount for each medical condition?

select medical_condition,max(billing_amount) as maximum_amount
from healthcare 
group by medical_condition;



15.How many patients have each medical condition records at every age?

select age,medical_condition, count(medical_condition) as cases_records
from healthcare
group by age,medical_condition
order by age;



16. Group insurance providers into goverment and private categories.

select insurance_provider,
case
    when insurance_provider in ('Medicare','Medicaid') then 'Goverment'
	when insurance_provider in ('Blue Cross', 'Aetna') then 'private'
	else 'other'
  end as insurance_category 
  from healthcare;
  


17. Patients records based on admission_type.

select name,admission_type,
case 
    when admission_type = 'Emergency' then 'critical_condition'
	when admission_type = 'Urgent' then 'serious_condition'
	when admission_type = 'Elective' then 'normal_condition'
	end as cases_conditions
	from healthcare;

	


18. Patients with the Earliest admission date for each medical condition.

select name, medical_condition,date_of_admission,
min(date_of_admission) over (partition by medical_condition) as earliest_records
from healthcare;



19.Total revenue of each hospital. 

select name,medical_condition,hospital,
sum(billing_amount) over(partition by hospital) as total_revenue
from healthcare;



20. How many patients have critical medical condition like cancer or diabetes?

with new_table
as
(
select
*,
case 
when
    medical_condition like '%Cancer%' or
	medical_condition like '%diabetes%' then 'most_critical_condition'
	else 'less_critical'
	end as condition_severity
	from healthcare 
	)
	select 
	    condition_severity,
		count(*) as patients_count
		from new_table 
		group by condition_severity;










	
	
	















