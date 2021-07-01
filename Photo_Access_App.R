library(shiny)
library(leaflet)
library(shinythemes)

source("Data_Prep_for_Access_App.R")

ui <- fluidPage(theme = shinytheme("simplex"),
  
  # Application title
  titlePanel("Photo Locations by Date"),
  
  dateRangeInput("dates",
                 "Photos taken between:",
                 start = as.Date(min(dat3$Date)),
                 end = as.Date(max(dat3$Date)),
                 width = "50%",
                 format = "mm/dd/yy"),
  
  leafletOutput("lemap"),
  
  dataTableOutput("Table")
)

#Output
server <- function(input, output) {
  
  #filter
  filtereddata <- reactive({
    dat3 %>%
      filter(Date >= local(input$dates[1]) & Date <= local(input$dates[2]))
      })

  #Leaflet Output
  
  output$lemap <- renderLeaflet({
    leaflet(filtereddata()) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addCircleMarkers(popup = ~as.character(Date),
                       label = ~as.character(SourceFile),
                       color = ~pal(Date),
                       group = "dat4")
  })

  #DataTable Output
  
  output$Table <- renderDataTable({
    filtereddata() %>%
      as.data.frame() %>%
      mutate(Date = format(Date, '%Y-%m-%d')) %>%
      select("SourceFile", "Date")
  })
}

shinyApp(ui = ui, server = server)

