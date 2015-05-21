# This app allows to vizualise the ENTRIES in the subway at
# Rush hour 9 am

# UI side
library(shiny)
library(dplyr)
library(ggplot2)
library(plyr)
data <- read.csv("~/turnstile_data_master_with_weather.csv")
data1<- filter(data, Hour==9) 
shinyUI(pageWithSidebar(
  
  headerPanel(" rides"),
  
  sidebarPanel(
    selectInput("UNIT", "Pick a UNIT:",
                choices = names(table(data1$UNIT))),
    submitButton("Press Enter")
  ),
  
  mainPanel(plotOutput("barPlot", height="1000px"))
))

#sever side
library(shiny)
library(dplyr)
library(ggplot2)
library(plyr)
data <- read.csv("~/turnstile_data_master_with_weather.csv")
data1 <- filter(data,Hour==9) 
shinyServer(function(input, output) {
  datasetInput <- reactive({
    filter(data, UNIT == input$UNIT)
  })
  output$barPlot <- renderPlot({
    data2<- datasetInput()
    data3<- data2[order(data2$ENTRIESn_hourly),]
    data3$UNIT <- factor(data2$UNIT, levels=unique(as.character(data2$UNIT)))
    
    if (length(data2$UNIT) > 0){
      ggplot(data=data2, aes(x=UNIT, y=ENTRIESn_hourly, fill=DATEn)) +
        geom_bar(stat="identity", position = position_dodge(width=10)) + 
        coord_flip() + ylab("rides") + 
        ggtitle(input$DATEn) +theme_bw()
      
    }
  })
})

