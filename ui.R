

shinyUI(dashboardPage(
  skin = "black",
  dashboardHeader(
    title = "Kickstarter Project Statistics",
    titleWidth = 250
  ),
  dashboardSidebar(
    width = 250,
    sidebarUserPanel("Taino Pacheco", "pacheco.taino@gmail.com",
                     image = "https://media.licdn.com/dms/image/C4E03AQHrl9yDKG6eBA/profile-displayphoto-shrink_200_200/0?e=1530122400&v=beta&t=GSNL0SxtbxhPnWPBNlio5iJDbuPSt_3gLAVXpfMUWj4"),
    sidebarMenu(
      menuItem("The Dataset", tabName = "table", icon = icon("table")),
      menuItem("Maps", tabName = "map_dropdown", icon = icon("bars"),
               menuItem("Heat Map", tabName = "heatmap", icon = icon("fire")))
    )
    
  ),
  dashboardBody(
  
  tags$head(
    tags$link(rel = 'stylesheet', type = 'text/css', gref = 'custom.css')
  ),
  
  tabItems(
  
    tabItem(tabName = 'table',
          
          fluidRow(column(3, selectizeInput('categories', label='Pick a Category:', choices= NULL, multiple = T)),
                   column(3, selectizeInput('subcategories', label='Pick a Subcategory:', choices= NULL, multiple = T)),
                   dataTableOutput('table'))
                   
                   
          ),
    tabItem(tabName = 'heatmap',
            fluidPage(headerPanel('Number of Projects by Country'), box(htmlOutput("Heatmap")))
            )
    )
  )
))






fluidPage(
   titlePanel("Kickstarter Projects 2018"),
   sidebarLayout(
     sidebarPanel(

     ),
     mainPanel(plotOutput("count"))
  )
 )
