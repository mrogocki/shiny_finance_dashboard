
ui_wykres <- tabItem(
  tabName = "wizualizacja",
  fluidRow(
         box(h2("Plan finansowy"),
         h4("Ustaw okres czasu ktory cie interesuje"),
         sliderInput("timeinput",
                     label = "Prosze wybrac",
                     min = min(account_data$BUCHUNGSTAG),
                     max = max(account_data$BUCHUNGSTAG),
                     step = 24,
                     value = c(min(account_data$BUCHUNGSTAG),max(account_data$BUCHUNGSTAG)),
                     width = "100%"),
         width = 12)),
  fluidRow(plotOutput("ts_data")),
  br(),
  fluidRow(
           box(width = 6,
            h2("Wydatki w tym okresie", align = "center"),
            h3(textOutput("Wydatki"), align = "center", style = "color:red")),
           box(width = 6,
            h2("Doplywy w tym okresie", align = "center"),
            h3(textOutput("Wplywy"), align = "center", style = "color:green"))
  )
 
)

ui_dane <- tabItem(
  tabName = "dane_tabela",
  fluidRow(
    plotOutput("kto")
  ),
  fluidRow(
    DT::DTOutput("tabela_konto")
  )
)

ui_zrodlo <- tabItem(
  tabName = "dane_zrodla",
  fluidRow(
    bs4Card(id = "zrodla_1",
    plotlyOutput("zrodla_plot"),
    width = 12,
    solidHeader = TRUE)
  )
)

ui_by_months <- tabItem(
  tabName = "dane_month",
  fluidRow(
    bs4Card(id = "miesiace",
            selectInput("select_summarizing",
                        label = "Wybieraj obroty",
                    choices = c("Wszystkie", "Negatywne", "Pozytywne")),
            plotlyOutput("zrodla_miesieczne"),
            DT::dataTableOutput("miesiaceTable"),
            width = 12,
            soldHeader = TRUE)
  )
)

ui_tabs <- tabItems(
  ui_wykres,
  ui_dane,
  ui_zrodlo,
  ui_by_months
)

sideboard <- sidebarMenu(
  menuItem("Wykres", tabName = "wizualizacja"),
  menuItem("Dane", tabName = "dane_tabela"),
  menuItem("Zrodla", tabName = "dane_zrodla"),
  menuItem("Miesiace", tabName = "dane_month")
)

dashboardPage(
  dashboardHeader(title = "Planer finansowy"),
  dashboardSidebar(
    sideboard
  ),
  dashboardBody(
    ui_tabs
  )
  )

