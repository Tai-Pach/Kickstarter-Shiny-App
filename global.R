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
library(tweenr)


kickstarter <- fread(file = "C:/Users/pache_000/Desktop/Kickstarter-Shiny-App-master/data/ks-projects-201801.csv", header = T)
kickstarter = kickstarter[c(-2843, -48148, -75398, -94580, -247914, -273780, -319003),]
kickstarter$deadline <- as.Date(kickstarter$deadline, "%Y-%m-%d")
kickstarter$launched <- as.Date(kickstarter$launched, '%Y-%m-%d %H:%M:%S')
kickstarter$date_diff <- kickstarter$deadline - kickstarter$launched
#for heat map
countries.freq <- kickstarter %>%
  filter(country!='N,0"') %>%
  group_by(country) %>%
  summarize(count=n())

countries.freq = countries.freq[c(-17),] 
#for calendar
date_count <- kickstarter %>% group_by(launched) %>% summarise(count=n())
#for main_category and subcategory breakdown
cate <- kickstarter %>% select(., main_category, category)
#for sankey diagram
main_cat_state <- kickstarter %>% group_by(main_category, state) %>% summarise(count=n())
#for bar graphs: Main Category
main_count  = kickstarter %>% group_by(., main_category ) %>% summarise(., Count= n())
descend = main_count %>% arrange(., desc(main_count$Count))
#Sub Categories
sub_count  = kickstarter %>% group_by(., category ) %>% summarise(., Count= n())
sub_descend = sub_count %>% arrange(., desc(sub_count$Count))
top20 = head(sub_descend, 20)




