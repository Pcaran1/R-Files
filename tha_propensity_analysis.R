# --- DAY 1: PROJECT SETUP & DATA INGESTION ---
# Project: Evaluating Robotic-Assisted vs. Open THA on SCB
# Author: Paulo Arana
# Aim: This script provides the initial set of covariates 
# and propensity match neighbours. 
# It uses a sample of 2,000 THA (total hip arthroscopy) admissions.

# Load Required Libraries
library(tidyverse)
library(readxl)
library(MatchIt)

#Preparing THA dataset - THA PROMs Cohort Dataset 

file_path <- "Private_Healthcare_THA_PROMs_Cohort.xlsx"
tha_dataset <- read_excel(file_path, sheet = "Patient Cohort Data")

View(tha_dataset)

dim(tha_dataset)#2000 columns, 21 column (patient/procedure identifiers)

summary(tha_dataset) 
#----DAY 2: COVARIATE SELECTION & PRE-PROCESSING ----

#DQ checks - missing values
tha_dataset %>% 
  select( #filters only specific columns 
    Surgical_Approach, #
    Admission_Age, #
    BMI, #
    ASA_Grade, #
    Charlson_Index, #
    OHS_Pre_Score, #
    SCB_Achieved #
    ) %>% 
  summarise(#aggregates the columns into summary statistics
    across(
      everything(),# loops calculation over each selected column
      ~ sum(is.na(.)) # add all instances where there is a null value
          ))

# Prepare variables for propensity score estimation
# Transforming "Surgical_Approach" into a dummy 0/1 for better analysis
# - at the moment it's 1 = Robotic-Assisted, 2 = Open
tha_processed <- tha_dataset %>% 
  mutate( 
    #Creates a brand new column
    #Create a binary treatment indicator: 1 = Robotic, 0 = Open
    treatment_robotic = 
      if_else(
          Surgical_Approach == 1, 1, 0
            ), # Needed for logistic regression
               # Treating ASA scores as a categorical variable
    ASA_Grade = 
      as.factor(ASA_Grade) # it's a categorical value, not a continuous one
        )

# Check the balance of treatment groups prior to matching
tha_processed %>% 
  group_by(treatment_robotic) %>% #
  summarise(
    count = n(),
    mean_age = mean(Admission_Age, na.rm = TRUE),
    mean_bmi = mean(BMI, na.rm = TRUE),
    mean_pre_ohs = mean(OHS_Pre_Score, na.rm = TRUE)
           )