# Server - creates backend

server <- function(input, output){
  
  # Plots the time data
  output$ts_data <- renderPlot({
    ### Filter by date
    timedata <- account_data[account_data$Buchungstag >= input$timeinput[1] & account_data$Buchungstag <= input$timeinput[2],]
    
    ###
    ggplot(timedata, (aes(x = Buchungstag , y = Betrag ))) + 
      geom_ribbon(aes(ymin=pmin(timedata$Betrag,0), ymax=0), fill="red", col="red", alpha=0.5) +
      geom_ribbon(aes(ymin=0, ymax=pmax(timedata$Betrag,0)), fill="green", col="green", alpha=0.5) +
      geom_line(aes(y = 0))
    
  })
  
  output$Wydatki <- renderText({
    wydatki_data <- account_data[account_data$Buchungstag >= input$timeinput[1] & account_data$Buchungstag <= input$timeinput[2],]
    wydatki_data <- wydatki_data %>%
      filter(wydatki_data$Betrag < 0)
    paste(sum(wydatki_data$Betrag))
  })
  
  output$Wplywy <- renderText({
    wplywy_data <- account_data[account_data$Buchungstag >= input$timeinput[1] & account_data$Buchungstag <= input$timeinput[2],]
    wplywy_data <- wplywy_data %>%
      filter(wplywy_data$Betrag > 0)
    paste(sum(wplywy_data$Betrag))
  })
  
  output$tabela_konto <- DT::renderDT({
    account_data %>%
      select(`Beguenstigter/Zahlungspflichtiger`:Betrag) %>%
      group_by(`Beguenstigter/Zahlungspflichtiger`) %>%
      summarise(Betrag_gesamt = sum(Betrag)) %>%
      arrange(Betrag_gesamt) %>%
      filter(`Beguenstigter/Zahlungspflichtiger` != NAME)
  })
  
  output$kto <- renderPlot({
    account_data %>%
      group_by(`Beguenstigter/Zahlungspflichtiger`) %>%
      summarise(Betrag_gesamt = sum(Betrag)) %>%
      arrange(Betrag_gesamt) %>%
      filter(`Beguenstigter/Zahlungspflichtiger` != NAME) %>%
      filter(row_number()<= 5) %>%
      ggplot(aes(x=reorder(`Beguenstigter/Zahlungspflichtiger`, -Betrag_gesamt), y=`Betrag_gesamt`)) +
        geom_bar(stat = "identity")
  })
}