library(shiny)
shinyUI(fluidPage(
  headerPanel("Predict Waiting Time with Old Faithful R-dataset"),
  fluidRow(
   ##Input/Output
   column(3,
    h4("INPUT/OUTPUT"),
    #Input
    h4("Set Parameters:"),
    #first scrollbar
    sliderInput('UEruption', 'Insert eruption duration (minutes)',value = 3, min = 1.6, max = 5.1, step = 0.05,),
    #second scrollbar
    sliderInput('Uconf', 'Insert tolerance level',value = 0.9, min = 0.5, max = 0.99, step = 0.01,),
    br(),
    #Output
    h4("Results:"),
    h5('Predicted Waiting Time (minutes)'),
    verbatimTextOutput("fit1"),
    h5('Upper Interval (wide interval)'),
    verbatimTextOutput("upr1"),
    h5('Lower Interval (wide interval)'),
    verbatimTextOutput("lwr1")
   ),
   ##Chart column
   column(6,
    h4("CHART"),
    #chart
    plotOutput('newXY'),
    #equation
    verbatimTextOutput("lmEquation"),
    #note
    p(span('NOTE:', style = 'color:blue'),' The light blue circles show the data from the Old Faithful dataset.')
   ),
   ##Tabs
   column(3,
      tabsetPanel(
       #Info tab   
       tabPanel("INFO", 
         h4("DESCRIPTION"),
         p('This page use the R dataset ',span('faithful', style = "color:green"), ' that contain 272 observations and two variables: eruptions (duration of an eruption) and waiting (time from end of eruption to the next eruption).'),
         p('A simple linear model built here, using the R function lm, to calculate the linear equation (see the red line in the CHART area). The predict.lm in R use this equation to predict the waiting time after an eruption, based on the eruption duration, and return the prediction (tolerance) interval, which is a wider interval than confidence interval, since it also consider the variance.'),
         h4("INSTRUCTIONS"),
         tags$ol(
           tags$li("Use the first scrollbar to select some eruption duration."), 
           tags$li("Use the second scrollbar to select a tolerance interval.")
         ),
         p('In the ',span('Results', style = "color:red"), ' section, see the predicted waiting time, and the calculated tolerance interval.'),
         p('In the ',span('CHART', style = "color:red"), ' section, see the predicted waiting time (small blue square), and the calculated tolerance interval (blue vertical line).')
       ), 
       #More tab
       tabPanel("More", h4("LINKS"),
         a(href="https://stat.ethz.ch/R-manual/R-patched/library/stats/html/predict.lm.html",'predict.lm'),
         br(),
         a(href="http://www.stat.cmu.edu/~larry/all-of-statistics/=data/faithful.dat", 'faithful dataset'),
         br(),
         a(href="https://stat.ethz.ch/R-manual/R-patched/library/datasets/html/faithful.html", 'faithful')
       ), 
       #Bacground tab
       tabPanel("Background", 
         br(),
         p('This Shiny application created as an assignment in the Coursera course Developing Data Products.'))
       )
      
   )

)))


