account_data <- read_xlsx(REL_FILE) %>%
  setDT() %>%
  .[`Beguenstigter/Zahlungspflichtiger` != NAME]
