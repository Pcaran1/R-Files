#Combined days 3-4
#Day 3: Reshaping & Joining Data (tidyr & Joins): 
#Learn how to pivot data (wide vs. long format) and combine multiple datasets together (left joins, inner joins) just like SQL.
#Day 4: Introduction to Data Visualization (ggplot2): 
#Learn the "Grammar of Graphics" to build stunning, professional charts layer by layer.
#Deliverable: Write a new script called day3_4_advanced.R, build a combined wrangling + visualization pipeline, and push it to GitHub

#Part 1 - reshaping data using pivot_wider & pivot_longer

library(tidyverse)

sales_data <- tibble(
                      rep = c("Alice","Bob"),
                      Q1 = c(150,200),
                      Q2 = c(170,210)
                    )

print("Original Wide Data:")
print(sales_data)

#Now to pivot into long format - good for plotting over time
sales_long <- sales_data %>%
  pivot_longer(cols=c(Q1,Q2),names_to = "quarter",values_to="sales")

print("Pivoted Longer:")
print(sales_long)

sales_wide <- sales_long %>%
  pivot_wider(names_from = quarter,values_from = sales)

print("Pivoted Back to Wide:")
print(sales_wide)

#Part 2 - combining datasets (joins): same as sql, merging two data frames together using a primary key.
#Dataset 1
employees <- tibble(
                    emp_id = c(1,2,3,4),
                    name = c("Alice","Bob","Charlie","Diana")
                    )
#Dataset 2
departments <- tibble(
                      dept_id = c(1,2,5),
                      dept_name = c("Analytics","Engineering","Marketing")
                      )
print(employees)
print(departments)
#NOTE - employees tab has more rows than departments, so an inner join will erase rows from master table, use left join 

employee_dept_left <- employees %>%
  left_join(departments,by = c("emp_id" = "dept_id"))
#NOTE - if both tables have the same primary key column name, can bypass the *by* argument as dplyr will carry out the join automatically
print("left Join results:")
print(employee_dept_left)

######DAY 4###############################
#using ggplot2! - for data visualisations

starwars_clean<-starwars%>%
  filter(
        !is.na(mass),!is.na(height), mass <1000 #Filtering out outliers
        )
#print(starwars_clean)

ggplot(starwars_clean, aes(x=height, y=mass, color=gender)) + 
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
        title = "Height vs Mass of Star Wars Characters",
        subtitle = "Analysed by gender using ggplot2",
        x = "Height(cm)",
        y = "Mass(kg)",
        color = "Gender"
      ) +
  theme_classic()
  