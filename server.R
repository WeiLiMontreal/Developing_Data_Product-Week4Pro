
library(shiny)
library(plotly)
library(ggplot2)

mydata <- data.frame("time" = seq(ISOdate(2012,1,1),ISOdate(2017,6,30), "month"), 
                     "month" = months(seq(ISOdate(2012,1,1),ISOdate(2017,6,30), "month")),
                     "Canada"=c(8.0,7.8,7.8,7.5,7.5,6.8,7.5,7.7,6.6,6.8,6.8,6.7,
                                 7.5,7.4,7.8,7.4,7.2,6.7,7.4,7.6,6.4,6.4,6.5,6.7,
                                 7.4,7.4,7.4,7.3,7.2,6.7,7.3,7.5,6.3,6.0,6.2,6.2,
                                 7.0,7.2,7.4,7.1,7.1,6.5,7.1,7.5,6.4,6.3,6.6,6.7,
                                 7.5,7.7,7.7,7.5,6.9,6.4,7.2,7.6,6.4,6.3,6.3,6.4,
                                 7.2,7.0,7.2,6.8,6.6, 6.0),
  "Newfoundland and Labrador"=c(14.9,13.8,14.0,13.5,12.1,11.1,11.4,12.6,10.7,10.5,12.2,11.2,
                                13.5,12.9,13.8,13.7,11.7,10.0,10.7,10.8, 8.7,10.0,12.2,11.2,
                                14.6,13.0,12.8,13.6,12.6,10.4,10.7,12.3,10.4,10.8,11.0,11.3,
                                13.5,13.9,15.6,14.7,13.9,10.7,10.5,11.0,11.5,11.6,12.9,14.2,
                                16.8,16.0,15.2,14.7,11.3,10.1,11.1,11.7,11.7,13.3,14.5,15.2,
                                16.8,16.7,17.5,16.3,14.4,12.6),
      "Prince Edward Island" =c(15.8,13.2,13.1,14.2,09.8,08.3,08.9,09.5,08.7,09.9,11.8,11.5,
                                14.7,13.4,14.2,14.0,10.7,08.0,10.1,08.8,09.4,09.5,13.1,13.3,
                                14.2,13.3,13.8,14.4,11.3,06.1,07.8,07.3,07.8,07.7,11.5,12.9,
                                13.2,12.2,13.6,13.7,10.3,07.1,09.6,08.5,07.1,08.3,11.4,11.1,
                                12.5,13.6,13.3,15.0,08.9,07.4,08.7,09.8,08.1,09.7,11.6,11.5,
                                12.0,11.7,12.4,13.2,08.5,06.9), 
                "Nova Scotia"=c(09.6,09.2,09.7,10.1,09.1,08.6,09.1,09.7,08.1,08.7,08.7,09.0,
                                10.8,10.3,10.4,10.0,08.7,08.1,08.4,09.0,07.7,08.3,08.3,08.7,
                                10.1,09.9,10.2,10.0,09.1,08.3,09.3,08.7,07.4,07.9,08.6,07.8,
                                09.4,09.9,10.1,10.1,08.8,07.0,07.8,08.5,07.8,06.9,08.4,08.2,
                                09.6,10.2,10.1,09.1,07.9,07.1,08.1,08.5,07.0,06.8,07.5,07.7,
                                08.6,09.2,09.9,09.1,07.6,07.9),
              "New Brunswick"=c(10.7,11.1,11.5,10.8,09.8,07.9,10.1,10.4,09.5,10.0,10.8,10.0,
                                12.8,11.6,12.2,11.9,10.5,09.1,09.4,09.9,08.4,08.8,09.4,09.7,
                                11.4,10.9,10.9,12.3,10.7,08.1,09.7,09.1,08.2,08.9,09.7,09.7,
                                11.5,11.6,11.6,11.6,10.2,09.5,10.8,09.8,07.1,07.7,08.2,08.4,
                                10.7,11.2,11.9,11.4,09.8,08.8,09.6,08.7,07.6,08.4,08.0,08.8,
                                09.8,10.0,09.6,10.2,08.3,06.8),
                     "Quebec"=c(09.5,09.0,08.7,08.5,07.5,06.8,07.0,07.7,06.8,06.8,07.3,07.4,
                                08.3,08.1,08.6,08.3,07.4,07.2,07.5,08.0,06.7,06.7,06.7,07.4,
                                08.5,08.9,08.7,08.4,07.8,07.3,07.7,07.8,06.7,06.7,07.2,07.2,
                                08.1,08.0,08.3,08.1,07.6,07.5,07.5,08.2,06.7,06.8,07.0,07.6,
                                08.3,08.3,08.3,08.1,07.0,06.4,07.0,07.4,06.1,06.0,05.8,06.4,
                                07.0,07.1,07.0,07.2,05.8,05.6),
                    "Ontario"=c(08.2,07.7,08.1,07.8,08.6,07.6,08.7,08.6,07.4,07.8,07.1,07.0,
                                07.8,07.8,08.2,07.7,07.8,07.3,08.4,08.3,07.0,06.9,06.7,07.1,
                                07.5,07.5,07.6,07.3,07.7,07.4,08.3,08.1,06.8,06.2,06.4,06.5,
                                06.9,07.0,07.3,06.8,06.9,06.4,07.1,07.6,06.5,06.2,06.3,06.1,
                                06.8,06.8,07.1,07.1,06.6,06.1,06.9,07.6,06.3,05.8,05.6,05.7,
                                06.5,06.3,06.8,05.9,06.6,06.1),
                   "Manitoba"=c(05.7,05.8,05.4,05.3,05.0,04.8,06.1,06.8,04.8,04.9,04.6,04.6,
                                04.7,05.2,05.0,05.7,05.4,04.8,06.2,06.6,05.2,05.1,05.4,05.2,
                                05.6,05.6,05.6,05.9,05.4,04.7,05.8,06.6,05.2,04.6,04.7,04.9,
                                06.0,05.5,05.4,05.6,05.8,04.9,06.4,07.1,04.9,04.8,05.6,05.4,
                                06.2,06.2,06.1,06.3,05.9,05.6,06.9,07.3,06.1,05.7,05.6,05.7,
                                06.3,06.0,05.5,05.4,05.1,04.8),
               "Saskatchewan"=c(05.0,05.4,05.2,05.3,04.4,04.3,05.3,05.4,04.0,04.0,04.2,04.5,
                                04.1,03.9,04.1,04.5,04.4,03.6,04.7,05.1,03.8,03.3,03.9,03.6,
                                04.7,04.1,04.8,03.9,04.0,03.3,03.6,05.2,02.9,03.0,03.2,03.4,
                                04.9,05.5,04.9,04.8,05.3,04.2,05.4,06.0,04.4,04.9,05.0,05.1,
                                06.1,06.7,06.9,07.0,05.8,05.5,06.3,06.8,05.9,06.1,06.4,06.2,
                                07.1,06.5,06.7,07.0,06.3,05.8),
                    "Alberta"=c(05.1,05.3,05.2,04.7,04.5,04.4,04.6,04.9,04.1,04.0,04.0,04.2,
                                04.6,04.7,04.9,04.5,04.7,04.8,04.7,05.3,03.9,04.2,04.3,04.5,
                                04.7,04.3,05.2,05.3,04.9,04.6,04.7,05.7,04.2,04.1,04.0,04.5,
                                04.6,05.8,06.2,06.0,06.2,05.6,06.3,06.6,05.9,06.0,06.4,06.7,
                                07.7,08.5,07.7,08.1,08.1,07.8,09.1,09.1,07.5,07.5,08.5,08.2,
                                08.9,08.6,08.8,08.5,08.0,07.2),
           "British Columbia"=c(07.4,07.4,07.3,06.6,07.3,06.5,07.0,07.0,06.4,06.2,06.6,06.4,
                                07.2,06.7,07.2,06.4,06.8,06.1,06.7,07.0,06.2,06.2,06.4,06.2,
                                06.9,06.7,05.9,05.9,06.4,05.8,06.2,06.5,06.1,05.8,05.5,04.9,
                                06.0,06.6,06.3,06.2,06.4,05.6,06.2,06.3,06.2,06.0,05.9,06.2,
                                06.9,07.2,06.7,05.6,06.2,05.5,05.8,06.0,05.5,05.8,05.9,05.4,
                                06.0,05.6,05.5,05.2,05.7,04.5))
mydata2 <- data.frame(mydata[1:2], stack(mydata[3:ncol(mydata)]))
# monthSelect='June'
# subset <- mydata[which(mydata$month == monthSelect),]
# 
# labels = names(subset[,4:13])
# #boxplot(subset[,4:13], notch=FALSE, col = c(1:10))
# boxplot(subset[,4:13], notch=FALSE, col = c(1:10), xaxt = "n", xlab = "", 
#         ylab = "unemployment rate", main = paste("Unemployment rate in each", monthSelect , "in each province from 2012 to 2017"))
# axis(1, labels = FALSE)
# text(x=seq_along(labels), y= par("usr")[3]-0.1 , srt = 40, adj = 1, labels = labels,
#      xpd=TRUE, cex=0.6)
  # Define server logic required to draw a histogram


shinyServer(function(input, output) {
   
    output$test1 <- reactive({
        my_number <- as.numeric(input$slider1)
        ifelse(my_number ==0,0,1)})
    outputOptions(output, "test1", suspendWhenHidden = FALSE)
    

    output$plot0 <- renderPlotly({
    if (as.numeric(input$slider1)==0 ){
        plot_ly(data=mydata2, x=~time, y = ~values,   color =~ind, mode = 'lines+markers') %>% 
       layout(legend = list(x = 0.95, y = 0.75),
              size =8,
              title = "Unemployment rates groupped with the province/territory \nfrom January 2012 to June 2017") 
      }
    })

    output$plot1 <- renderPlot({
    if (as.numeric(input$slider1)>0 ){
        # find month indices
        monthVal <-  input$slider1
        monthSelect=month.name[monthVal]
        subset <- mydata[which(mydata$month == monthSelect),]

        labels = names(subset[,4:13])
        boxplot(subset[,4:13], notch=FALSE, col = c(1:10),  ylim=c(1,20), xaxt = "n", xlab = "",
              ylab = "unemployment rate", main = paste("Statistics of the unemployment rate in ", monthSelect , " for all provinces from 2012 to 2017"))
        axis(1, labels = FALSE)
        text(x=seq_along(labels), y= par("usr")[3]-0.1 , srt = 40, adj = 1, labels = labels,
                xpd=TRUE, cex=0.6)
    }
   })

  
   
    

})
