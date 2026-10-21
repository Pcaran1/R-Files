#Day 2 - Data manipulation with tidyverse (dplyr) and the Pipeline Operator (%>% or |>).
#
#Mastering dplyr - core functions: select(), filter(), mutate(),summarize() + groupby()
#
#>%> or |> - chains operations cleanly without creating 10 intermediate variables.
#
#!is.na(height): give me the rows where height is not(!) missing
# n(): give me a count of the column
# n_distinct(char_count): give me a distinct count of the column
library(tidyverse)
# Let's use the built-in starwars dataset
data("starwars")

# Take a quick glance at the data structure
glimpse(starwars)
#
View(starwars)
#
# --- THE MAGIC OF THE PIPE ---
# Read this as: "Take starwars, THEN filter, THEN select, THEN mutate"

starwars_summary <- starwars %>% 
  # 1. Filter for human characters with known mass
  filter(species == "Human", !is.na(mass)) %>% 
  
  # 2. Pick only the columns we care about
  select(name, height, mass, homeworld) %>% 
  
  # 3. Create a new column: Body Mass Index (BMI) = mass (kg) / (height (m))^2
  mutate(bmi = mass / ((height / 100)^2)) %>% 
  
  # 4. Sort by highest BMI
  arrange(desc(bmi))

print(starwars_summary)
#-----------------------------------------------------------------------------------

# --- GROUPED AGGREGATIONS (SQL style) ---
homeworld_stats <- starwars %>% 
  filter(!is.na(height)) %>% 
  group_by(homeworld) %>% 
  summarize(
    char_count = n(),
    avg_height = mean(height)
  ) %>% 
  filter(char_count > 1) %>% 
  arrange(desc(avg_height))

print(homeworld_stats)