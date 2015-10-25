shinyUI(
  
  pageWithSidebar(
    
    # Application title
    headerPanel(
      h2("US legal limit of alcohol consumption calculator")
      ),
    #h5('This calculator gives an estimate of the number of standard drinks one can consume, according to the US legal limit on blood alcohol content.'),
    #h5('The number of drinks one can'),
    
    # Input
    sidebarPanel(
      numericInput('id1', 'Age (years)', 0, min = 0, max = 200, step = 1),
      numericInput('id2', 'Body weight (lb)', 0, min = 0, max = 400, step = 1),
      selectInput('id3', 'Gender', c("M","F")),
      submitButton('Calculate')
      ),
    
    # Print of output
    mainPanel(
      h3('Number of allowed standard drinks based on your profile'),
      h4('Your personal profile'),
      verbatimTextOutput("inputValue"),
      h4('Number of allowed standard drinks per hour'),
      verbatimTextOutput("outputValue"),
      h4('Documentation:'),
      h5('This calculator gives an estimation of the number of standard drinks one can consume, according to the US legal limit on blood alcohol content. The estimation is based on 3 parameters: Age, Body weight, and gender of the consumer. To use this app, enter these 3 parameters on the left side panel and click on "calculate". The result will be displayed on the main panel. '),
      h4('Note:'),
      h5('Standard drinks: Beverage containing 0.6 US fl oz (18 ml) of ethanol, e.g.'),
      h5('80 proof liquor: One shot (1.5 Oz)'),
      h5('Table wine: One glass (5 Oz)'),
      h5('Beer: One can/bottle (12 Oz)')
      )
    )
  )