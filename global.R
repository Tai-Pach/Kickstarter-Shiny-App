library(shiny)
library(data.table)
library(shinydashboard)
library(DT)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(lubridate)
library(rworldmap)
library(knitr)
library(googleVis)

# read the file 
kickstarter <- fread(file = "./data/ks-projects-201801.csv", header = T)
# remove 7 observations that have incorrect launch dates (year says "1970")
kickstarter = kickstarter[c(-2843, -48148, -75398, -94580, -247914, -273780, -319003),]
# covert deadline values to date type
kickstarter$deadline <- as.Date(kickstarter$deadline, "%Y-%m-%d")
#covert launched values to date type
kickstarter$launched <- as.Date(kickstarter$launched, '%Y-%m-%d %H:%M:%S')
# add a new column for project duration
kickstarter$project_duration_days <- kickstarter$deadline - kickstarter$launched
#for heat map
countries.freq <- kickstarter %>%
  filter(country!='N,0"') %>%
  group_by(country) %>%
  summarize(count=n())

countries.freq = countries.freq[c(-17),] 
#for calendar
date_count <- kickstarter %>% group_by(launched) %>% summarise(count=n())
#for main_category and subcategory isolation
cate <- kickstarter %>% select(., main_category, category) %>% group_by(., main_category, category) %>% summarise(., Count=n())
cate <- unique(cate)
#for sankey diagram
main_cat_state <- kickstarter %>% group_by(main_category, state) %>% summarise(count=n())
#for bar graphs: Main Category
main_count  = kickstarter %>% group_by(., main_category ) %>% summarise(., `Total Count`= n())
descend = main_count %>% arrange(., desc(main_count$`Total Count`)) #arrange categories in descending order
success_n = kickstarter %>% select(., main_category, state) %>% filter(., state=="successful") %>% group_by(., main_category) %>% summarise(., `Total Successful` = n())
failure_n = kickstarter %>% select(., main_category, state) %>% filter(., state!="successful") %>% group_by(., main_category) %>% summarise(., `Total Unsuccessful` = n())
des_success_n = merge(success_n,failure_n)
des_success_n = merge(des_success_n, descend)
des_success_n2 = des_success_n %>% arrange(., desc(des_success_n$`Total Count`))

des_success_n3 = des_success_n2 %>% mutate(., `Success Rate` = (`Total Successful`/`Total Count`)) %>% arrange(., desc(`Success Rate`))

#Sub Categories
sub_count  = kickstarter %>% group_by(., category ) %>% summarise(., Count= n())
sub_descend = sub_count %>% arrange(., desc(sub_count$Count))
top20 = head(sub_descend, 20)


goal_mean <- kickstarter %>% select(., main_category, usd_goal_real) %>% group_by(., main_category) %>% summarise(`Mean Goal (USD)`=mean(usd_goal_real)) %>% arrange(., desc(goal_mean$`Mean Goal (USD)`))





