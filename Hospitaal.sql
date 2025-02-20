use hospital_management;
select * from admissions;
select * from doctors;
select * from patients;
select * from province_names;

--   QUERIES FOR DATA ANALYSING --
-- 1. Show first name, last name, and gender of patients whose gender is 'M';
       select first_name, last_name, gender from patients where gender = 'M';
	
-- 2. Show first name and last name of patients who does not have allergies. (null)
       select first_name, last_name from patients where allergies is NULL;
       
-- 3. Show first name of patients that start with the letter 'C'
       SELECT first_name FROM patients WHERE first_name LIKE 'C%';
       
-- 4. Show first name and last name of patients that weight within the range of 100 to 120 
	   select first_name, last_name weight from patients where weight between 100 and 120;
       
-- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA';
       update  patients set allergies = 'NKA' where allergies is NULL;
       
-- 6. Show first name and last name concatinated into one column to show their full name.
       select concat(first_name,' ', last_name) as Patient_Name from patients;
       
-- 7. Show first name, last name, and the full province name of each patient.
        select a.first_name, a.last_name, b.province_name from 
             patients a join province_names b on a.province_id = b.province_id;
             
-- 8. Show the first_name, last_name, and height of the patient with the greatest height.
       select first_name, last_name , max(height) as Height from patients ;
       
-- 9. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000.
        select * from patients where patient_id in ('1', '45','34', '29','1000');
        
-- 10. Show the total number of admissions.
        select count( patient_id) from admissions;
        
-- 11. Show all the columns from admissions where the patient was admitted and discharged on the same day.
         select * from admissions where admission_date = discharge_date;
         
-- 12. Show the patient id and the total number of admissions for patient_id 579.
		select patient_id, count(patient_id) from admissions where patient_id = '34';
        
-- 13. Write a query to find the first_name, last name and birth date of patients 
         -- who has height greater than 160 and weight greater than 70.
         select first_name, last_name, birth_date, height, weight from patients where height > 160 and weight > 70;
         
-- 15. Show unique first names from the patients table which only occurs once in the list.
          -- For example, if two or more people are named 'John' in the first_name column then don't 
          -- include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
	   select first_name from patients group by first_name having count(first_name) = 1;
       
-- 16. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
        select patient_id, first_name from patients where first_name like '%s_%s';
        
-- 17. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
         select a.patient_id, a.first_name, a.last_name from patients a join admissions b 
               on a.patient_id = b.patient_id where diagnosis='Dementia';
-- 18. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
         select patient_id, diagnosis from admissions group by patient_id, diagnosis having count(*) > 1;
         
-- 19. Show the city and the total number of patients in the city.Order from most to least patients and then by city name ascending.
         select city, count(patient_id) as Total_Patients from patients group by city order by Total_Patients desc, city asc;  
         
-- 20. Show all allergies ordered by popularity. Remove NULL values from query.
         Select allergies, count(allergies) from patients where allergies is not null 
              group by allergies order by count(allergies) desc;   
              
--  21. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
           -- Sort the list starting from the earliest birth_date.
           select first_name, last_name, birth_date from patients where year(birth_date)  
                  between 1970 and 1979 order by (birth_date)  asc;
                  
-- 22. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first,
 --           then first_name in all lower case letters. Separate the last_name and first_name with a comma.
 --             Order the list by the first_name in decending order EX: SMITH,jane
 
         select  concat(upper(last_name),',', lower(first_name)) as new_name_format from patients order by first_name desc;
         
-- 23. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
        select a.province_id,sum(height) as Sum_Height from patients a join province_names b 
             on a.province_id = b.province_id group by a.province_id having sum_height >= 7000;
             
-- 24. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'.
         select (max(weight) - min(weight)) as Total_weight from patients where last_name = 'Maroni';
         
-- 25. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
          --  Sort by the day with most admissions to least admissions.
          select day(admission_date) as admission_dates, count(*) as Number_Of_Admissions
             from admissions group by day(admission_date) order by Number_Of_Admissions desc;

-- 26. Show all columns for patient_id 112's most recent admission_date.
		select * from admissions where patient_id = '112' group by admission_date order by admission_date desc limit  1;
            
-- 27. Show how many patients have a birth_date with 2010 as the birth year.
         select count(patient_id) from patients where year (birth_date) = '2010' group by year(birth_date);
        select count(patient_id) from patients where birth_date>='2000-01-01' and birth_date<='2000-12-31';
        
-- 28. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
         SELECT city,province_id FROM patients GROUP BY city having province_id = 'ON';
         
-- 29. Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). 
                     -- Show the result order in ascending by city.
	    select distinct city from patients where
                               city like 'a%'
                              or city like 'e%'
							  or city like 'i%'
                              or city like 'o%'
                              or city like 'u%'
                                order by city;
                                
-- 30. Show unique birth years from patients and order them by ascending.
         select distinct year (birth_date) as Birth_Year from patients  group by Birth_Year order by  Birth_Year asc;
           
-- 31. Display every patient's first_name. Order the list by the length of each name and then by alphbetically. 
        SELECT first_name FROM patients order by LENGTH(first_name), first_name;
        
-- 32. Show the total amount of male patients and the total amount of female patients in the patients table.
          -- Display the two results in the same row.
          SELECT 
      (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
      (SELECT count(*) FROM patients WHERE gender='F') AS female_count;
  
  -- 33. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
          -- Show results ordered ascending by allergies then by first_name then by last_name.
          
          SELECT first_name, last_name,allergies FROM patients WHERE allergies IN ('Penicillin', 'Morphine')
                   ORDER BY allergies, first_name, last_name;
                   
-- 34. Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor".
     SELECT first_name, last_name, 'Patient' as role FROM patients
           union all
	select first_name, last_name, 'Doctor' from doctors;
    
-- 35. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
          -- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
          -- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
          
          SELECT patient_id, attending_doctor_id, diagnosis FROM admissions WHERE
                   (
                        attending_doctor_id IN (1, 5, 19)
                        AND patient_id % 2 != 0
                   )
                         OR 
				   (
                        attending_doctor_id LIKE '%2%'
                        AND length(patient_id) = 3
                   );
                    
-- 36. Show first_name, last_name, and the total number of admissions attended for each doctor.
             -- Every admission has been attended by a doctor.
        SELECT first_name, last_name, count(*) as admissions_total from admissions a
                  join doctors ph on ph.doctor_id = a.doctor_id group by doctor_id ;
                  
-- 37.  For each doctor, display their id, full name, and the first and last admission date they attended.
          
                  
-- 38. Display the total amount of patients for each province. Order by descending.
          SELECT province_name,COUNT(*) as patient_count FROM patients pa
                           join province_names pr on pr.province_id = pa.province_id
                                 group by pr.province_id order by patient_count desc;
								
-- 39. For every admission, display the patient's full name, 
                        -- their admission diagnosis, and their doctor's full name who diagnosed their problem.
       SELECT CONCAT(patients.first_name, ' ', patients.last_name) as patient_name, diagnosis,
              CONCAT(doctors.first_name,' ',doctors.last_name) as doctor_name FROM patients
                   JOIN admissions ON admissions.patient_id = patients.patient_id
				   JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id;
                   
-- 40. display the number of duplicate patients based on their first_name and last_name.

       select first_name, last_name, count(*) as num_of_duplicates from patients group by
                     first_name, last_name having count(*) > 1;
                     
-- 41. Display patient's full name, height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals,
--         birth_date, gender non abbreviated.Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205.

            select
                    concat(first_name, ' ', last_name) AS 'patient_name', 
                    ROUND(height / 30.48, 1) as 'height "Feet"', 
                    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
                     CASE
	                  WHEN gender = 'M' THEN 'MALE' 
				      ELSE 'FEMALE' 
					  END 
                       AS 'gender_type'
                      from patients;
                      
-- 42. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
               -- (Their patient_id does not exist in any admissions.patient_id rows.)
         SELECT patients.patient_id, first_name, last_name from patients
                where patients.patient_id not in (
                       select admissions.patient_id
                         from admissions
                               );
                               
-- 43. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group.Order the list by the
-- weight group decending.For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

           SELECT COUNT(*) AS patients_in_group, FLOOR(weight / 10) * 10 AS weight_group FROM patients
            GROUP BY weight_group ORDER BY weight_group DESC;
            
-- 44. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. 
   -- Obese is defined as weight(kg)/(height(m)2) >= 30. weight is in units kg. height is in units cm.
      
      SELECT patient_id, weight, height, 
            (CASE 
                  WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
                       1
                       ELSE
                    0
                 END) AS isObese
                FROM patients;
                
-- 45. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 
     -- 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
               
                SELECT p.patient_id, p.first_name AS patient_first_name,
  p.last_name AS patient_last_name,
  ph.specialty AS attending_doctor_specialty
FROM patients p
  JOIN admissions a ON a.patient_id = p.patient_id
  JOIN doctors ph ON ph.doctor_id = a.attending_doctor_id
WHERE
  ph.first_name = 'Lisa' and
  a.diagnosis = 'Epilepsy';
  
  -- 46. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a 
 -- temporary password after their first admission. Show the patient_id and temp_password. The password must be the following, in order:
                                      --   1. patient_id
                                      --   2. the numerical length of patient's last_name
                                      --   3. year of patient's birth_date

             SELECT DISTINCT P.patient_id, CONCAT(  P.patient_id, LEN(last_name),  YEAR(birth_date) ) AS temp_password
                     FROM patients P JOIN admissions A ON A.patient_id = P.patient_id;
                     
-- 47. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. 
            -- All patients with an even patient_id have insurance.

	    -- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance.
	    -- Add up the admission_total cost for each has_insurance group.
             SELECT 
                    CASE WHEN patient_id % 2 = 0 Then 
                        'Yes'
                    ELSE 
				        'No' 
                    END as has_insurance,
                    SUM(CASE WHEN patient_id % 2 = 0 Then 
                   10
                    ELSE 
                     50 
                  END) as cost_after_insurance
                  FROM admissions 
                   GROUP BY has_insurance;
                   
-- 48. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

             SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);
  
  -- 49. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
--            First_name contains an 'r' after the first two letters.
--            Identifies their gender as 'F'
--            Born in February, May, or December
--            Their weight would be between 60kg and 80kg
--            Their patient_id is an odd number
--            They are from the city 'Kingston

              SELECT * FROM patients WHERE
                  first_name LIKE '__r%'
                   AND gender = 'F'
                    AND MONTH(birth_date) IN (2, 5, 12)
                     AND weight BETWEEN 60 AND 80
                      AND patient_id % 2 = 1
                       AND city = 'Kingston';

-- 50. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
            select province_name from province_names order by
                     (case when province_name = 'Ontario' then 0 else 1 end), province_name;
                     
-- 51. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
          SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE gender = 'M'
      ) / CAST(COUNT(*) as FLOAT),
      4
    ) * 100,
    '%'
  ) as percent_of_male_patients
FROM patients;

-- 52. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
          SELECT
 admission_date,
 count(admission_date) as admission_day,
 count(admission_date) - LAG(count(admission_date)) OVER (ORDER BY admission_date) AS admission_count_change 
FROM admissions
 group by admission_date;
 
 
 -- 53. We need a breakdown for the total amount of admissions each doctor has started each year. 
       -- Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
SELECT d.doctor_id as doctor_id, CONCAT(d.first_name,' ', d.last_name) as doctor_name, d.specialty, 
YEAR(a.admission_date) as selected_year,
  COUNT(*) as total_admissions
FROM doctors as d
  LEFT JOIN admissions as a ON d.doctor_id = a.attending_doctor_id
GROUP BY
  doctor_name,
  selected_year
ORDER BY doctor_id, selected_year;