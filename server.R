

shinyServer(function(input, output, session){
  
  
  updateSelectizeInput(session, "categories", choices = unique(kickstarter$main_category), server = TRUE)
  updateSelectizeInput(session, "subcategories", choices = unique(kickstarter$category), server = TRUE)
  
  ################################## FILTERING OF THE DATATABLE ##################################
  filtered_data = kickstarter
  data_filter = reactive({
    if(length(input$categories)) {
      filtered_data = filtered_data %>% filter(., main_category == input$categories)
    }
    if(length(input$subcategories)) {
      filtered_data = filtered_data %>% filter(., category %in% input$subcategories)
    }
    return(filtered_data)
  })
  #################################################################################################
  
  
  ################################### OUTPUTS #####################################################
  output$table <- renderDataTable({
    datatable(data_filter(), rownames=TRUE, options = list(columnDefs = list(list(visible = FALSE, targets = c(1,6,9,13))))) %>%
      formatStyle(input$selected,
                  background="skyblue", fontWeight='bold')
    
  })

  output$Heatmap <- renderGvis({
    map<-gvisGeoChart(countries.freq, locationvar='country', colorvar='count',
                      options=list(title='Number of Projects by Country', projection="kavrayskiy-vii", width='100%', colorAxis="{colors:['#FFcccc', '#FF0000']}"))
    
    return(map)
  })
  
  output$calendar <- renderGvis({
    launch <- gvisCalendar(date_count, 
                           datevar="launched", 
                           numvar="count",
                           options=list(
                             title="Number of Projects Launched per Day",
                             height=920,
                             calendar="{yearLabel: { fontName: 'Times-Roman',
                      fontSize: 32, color: '#1A8763', bold: true},
                      cellSize: 10,
                      cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                      focusedCellColor: {stroke:'red'}}"))
  return(launch)
  })
  output$sankey_diagram <- renderGvis({
    Sank <- gvisSankey(main_cat_state, from="main_category", to="state", weight="count",
                       options=list(title= 'Main Categories and Project Outcomes',width= 800, height = 520, sankey="{link: {color: { fill: '#d799ae' } },
                                    node: { color: { fill: '#a61d4c' },
                                    label: { color: '#871b47' } }}"))
    return(Sank)
})
  output$bar_graph <- renderGvis({
    Col1 <- gvisColumnChart(des_success_n2, xvar = "main_category", yvar = c("Total Unsuccessful","Total Successful"),  options = list(isStacked=T, title='Most Popular Project Categories', width=1000, height= 600))
    
    return(Col1)
  })
  
  output$bar_graph2 <- renderGvis({
    Col2 <- gvisColumnChart(top20, options = list(title = 'Top 20 Most Popular Project Sub-categories', width=1100, height= 600,  legend = "{position: 'none'}"))
    
    return(Col2)
  })
  output$bar_graph3 <- renderGvis({
    Col3 <- gvisColumnChart(des_success_n3, xvar = "main_category", yvar = "Success Rate",  options = list(title='Success Rate By Main Category', width=1000, height= 600))
    
    return(Col3)
  })
  # output$flow <- renderGvis({
  # flowchart <- gvisSankey(cate, from="main_category", to="category", weight="Count",
  #                      options=list(width= 600, height = 520,
  #                         sankey="{link: {color: { fill: '#d799ae' } },
  #                        node: { color: { fill: '#a61d4c' },
  #                        label: { color: '#871b47' } }}"))
  # return(flowchart)
  # })
})
############################################################################################