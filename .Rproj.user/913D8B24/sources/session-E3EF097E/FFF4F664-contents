
clean_names_snake <- purrr::partial(janitor::clean_names, case = "screaming_snake")

read.csv_sep <- purrr::partial(read.csv, sep = ";")
load_clean_data <- purrr::compose(read.csv_sep, clean_names_snake, setDT, .dir = "forward")


