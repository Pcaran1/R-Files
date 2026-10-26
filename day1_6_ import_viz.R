#Additional notes - Day 7
library(tidyverse)
library(readxl) #for reading Excel files (xlsx)

# --- 1. READING CSV FILES ---
# read_csv() is lightning fast and automatically guesses column types
# (e.g., text, numbers, dates)
# Example: df_csv <- read_csv("data/clinical_data.csv")

# --- 2. READING EXCEL FILES ---
# read_excel() handles Excel sheets seamlessly
# You can specify which sheet to read if there are multiple tabs!
# Example: tha_cohort <- read_excel("Private_Healthcare_THA_PROMs_Cohort.xlsx", sheet = "Patient Cohort Data")
  
tha_cohort <- read_excel("Private_Healthcare_THA_PROMs_Cohort.xlsx", sheet = "Patient Cohort Data")
  
View(tha_cohort)

# --- 2. Visualising distributions and relationships with ggplot2 ---
# Load and clean up clinical data for plotting
tha_data <- read_excel("Private_Healthcare_THA_PROMs_Cohort.xlsx", sheet = "Patient Cohort Data")

tha_clean <- tha_data %>%
  filter(!is.na(BMI),
         !is.na(OHS_Post_Score),
         !is.na(Surgical_Approach)) %>%
        mutate(Surgical_Approach_Label = if_else(Surgical_Approach ==1, "Robotic-Assisted","Open")
        )
# --- A. HISTOGRAM: geom_histogram() ---
# Great for looking at the distribution/skewness of a single numeric clinical variable (e.g., BMI)
ggplot(tha_clean,aes(x=BMI)) + 
  geom_histogram(binwidth = 2, fill = "steelblue",color = "white",alpha = 0.8) +
  labs(title = "Distribution of Patient BMI in THA Cohort",
      x = "Body Mass Index", y = "Number of patients"
      ) + 
  theme_gray()
# --- B. BOXPLOT: geom_boxplot() ---
# Great for comparing clinical outcomes and spotting outliers across surgical approaches
ggplot(
  tha_clean, 
  aes(
      x = Surgical_Approach_Label, 
      y = OHS_Post_Score, 
      fill = Surgical_Approach_Label
      )
      ) +
  geom_boxplot(alpha = 0.7) +
  labs(title = "Post-Operative Oxford Hip Score by Surgical Approach", x = "Surgical Approach", y = "Post-Op OHS") +
  theme_light() +
  theme(legend.position = "none") # Hide redundant legend
# --- C. SCATTER PLOT: geom_point() ---
# Great for exploring the relationship between two clinical numeric variables (e.g., Pre-op vs Post-op OHS)
ggplot(
  tha_clean, 
  aes(
      x = OHS_Pre_Score, 
      y = OHS_Post_Score, 
      color = as.factor(SCB_Achieved))
      ) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  labs(
    title = "Pre-op vs. Post-op Oxford Hip Scores",
    subtitle = "Colored by Substantial Clinical Benefit (SCB) Achievement",
    x = "Pre-Op OHS",
    y = "Post-Op OHS",
    color = "SCB Achieved"
  ) +
  theme_dark()