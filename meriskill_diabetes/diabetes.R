 library(readr)
 library(purrr)
 library(ggplot2)
 library(dplyr)
 library(tidyr)
 install.packages("corrplot")
 library(corrplot)
 diabetes <- read_csv("~/data_analytics/meriskill_diabetes/diabetes.csv")
 head(diabetes)
 # number of columns and rows
 dim(diabetes)
 str(diabetes)
 #summarise the data
 summary(diabetes)
# find NAs
 diabetes %>% map(~sum(is.na(.)))
 sum(duplicated(diabetes))
 ggplot(diabetes, aes(Outcome))+
   geom_bar()+
 scale_fill_brewer(palette = "Set3") +
   labs(
     title = "Diabetes Vs Non - Diabetes ",
     x = " ",
     y = " ",
     scale_fill_manual(y = blues9)
   
   ) +
   theme(
     axis.text.x = element_blank(),
     axis.ticks.x = element_blank()
   )
min(diabetes$Age)
max(diabetes$Age)
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
     )
   )
 diabetes

 
 ggplot(diabetes, aes(x = age_cat, fill = Outcome)) +
   geom_bar() +
   labs(
     title = "Age Category vs. Outcome",
     x = "Age Category",
     y = "Count"
   ) +
   scale_fill_brewer(palette = "Set3") +
   theme_minimal()
 cor( diabetes$BMI,diabetes$Insulin)
  diabetes_numeric <- diabetes[, c("Age", "BMI", "BloodPressure", "Glucose", "Insulin", "SkinThickness")]
 
 # Calculate the correlation matrix
 correlation_matrix <- cor(diabetes_numeric)
 
 corrplot(
   correlation_matrix ,
   method = "color", 
   col = colorRampPalette(c("red", "white", "blue"))(100),# Use color to represent correlations
   type = "upper",    # Show only the upper triangle of the matrix
   tl.col = "black",  # Label color
   tl.srt = 45,       # Label rotation angle
   tl.pos = "lt",     # Label position
   diag = FALSE,      # Exclude the diagonal
   addCoef.col = "black",  # Color of correlation coefficients
   tl.cex = 0.7       # Label text size
 )
 