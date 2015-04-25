library(shiny)
data(faithful)
##create lm model
modFit <- lm(waiting ~ eruptions, data=faithful)
aCoef <- modFit$coefficients[2]
bCoef <- modFit$coefficients[1]
##prediction function for interactive prediction
predictByInput <- function(UserEruption=3, UserConfidence=0.9) {
        UE <- data.frame(eruptions=UserEruption)
        predict(modFit, UE, interval="prediction", level=UserConfidence)
}

shinyServer(
  function(input, output) {
    #call prediction function with the user values
    PREDandInterval <- reactive({predictByInput(input$UEruption, input$Uconf)})
    output$newXY <- renderPlot({
      #update plot 
      plot(faithful$eruptions, faithful$waiting, ylim=c(0,120), xlab='Eruptions (minutes)', ylab='Waiting (minutes)' , col='lightblue',main='Waiting Time vs. Eruptions Time')
      abline(modFit,col="red")
      points(input$UEruption, PREDandInterval()[1], col="blue", pch=15, cex=1.5)
      lines(c(input$UEruption, input$UEruption), c(PREDandInterval()[2], PREDandInterval()[3]),col="blue",lwd=2)
    })
    #update predicted values in text boxes
    output$fit1 <- reactive({round(PREDandInterval()[1],2)})
    output$lwr1 <- reactive({round(PREDandInterval()[2],2)})
    output$upr1 <- reactive({round(PREDandInterval()[3],2)})
    #present the model equation (below the chart)
    output$lmEquation <- reactive({paste0('Waiting equation by lm model (red line): ', round(aCoef,4), '*Eruption + ', round(bCoef,4))})
  }
)
