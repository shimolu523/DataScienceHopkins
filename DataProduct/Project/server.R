Nsd <- function(age, Wt, gender){
  # US allowe max concentration
  EBAC <- 0.08 
  
  # Body water constant, male 0.58, female 0.49
  BW <- 0.58
  if (gender == "F"){BW <- 0.49}
  
  # metabolism rate constant
  if (age < 21){
    Nsd1hr <- "Sorry, the legal drinking age in US is 21"}
  else {
    Nsd1hr <- floor( (EBAC + 0.017*1) * BW*(Wt*0.453592) / (0.806*1.2) ) }
  return(Nsd1hr)
}


shinyServer(
  
  function(input, output) {
    output$inputValue <- renderPrint({sprintf("Age: %s, Weight: %s, Gender: %s", input$id1, input$id2, input$id3)})
    output$outputValue <- renderPrint({Nsd(input$id1,input$id2,input$id3)})
  }
)