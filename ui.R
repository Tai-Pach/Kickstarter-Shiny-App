
shinyUI(dashboardPage(
  skin = "purple",
  dashboardHeader(
    title = "Kickstarter Dataset Exploration",
    titleWidth = 350
  ),
  dashboardSidebar(
    width = 250,
    sidebarUserPanel("Taino Pacheco", "pacheco.taino@gmail.com",
                     image = "https://media.licdn.com/dms/image/C4E03AQHrl9yDKG6eBA/profile-displayphoto-shrink_200_200/0?e=1530122400&v=beta&t=GSNL0SxtbxhPnWPBNlio5iJDbuPSt_3gLAVXpfMUWj4"),
    sidebarMenu(
      menuItem("The Dataset", tabName = "table", icon = icon("table")),
      menuItem("Maps", tabName = "map_dropdown", icon = icon("bars"),
               menuItem("Heat Map", tabName = "heatmap", icon = icon("fire"))),
      menuItem("Graphs", tabName = 'graph_dropdown', icon = icon('bars'),
               menuItem("Calendar", tabName = "graphs", icon = icon('calendar')),
               menuItem("Sankey", tabName = "sankey", icon =icon('table')),
               menuItem("Most Popular Main Categories", tabName = 'bargraph', icon=icon('signal')),
               menuItem("Top 20 Sub Categories", tabName = 'bargraph2', icon =icon('signal')),
               menuItem("Success Rate By Category", tabName = 'bargraph3', icon =icon('signal')))
               #menuItem("Category Organizational Chart", tabName = 'flow_', icon =icon('tree')))
    )),
  dashboardBody(
    tabItems(
  
      tabItem(tabName = 'table',
          fluidRow(column(3, selectizeInput('categories', label='Pick a Category:', choices= NULL, multiple = T)),
                   column(3, selectizeInput('subcategories', label='Pick a Subcategory:', choices= NULL, multiple = T)),
                   dataTableOutput('table'))
            ),
    
      tabItem(tabName = 'heatmap',
            fluidPage(htmlOutput("Heatmap"))
            ),
      tabItem(tabName = 'graphs',
           fluidPage(headerPanel('Calendar Graph'), box(htmlOutput("calendar")))
            ),
      tabItem(tabName = 'sankey',
            fluidPage(htmlOutput("sankey_diagram"))
            ),
      tabItem(tabName = 'bargraph',
            fluidPage(headerPanel(htmlOutput("bar_graph")))
            ),
      tabItem(tabName = 'bargraph2',
              fluidPage(htmlOutput("bar_graph2"))
    
            ),
      tabItem(tabName = 'bargraph3',
              fluidPage(htmlOutput("bar_graph3"))
              )
      #tabItem(tabName = 'flow_',
              #fluidPage(htmlOutput("flow")))
      )
    )
))



