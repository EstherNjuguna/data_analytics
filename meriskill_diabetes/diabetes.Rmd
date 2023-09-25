---
title: "R Notebook"
output:
  html_document:
    fig_width: 7
    fig_height: 5
---

## Introduction

This dataset is originally from the National Institute of Diabetes and Digestive and Kidney Diseases. The objective is to predict based on diagnostic measurements whether a patient has diabetes.

## Data Dictionary

Several constraints were placed on the selection of these instances from a larger database. In particular, all patients here are females at least 21 years old of Pima Indian heritage.

-   Pregnancies: Number of times pregnant

-   Glucose: Plasma glucose concentration a 2 hours in an oral glucose tolerance test

-   BloodPressure: Diastolic blood pressure (mm Hg)

-   SkinThickness: Triceps skin fold thickness (mm)

-   Insulin: 2-Hour serum insulin (mu U/ml)

-   BMI: Body mass index (weight in kg/(height in m)\^2)

-   DiabetesPedigreeFunction: Diabetes pedigree function. Indicates the function which scores likelihood of diabetes based on family history

-   Age: Age (years)

-   Outcome: Class variable (0 or 1). If patient had diabetes 1 = Yes, 0 = No.

## Understand the data

The data was imported into R and run head to visualize the first 6 rows

```{r echo=FALSE}
 diabetes <- read_csv("~/data_analytics/meriskill_diabetes/diabetes.csv")
  head(diabetes)
   summary(diabetes)
```

Also looked at the dimensions of the data

```{r}
dim(diabetes)
```

Looking if we had any null values in the data or any duplicated values

```{r}
diabetes %>% map(~sum(is.na(.)))
 sum(duplicated(diabetes))
```

Since We cannot have Bps, BMI, Skin Thickness and Glucose being zero(0) all zero values were replaced with the mean since dropping them would change the data.

```{r echo=FALSE}

diabetes <- diabetes %>%
  mutate(BloodPressure = ifelse(BloodPressure == 0, mean(BloodPressure, na.rm = TRUE), BloodPressure))
  
# Replace 0 BMI with mean
diabetes <- diabetes %>%
  mutate(BMI = replace(BMI, BMI == 0, mean(BMI, na.rm = TRUE)))

# Replace 0 glucose levels
diabetes <- diabetes %>%
  mutate(Glucose = replace(Glucose, Glucose == 0, mean(Glucose, na.rm = TRUE)))

# Replace 0 skin Thickness
diabetes <- diabetes %>%
  mutate(SkinThickness = replace(SkinThickness, SkinThickness == 0, mean(SkinThickness, na.rm = TRUE)))
# Age Categorization
 diabetes <- diabetes %>%
   mutate(
     age_cat = case_when(
       Age >= 21 & Age <= 29 ~ 'Below_30',
       Age >= 30 & Age <= 39 ~ '30s',
       Age >= 40 & Age <= 49 ~ '40s',
       Age >= 50 & Age <= 59 ~ '50s',
       Age >= 60 & Age <= 69 ~ '60s',
       Age >= 70 ~ 'Above_70',
       TRUE ~ 'Unknown'  # Default category for other cases
     
   ))
 summary(diabetes)
```

## Insights

```{r , echo = FALSE}
 ## categorize age vs the outcome
 ggplot(diabetes, aes(x = age_cat, fill = Outcome)) +
   geom_bar(fill = "blue") +
   labs(
     title = "Age Category vs. Outcome",
     x = "Age Category",
     y = "Count"
   ) +
   scale_fill_brewer(palette = "Set3") +
   theme_minimal()
```

### How do the various paramaters relate to each other

```{r echo=FALSE}
 diabetes_numeric <- diabetes[, c("Pregnancies", "Age","DiabetesPedigreeFunction",  "Outcome","BMI", "BloodPressure", "Glucose", "Insulin", "SkinThickness")]
 
 # Calculate the correlation matrix
 correlation_matrix <- cor(diabetes_numeric)
 
 corrplot(
   correlation_matrix ,
   method = "color", 
   col = colorRampPalette(c("red", "white", "blue"))(100),# Use color to represent correlations
   type = "upper",    # Show only the upper triangle of the matrix
   tl.col = "black",  # Label color
   tl.srt = 45,       # Label rotation angle
   tl.pos = "lt",   # Label position
   diag = FALSE,      # Exclude the diagonal
   addCoef.col = "black",  # Color of correlation coefficients
   tl.cex = 0.7       # Label text size
 )
```

```{r}
diabetes$Outcome <- factor(diabetes$Outcome, levels = c(1, 0), labels = c("Yes", "No"))

ggplot(diabetes, aes(x = Outcome, fill = Outcome)) +
  geom_bar() +  # Create the bar plot
  labs(
    title = "Distribution of Outcome",
    y = NULL
  ) +
  scale_fill_manual(values = c("Yes" = "blue", "No" = "red")) +  # Set bar colors
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),  # Hide major grid lines
    panel.grid.minor = element_blank(),  # Hide minor grid lines
    axis.text.x = element_text(angle = 0, hjust = 0.5)  # Adjust x-axis label alignment
  )

```
