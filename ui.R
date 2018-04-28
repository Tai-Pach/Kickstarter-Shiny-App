library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(),
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
  )






fluidPage(
   titlePanel("Kickstarter Projects 2018"),
   sidebarLayout(
     sidebarPanel(

     ),
     mainPanel(plotOutput("count"))
  )
 )
