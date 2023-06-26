#1 - Download package libraries and set working directory

# Set the working directory
setwd("~/The Fresh Start Initiative")

# Download and install packages
install.packages("data.table")
install.packages("tidyverse")

# Load packages
library(data.table)
library(tidyverse)

#2 - Read in data
# Read in the data
fresh_start <- read.csv("fresh_start_data.csv")

#3 - Data cleaning and transformation

# Use the select function to create a subset of the desired columns
fresh_start_select <- select(fresh_start, id, sex, age, marital_status, years_exp, num_children)

# Rename the columns
colnames(fresh_start_select) <- c("id", "sex", "age", "marital_status", "years_of_experience", "num_children")

# Code marital_status into more descriptive labels
fresh_start_select$marital_status <- factor(fresh_start_select$marital_status, 
                         levels = c(1, 2, 3), 
                         labels = c("Married", "Single", "Divorced"))

#4 - Data exploration

# Get statistics
summary(fresh_start_select)

# Visualize the data
ggplot(fresh_start_select, aes(x = marital_status, y = age)) + 
  geom_boxplot() + 
  ggtitle("Age Distribution by Marital Status") + 
  theme(plot.title = element_text(hjust = 0.5))

#5 - Create a simple linear regression model

# Build a regression model 
model <- lm(data = fresh_start_select, 
            formula = age ~ num_children + years_of_experience)

# Generate a summary to check the model fit
summary(model)

#6 - Draw conclusions

# Interpret the results
cat("Based on the results of the linear regression model, we can conclude that age is positively correlated with years of experience and negatively correlated with number of children.")