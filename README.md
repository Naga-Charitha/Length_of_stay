# Forecasting Length of Stay

Problem Statement:

For a number of conditions that impact the structure and function of the heart, heart disease is a catch-all word. Coronary heart disease is a form of heart disease that occurs when enough oxygen- rich blood cannot be supplied to the heart by the arteries of the heart. In the United States, it is the leading cause of death. In majority of the cases people will be admitted into the hospitals. My aim is to predict the length of stay of patient in hospital.


Solution:

Performed data preprocessing in SQL and developed models in Weka

Steps in Data Preprocessing:

-> Selected the columns like Admission_Type, Marital_Status, Insurance, Admission_Location, Religion, Ethnicity from admissions data and also selected the columns with disease ‘coronary’, later discharge time and admit time are casted as date and saved into a temporary table called admission.

-> Assigned 0 to female and 1 to male for the gender column in the patients table. Later, casted DOB as date and saved it into a temporary table called patients.

-> Joined DOB and Gender columns to the admissions table using inner join and saved it into a temporary file called patients1.

-> Calculated length of stay using DOB, Time_of_Admit, and Time_of_Discharge from patients1 and saved it into a temporary table called patients2.

-> Filtered out the unnecessary data and stored into a temporary table called patients3.

-> Calculated the average of cpt_number and assigned values as 1 if ICU or else 0 and saved it into a temporary table called cpt_events.

-> Assigned numeric values to the wardid and saved into a temporary table called icu_stays.

-> Assigned numeric values to the current and previous services and stored it into a temporary table called services.

-> Joined the table icu_stays with patients3 columns like first_wardid, last_wardid, first_careunit and last_careunit using inner join and saved into a temporary table named as final.

-> Again joined the table service with final table columns like previous-service, current_service using inner join and stored into a temporary table called final1.

-> Joined the table cpt_events with final1 table columns like cost_center, cost_number using inner join and stored into a temporary table called final2.

-> Set length of stay to greater than 8 days and stored it into a table called final project and downloaded as a .csv file.

Models implemented in Weka:

      Naive Bayes
      
      IBK
      
      Decision Stump
      
      Random Tree
      
      J48
      
      Logit Boost
      
      Random Subspace
      
  
  
  Conclusion:
  
  The aim of the work is to predict the Length of hospital stay of the patients using classification models. To predict the length of stay, used seven machine learning classifiers. Among them, Instance Based Learner (IBK) has obtained 89.2994% accuracy. The recall of the model is 0.893 and precision is 0.894. After IBK, Random Subspace has obtained 87.1975% accuracy. The recall of the model is 0.872 and the precision is 0.882. ICU is the place where bed management is very necessary, this framework can be used in hospitals for bed management and ICU management.





















