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

# server side
#library(shiny)
#library(dplyr)
#library(ggplot2)
#data2 <- read.csv("~/turnstile_data_master_with_weather.csv")
#shinyServer(function(input, output) {
#  datasetInput <- reactive({
#    filter(data2, rain == input$rain, UNIT==input$UNIT)
#  })
  #national.avg <- reactive({ 
  #  data3<- filter(data2, rain == input$rain)
  #  aggregate(data3[c("ENTRIESn_hourly", "EXITSn_hourly")], by=data3["DATEn"], FUN=sum)
  #})
  
 # output$barPlot <- renderPlot({
  #  data2 <- datasetInput()
      
  #    ggplot(data=data2, aes(x=factor(DATEn), y=data2$ENTRIESn_hourly, fill=rain)) +
  #      geom_bar(stat="identity", position = position_dodge(width=10)) + 
  #      ylab("rain days") + 
        
        
  #      xlab("DATEn") +
  #      ggtitle(paste(input$rain, "rain and no rain")) +
        
  #      theme_bw()
 # })
#})



