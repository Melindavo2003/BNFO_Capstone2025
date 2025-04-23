#  MAIN MODEL

# Load packages

install.packages("patchwork")  # only if not already installed
library(patchwork)


library(lme4)
library(dplyr)
library(lmerTest)

# Load and clean data
capstone_data <- read.csv("C:/Users/Vi Cao Nguyen/Documents/BNFO Capstone/capstone_data.csv", header = TRUE)

# Clean and scale the relevant columns
capstone_data$Covid_Cases <- as.numeric(gsub(",", "", capstone_data$Covid_Cases))
capstone_data$Covid_Deaths <- as.numeric(gsub(",", "", capstone_data$Covid_Deaths))

# Scale numeric predictors
num_vars <- c("Covid_Cases", "Covid_Deaths", "percent_Obesity",
              "Seafood_Intake", "Meat_Intake", "Vegetable_Intake", "Dairy_Intake")
capstone_data[num_vars] <- scale(capstone_data[num_vars])


# Fit a simplified model (if needed)
formula_suicide <- Suicide_Rates ~ Covid_Cases + Covid_Deaths + percent_Obesity +
  Seafood_Intake + Meat_Intake + Vegetable_Intake + Dairy_Intake +
  factor(Year) + (1 | Country)

model_suicide <- lmer(formula_suicide, data = capstone_data, REML = TRUE)
summary(model_suicide)

library(ggplot2)
library(patchwork)

# Individual plots
p1 <- ggplot(capstone_data, aes(x = Seafood_Intake, y = Suicide_Rates)) +
  geom_point(color = "navy") +
  geom_smooth(method = "lm", se = TRUE, color = "darkblue") +
  labs(title = "Suicide Rates vs Seafood Intake",
       x = "Seafood Intake", y = "Suicide Rates") +
  theme_minimal()

p2 <- ggplot(capstone_data, aes(x = Meat_Intake, y = Suicide_Rates)) +
  geom_point(color = "darkgreen") +
  geom_smooth(method = "lm", se = TRUE, color = "forestgreen") +
  labs(title = "Suicide Rates vs Meat Intake",
       x = "Meat Intake", y = "Suicide Rates") +
  theme_minimal()

p3 <- ggplot(capstone_data, aes(x = Dairy_Intake, y = Suicide_Rates)) +
  geom_point(color = "brown") +
  geom_smooth(method = "lm", se = TRUE, color = "chocolate4") +
  labs(title = "Suicide Rates vs Dairy Intake",
       x = "Dairy Intake", y = "Suicide Rates") +
  theme_minimal()

# Combine all plots in a row
combined_plot <- p1 + p2 + p3
combined_plot


### Depression_Rates
formula_depression1 <- Depression_Rates ~ Covid_Cases + Covid_Deaths + percent_Obesity + 
  Seafood_Intake + Meat_Intake + Vegetable_Intake + Dairy_Intake + 
  factor(Year) + (1 | Country)
model_depression1 <- lmer(formula_depression1, data = capstone_data)
summary(model_depression1)

library(ggplot2)

# Depression vs Seafood Intake
p1 <- ggplot(capstone_data, aes(x = Seafood_Intake, y = Depression_Rates)) +
  geom_point(color = "steelblue") +
  geom_smooth(method = "lm", se = TRUE, color = "darkblue") +
  labs(title = "Depression Rates vs Seafood Intake",
       x = "Seafood Intake", y = "Depression Rates") +
  theme_minimal()

# Depression vs Vegetable Intake
p3 <- ggplot(capstone_data, aes(x = Vegetable_Intake, y = Depression_Rates)) +
  geom_point(color = "orange3") +
  geom_smooth(method = "lm", se = TRUE, color = "darkorange") +
  labs(title = "Depression Rates vs Vegetable Intake",
       x = "Vegetable Intake", y = "Depression Rates") +
  theme_minimal()

# Combine all plots in a row
combined_plot <- p1 + p3
combined_plot
