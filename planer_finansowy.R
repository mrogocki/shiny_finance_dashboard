
# Creates User interface

ui <- fluidPage(
  dashboardHeader(title = "My Dashboard"), 
  tabsetPanel(
    type = "tabs",
    tabPanel("Wykres"),
    tabPanel("Dane")
  ),
  column(6,
         h2("Plan finansowy")),
  column(6,
         h4("Ustaw okres czasu ktory cie interesuje"),
         sliderInput("timeinput",
                     label = "Prosze wybrac",
                     min = min(account_data$Buchungstag),
                     max = max(account_data$Buchungstag),
                     step = 24,
                     value = c(min(account_data$Buchungstag),max(account_data$Buchungstag)))),
  br(),
  plotOutput("ts_data"),
  br(),
  br(),
  br(),
  br(),
  br(),
  column(6,
         h2("Wydatki w tym okresie", align = "center"),
         h3(textOutput("Wydatki"), align = "center", style = "color:red")
         ),
  column(6,
         h2("Doplywy w tym okresie", align = "center"),
         h3(textOutput("Wplywy"), align = "center", style = "color:green")
  ),
    
)
  
dashboardPage(
  dashboardHeader(title = "Planer finansowy"),
  dashboardSidebar(),
  dashboardBody(
    ui
  )
)

runApp("C:/Users/Lenovo/Desktop/Narzedzie Finansowe/Narzedzie_finansowe")
