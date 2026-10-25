# Day 5-6
#Today, we are tackling:
#Day 5: Cleaning Messy Data Types (stringr for text, lubridate for dates, and readr parsing tricks).
#Day 6: Writing Custom Functions & Automation (turning repetitive logic into reusable tools).
#Part 1: Cleaning Messy Text and Dates (stringr & lubridate)
#In the real world, dates are formatted weirdly, text has extra spaces, and numbers come wrapped in symbols. Let's fix that.
#
library(tidyverse)
library(lubridate) #Used for transforming date/times

# Creating a messy dataset
messy_df <- tibble(
  date_col = c("2026-10-25", "25/10/2026", "October 28th, 2026"),
  name_col = c("  ALICE SMITH ", "bob jones", "CHARLIE BROWN  "),
  revenue_str = c("$1,250.50", "$850.00", "$3,100.25")
                  )
cleaned_df <- messy_df %>%
  mutate(
    clean_name = str_trim #removes unnecessary whitespace inside text string - not between words
                  (
                    str_to_title(name_col) #converts text to Title Case (first letter gets capitalised only)
                  ), #(1) cleaning the name_col
    
    revenue = parse_number #drops all non-numeric characters from string
                  (
                    revenue_str
                  ), # (2) clean numbers, without the dollar sign or the comma
    parsed_date = parse_date_time #converts irregular text strings into date_time objects using "orders" for the different formatting types in your text
                  (
                  date_col, orders = c("ymd","dmy","bdy")
                  )#(3)lubridate is given different formats to approach to clean dates
        )
print(cleaned_df)

#Part 2: Writing Custom Functions
# Wrapping repetitive functions instead of doing the same calculation three times

#Writing a custom function for calculating the bonus of someone's salary
calculate_bonus <- function (sales_amount,bonus_rate = 0.1)
  { 
  if(!is.numeric(sales_amount))
    {
      stop("Sales amount must be a number!")
    }
  bonus<- sales_amount * bonus_rate
  return(bonus)
  }

  calculate_bonus(1250.50)
  calculate_bonus(1250.50,0.2)
  
final_df <- cleaned_df %>%
  mutate(
          bonus_earned = calculate_bonus(revenue,0.15)
        )

print(final_df)