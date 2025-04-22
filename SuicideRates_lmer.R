install.packages("Matrix")
install.packages("lme4")
install.packages("lmerTest")
install.packages("glmerTest")
install.packages("tidyr")

# Load necessary libraries
library(readxl) 
library(lme4)   
library(lmerTest)


# Load the data
data <- read_excel("Capstone_data.xlsx", sheet = "Sheet1")


# Suicide_Rates lmer
formula_suicide <-Suicide_Rates ~ Covid_Cases + Covid_Deaths+ percent_Obesity + 
  Seafood_Intake + Meat_Intake + Vegetable_Intake + Dairy_Intake + factor(Year) + (1 | Country)
model_suicide <- glmer(formula_suicide, data = data)
summary(model_suicide)
