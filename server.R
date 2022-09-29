# Server - creates backend

server <- function(input, output){

  # Plots the time data
  output$ts_data <- renderPlot({
    ### Filter by date
    timedata <- account_data[account_data$BUCHUNGSTAG >= input$timeinput[1] & account_data$BUCHUNGSTAG <= input$timeinput[2],]
    
    ###
    ggplot(timedata, (aes(x = BUCHUNGSTAG , y = BETRAG ))) + 
      geom_ribbon(aes(ymin=pmin(timedata$BETRAG,0), ymax=0), fill="red", col="red", alpha=0.5) +
      geom_ribbon(aes(ymin=0, ymax=pmax(timedata$BETRAG,0)), fill="green", col="green", alpha=0.5) +
      geom_line(aes(y = 0))
    
  })
  
  output$Wydatki <- renderText({
    wydatki_data <- account_data[account_data$BUCHUNGSTAG >= input$timeinput[1] & account_data$BUCHUNGSTAG <= input$timeinput[2],]
    wydatki_data <- wydatki_data %>%
      filter(wydatki_data$BETRAG < 0)
    paste(sum(wydatki_data$BETRAG))
  })
  
  output$Wplywy <- renderText({
    wplywy_data <- account_data[account_data$BUCHUNGSTAG >= input$timeinput[1] & account_data$BUCHUNGSTAG <= input$timeinput[2],]
    wplywy_data <- wplywy_data %>%
      filter(wplywy_data$BETRAG > 0)
    paste(sum(wplywy_data$BETRAG))
  })
  
  output$tabela_konto <- DT::renderDT({
    account_data %>%
      select(BEGUENSTIGTER_ZAHLUNGSPFLICHTIGER:BETRAG) %>%
      group_by(BEGUENSTIGTER_ZAHLUNGSPFLICHTIGER) %>%
      summarise(BETRAG_GESAMT = sum(BETRAG)) %>%
      arrange(BETRAG_GESAMT) %>%
      filter(BEGUENSTIGTER_ZAHLUNGSPFLICHTIGER != "Michael Rogocki")
  })
  
  output$kto <- renderPlot({
    account_data %>%
      group_by(BEGUENSTIGTER_ZAHLUNGSPFLICHTIGER) %>%
      summarise(BETRAG_GESAMT = sum(BETRAG)) %>%
      arrange(BETRAG_GESAMT) %>%
      filter(BEGUENSTIGTER_ZAHLUNGSPFLICHTIGER != "Michael Rogocki") %>%
      filter(row_number()<= 5) %>%
      ggplot(aes(x=reorder(BEGUENSTIGTER_ZAHLUNGSPFLICHTIGER, -BETRAG_GESAMT), y=`BETRAG_GESAMT`)) +
        geom_bar(stat = "identity")
  })
  
  output$zrodla_plot <- renderPlotly({
    
    
    account_data_sum <- account_data[, .(BETRAG = sum(BETRAG)), by = c("BUCHUNGSTEXT")]
    fig <- plot_ly(account_data_sum,
      
      x = account_data_sum$BUCHUNGSTEXT,
      
      y = account_data_sum$BETRAG,
      
      name = "Wedlug zrodel",
      
      type = "bar"
      
    ) %>%
      layout(plot_bgcolor  = "rgba(0, 0, 0, 0)",
             paper_bgcolor = "rgba(0, 0, 0, 0)",
             fig_bgcolor   = "rgba(0, 0, 0, 0)")
  })
}