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


kickstarter <- fread(file = "C:/Users/pache_000/Desktop/Kickstarter-Shiny-App-master/data/ks-projects-201801.csv", header = T)

countries.freq <- kickstarter %>%
  filter(country!='N,0"') %>%
  group_by(country) %>%
  summarize(count=n())

countries.freq = countries.freq[c(-17),] 



