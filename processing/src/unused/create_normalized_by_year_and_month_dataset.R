create_normalized_by_year_and_month_dataset <- function(base_data, year_data, month_data) {
  # global variables
  lower <- 0
  upper <- 152

  # -------------------- EXPORT --------------------
  #                     Gewicht
  export_weight <- c()

  for (i in lower:upper) {
    export_weight[i] = base_data$Ausfuhr..Gewicht[i] / year_data$Ausfuhr..Gewicht[((i - i %% 13) / 13) + 1] / month_data$Ausfuhr..Gewicht[((i - i %% 13) / 13) + 1]
  }
  #                     Wert in €
  export_euro <- c()

  for (i in lower:upper) {
    export_euro[i] = base_data$Ausfuhr..Wert[i] / year_data$Ausfuhr..Wert[((i - i %% 13) / 13) + 1] / month_data$Ausfuhr..Wert[((i - i %% 13) / 13) + 1]
  }
  #                     Wert in $
  export_dollar <- c()

  for (i in lower:upper) {
    export_dollar[i] = base_data$Ausfuhr..Wert.1[i] / year_data$Ausfuhr..Wert.1[((i - i %% 13) / 13) + 1] / month_data$Ausfuhr..Wert.1[((i - i %% 13) / 13) + 1]
  }
  #                     Wert/Gewicht in €/t
  export_euro_weight <- c()

  for (i in lower:upper) {
    export_euro_weight[i] = base_data$Ausfuhr..Wert.Gewicht[i] / year_data$Ausfuhr..Wert.Gewicht[((i - i %% 13) / 13) + 1] / month_data$Ausfuhr..Wert.Gewicht[((i - i %% 13) / 13) + 1]
  }
  #                     Wert/Gewicht in $/t
  export_dollar_weight <- c()

  for (i in lower:upper) {
    export_dollar_weight[i] = base_data$Ausfuhr..Wert.Gewicht.1[i] / year_data$Ausfuhr..Wert.Gewicht.1[((i - i %% 13) / 13) + 1] / month_data$Ausfuhr..Wert.Gewicht.1[((i - i %% 13) / 13) + 1]
  }

  # -------------------- IMPORT --------------------
  #                     Gewicht
  import_weight <- c()

  for (i in lower:upper) {
    import_weight[i] = base_data$Einfuhr..Gewicht[i] / year_data$Einfuhr..Gewicht[((i - i %% 13) / 13) + 1] / month_data$Einfuhr..Gewicht[((i - i %% 13) / 13) + 1]
  }
  #                     Wert in €
  import_euro <- c()

  for (i in lower:upper) {
    import_euro[i] = base_data$Einfuhr..Wert[i] / year_data$Einfuhr..Wert[((i - i %% 13) / 13) + 1] / month_data$Einfuhr..Wert[((i - i %% 13) / 13) + 1]
  }
  #                     Wert in $
  import_dollar <- c()

  for (i in lower:upper) {
    import_dollar[i] = base_data$Einfuhr..Wert.1[i] / year_data$Einfuhr..Wert.1[((i - i %% 13) / 13) + 1] / month_data$Einfuhr..Wert.1[((i - i %% 13) / 13) + 1]
  }
  #                     Wert/Gewicht in €/t
  import_euro_weight <- c()

  for (i in lower:upper) {
    import_euro_weight[i] = base_data$Einfuhr..Wert.Gewicht[i] / year_data$Einfuhr..Wert.Gewicht[((i - i %% 13) / 13) + 1] / month_data$Einfuhr..Wert.Gewicht[((i - i %% 13) / 13) + 1]
  }
  #                     Wert/Gewicht in $/t
  import_dollar_weight <- c()

  for (i in lower:upper) {
    import_dollar_weight[i] = base_data$Einfuhr..Wert.Gewicht.1[i] / year_data$Einfuhr..Wert.Gewicht.1[((i - i %% 13) / 13) + 1] / month_data$Einfuhr..Wert.Gewicht.1[((i - i %% 13) / 13) + 1]
  }

  #                   Order & Jahr
  date <- c()

  for (i in lower:upper) {
    date[i] = base_data$Date.Text[1]
  }

  order <- c()

  for (i in lower:upper) {
    order[i] = i
  }

  new_dataframe <-
    data.frame(
      order,
      date,
      export_weight,
      export_euro,
      export_dollar,
      export_euro_weight,
      export_dollar_weight,
      import_weight,
      import_euro,
      import_dollar,
      import_euro_weight,
      import_dollar_weight
    )

  colnames(new_dataframe) <-
    c(
      "Order",
      "Date.Text",
      "Ausfuhr..Gewicht",
      "Ausfuhr..Wert",
      "Ausfuhr..Wert.1",
      "Ausfuhr..Wert.Gewicht",
      "Ausfuhr..Wert.Gewicht.1",
      "Einfuhr..Gewicht",
      "Einfuhr..Wert",
      "Einfuhr..Wert.1",
      "Einfuhr..Wert.Gewicht",
      "Einfuhr..Wert.Gewicht.1"
    )

  rm(
    order,
    date,
    export_weight,
    export_euro,
    export_dollar,
    export_euro_weight,
    export_dollar_weight,
    import_weight,
    import_euro,
    import_dollar,
    import_euro_weight,
    import_dollar_weight
  )
  return(new_dataframe)
}