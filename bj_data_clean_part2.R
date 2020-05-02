library(naniar)
library(dplyr) # for general cleaning functions
library(stringr) # for string manipulations
library(magrittr)
library(readxl)


bj_list <- read_excel("bj_list_cleaned3.xlsx")

b=bj_list %>%
  select( -c(X,id,summary,house_rules,host_id,host_since,
             latitude,longitude,property_type))%>%
  replace_with_na_all(condition = ~.x %in% common_na_strings)

b$extra_people <- gsub("\\$","",b$extra_people)
b$extra_people <- as.numeric(gsub(",","",b$extra_people))

# b=a %<>% 
#   mutate(extra_people = str_remove(string = extra_people, pattern = '\\$'), # remove $ sign
#          extra_people = str_remove(string = extra_people, pattern = ',')) # remove comma
# 


dim(a)
colnames(a)

head(a$amenities)
tail(a$amenities)

# TV (with cable TV)
b$TV_available <- 0
b$TV_available[grep("TV" ,b$amenities)] <- 1
# wifi (with internet)
b$wifi_available <- 0
b$wifi_available[grep('Wifi', b$amenities)] <- 1
# air conditioning (with heating)
b$AirCondition_available <- 0
b$AirCondition_available[grep("Air conditioning" ,b$amenities)] <- 1
# Parking (paid and free)
b$Parking <- 0
b$Parking[grep('parking',b$amenities)] <- 1
# smoking allowed
b$Smoking_allowed <- 0
b$Smoking_allowed[grep('Smoking allowed',b$amenities)] <- 1
# Pets allowed
b$Pets_allowed <- 0
b$Pets_allowed[grep('Pets allowed',b$amenities)] <- 1
# Wheelchair accessible  - have error
# b$wheelChair_access[grep('Wheelchair accessible',b$amenities)] <- 0


