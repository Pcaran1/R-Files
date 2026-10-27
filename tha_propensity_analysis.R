# --- DAY 1: PROJECT SETUP & DATA INGESTION ---
# Project: Evaluating Robotic-Assisted vs. Open THA on SCB
# Author: Paulo Arana
# Aim: This script provides the initial set of covariates and propensity match neighbours across a sample of 2,000 THA (total hip arthroscopy) admissions.

# Load Required Libraries
library(tidyverse)
library(readxl)
library(MatchIt)

#Preparing THA dataset - THA PROMs Cohort Dataset 

file_path <- "Private_Healthcare_THA_PROMs_Cohort.xlsx"
tha_dataset <- read_excel(file_path, sheet = "Patient Cohort Data")

View(tha_dataset)