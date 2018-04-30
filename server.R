

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
  output$table <- renderDataTable({
    datatable( data_filter(), rownames=TRUE, options = list(columnDefs = list(list(visible = FALSE, targets = c(1,13,14,15))))) %>%
      formatStyle(input$selected,
                  background="skyblue", fontWeight='bold')
    
  })

  output$Heatmap <- renderGvis({
    map<-gvisGeoChart(countries.freq, locationvar='country', colorvar='count',
                      options=list(projection="kavrayskiy-vii", width='200%'))
    
    return(map)
  })
})
   ################################################################################################

# function(input, output) {
#   output$count <- renderPlot(
#     flights %>%
#       filter(origin == input$origin & dest == input$dest) %>%
#       group_by(carrier) %>%
#       count() %>%
#       ggplot(aes(x = carrier, y = n)) +
#       geom_col(fill = "lightblue") + 
#       ggtitle("Number of flights")
#   )
# }
