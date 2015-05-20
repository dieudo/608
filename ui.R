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

#library(shiny)
#data2 <- read.csv("~/turnstile_data_master_with_weather.csv")
#shinyUI(pageWithSidebar(
#  headerPanel(" Average"),
  
 # sidebarPanel(
  #  selectInput("rain", "rain or not :",
   #             choices = names(table(data2$rain))),
    #selectInput("UNIT", "Choose a UNIT OR STATION:",
     #           choices = names(table(data2$UNIT))),
    #submitButton("Press here to see your plot")
  #),
  
  #mainPanel(
   # plotOutput("barPlot", height="800px")
  #)
#))


